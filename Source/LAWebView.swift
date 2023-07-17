//
//  TabWebView.swift
//  LookArt
//
//  Created by xzh on 2021/2/12.
//

import UIKit
import WebKit
open class LAWebView: BaseWebView {
    //配置组件
    private(set) var configComponent: WebConfigComponent?
    //脚本组件
    private(set) var scriptComponent: WebScriptComponent?
    //web UI 组件
    private(set) var webUIComponent: WebUIComponent?
    
    /// 开始拖动时的offset
    private(set) var scrollBeginDragOffset: CGPoint = CGPoint.zero
    /// 当前的offset
    private(set) var scrollContentOffset: CGPoint = CGPoint.zero
    /// 滑动代理
    
    public var scrollDelegates: (
        DidScroll:(() -> Void)?,
        BeginDragging:(() -> Void)?,
        WillEndDragging:((CGPoint) -> Void)?,
        EndDragging:(() -> Void)?,
        BeginDecelerating:(() -> Void)?,
        EndDecelerating:(() -> Void)?,
        DidScrollToTop:(() -> Void)?)?
    
    /// web导航代理
    public var navigationDelegates: (
        DecidePolicyNavigationAction:((WKNavigationAction) -> WKNavigationActionPolicy)?,
        DidStartNavigation:((WKNavigation) -> Void)?,
        DecidePolicyNavigationResponse:((WKNavigationResponse) -> WKNavigationResponsePolicy)?,
        DidCommitNavigation:((WKNavigation) -> Void)?,
        DidReceiveServerRedirect:((WKNavigation) -> Void)?,
        DidReceiveAuthChallenge:(() -> (AuthChallenge:URLSession.AuthChallengeDisposition,Credential:URLCredential?))?,
        DidFinishNavigation:((WKNavigation) -> Void)?,
        DidFailNavigation:((WKNavigation, Error) -> Void)?,
        DidFailProvisional:((WKNavigation, Error) -> Void)?,
        DidTerminate:(() -> Void)?)?{
        
        didSet {
            if navigationDelegates != nil {
                self.navigationDelegate = self
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    /// 初始化方法
    /// - Parameters:
    ///   - config: 配置组件
    ///   - script: 脚本组件
    convenience public init(config: WebConfigComponent, script: WebScriptComponent? = nil, webUI: WebUIComponent? = nil) {
        self.init(frame: CGRect.zero, configuration: config)
        self.configComponent = config
        self.scriptComponent = script
        self.webUIComponent = webUI
        
        if let _ = self.scriptComponent, let _ = self.configComponent {
            self.scriptComponent?.setupScripts(userContentController: self.configComponent!.userContentController)
        }
        if let _ = self.webUIComponent {
            self.uiDelegate = self.webUIComponent
        }
        
    }
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LAWebView: UIScrollViewDelegate {
    /// 滑动中
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollContentOffset = scrollView.contentOffset
        self.scrollDelegates?.DidScroll?()
    }
    
    /// 开始拖拽
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollBeginDragOffset = scrollView.contentOffset
        self.scrollDelegates?.BeginDragging?()
    }
    ///将要结束拖拽
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.scrollDelegates?.WillEndDragging?(velocity)
    }
    
    /// 结束拖拽
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.scrollDelegates?.EndDragging?()
    }
    /// 开始减速
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.scrollDelegates?.BeginDecelerating?()
    }
    /// 停止减速
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollDelegates?.EndDecelerating?()
          
    }
    
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.scrollDelegates?.DidScrollToTop?()
    }
}

extension LAWebView: WKNavigationDelegate {
    
    /// Web是否允许导航
    /// - Parameters:
    ///   - webView: webView
    ///   - navigationAction: 有关触发导航请求的操作的描述性信息
    ///   - decisionHandler: Web决定是允许还是取消导航时要调用闭包
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let decidePolicy = navigationDelegates?.DecidePolicyNavigationAction else { decisionHandler(.allow); return }
        decisionHandler(decidePolicy(navigationAction))
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let didStart = navigationDelegates?.DidStartNavigation else { return }
        didStart(navigation)
    }
    
    /// Web收到响应后是否允许导航
    /// - Parameters:
    ///   - webView: webView
    ///   - navigationResponse: 有关导航响应的描述性信息
    ///   - decisionHandler: Web决定是允许还是取消导航时要调用闭包
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let decidePolicy = navigationDelegates?.DecidePolicyNavigationResponse else { decisionHandler(.allow); return }
        decisionHandler(decidePolicy(navigationResponse))
    }
    
    /// Web开始接收内容 响应服务器操作
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: 开始加载页面的导航对象
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        guard let didcommit = navigationDelegates?.DidCommitNavigation else { return }
        didcommit(navigation)
    }
    
    /// Web视图收到服务器重定向 响应服务器操作
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: 接收到服务器重定向的导航对象
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let didReceiveServerRedirect = navigationDelegates?.DidReceiveServerRedirect else { return }
        didReceiveServerRedirect(navigation)
    }
    
    /// Web需要响应身份验证
    /// - Parameters:
    ///   - webView: webView
    ///   - challenge: 身份验证
    ///   - completionHandler: <#completionHandler description#>
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let didReceiveAuthChallenge = navigationDelegates?.DidReceiveAuthChallenge else { completionHandler(.rejectProtectionSpace,nil); return }
        let handler = didReceiveAuthChallenge()
        completionHandler(handler.AuthChallenge,handler.Credential)
    }
    
    /// Web加载完成
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: navigation
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let didfinish = navigationDelegates?.DidFinishNavigation else { return }
        didfinish(navigation)
    }
    
    /// Web导航期间发生错误
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: navigation
    ///   - error: error
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        guard let didfail = navigationDelegates?.DidFailNavigation else { return }
        didfail(navigation, error)
    }
    
    /// Web加载内容时发生错误
    /// - Parameters:
    ///   - webView: webView
    ///   - navigation: navigation
    ///   - error: error
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        guard let didfail = navigationDelegates?.DidFailProvisional else { return }
        didfail(navigation, error)
    }
    
    /// Web内容终止
    /// - Parameter webView: webView
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        guard let didTerminate = navigationDelegates?.DidTerminate else { return }
        didTerminate()
    }
    
}

@available(iOS 13.0, *)
extension LAWebView {
    public func viewpointSnapshot() async -> UIImage? {
        let config = WKSnapshotConfiguration()
        config.rect = frame
        let img = try? await self.takeSnapshot(configuration: config)
        if img != nil {
            debugPrint("页面快照")
        }
        return img
    }
}

