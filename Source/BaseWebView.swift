//
//  BaseWebView.swift
//  DaoSample
//
//  Created by MoYing on 2020/11/21.
//

import UIKit
import WebKit

// MARK: - webview监听枚举
private enum WebObserve {
    case title
    case url
    case loading
    case progress
    case canGoBack
    case canGoForward
    
    var keyStr: String {
        switch self {
            case .title: return "title"
            case .url: return "URL"
            case .loading: return "loading"
            case .progress: return "estimatedProgress"
            case .canGoBack: return "canGoBack"
            case .canGoForward: return "canGoForward"
        }
    }
}

open class BaseWebView: WKWebView {
    
    /// 开始拖动时的offset
    private(set) var scrollBeginDragOffset: CGPoint = CGPoint.zero
    /// 当前的offset
    private(set) var scrollContentOffset: CGPoint = CGPoint.zero
    
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
    
    private var webTitle: ((String) -> Void)?
    private var webUrl: ((URL?) -> Void)?
    private var webLoading: ((Bool) -> Void)?
    private var webProgress: ((Float) -> Void)?
    private var webCanGoBack: ((Bool) -> Void)?
    private var webCanGoForward: ((Bool) -> Void)?
    
    public var webObserves: (Title:((String) -> Void)?, Url:((URL?) -> Void)?, Loading:((Bool) -> Void)?, Progress:((Float) -> Void)?, CanGoBack:((Bool) -> Void)?, CanGoForward:((Bool) -> Void)?)? {
        didSet {
            if let webtitle = webObserves?.Title {
                if let _ = webTitle {
                    self.removeObserver(self, forKeyPath: WebObserve.title.keyStr)
                }
                webTitle = webtitle
                self.addObserver(self, forKeyPath: WebObserve.title.keyStr, options: .new, context: nil)
            }
            
            if let weburl = webObserves?.Url {
                if let _ = webUrl {
                    self.removeObserver(self, forKeyPath: WebObserve.url.keyStr)
                }
                webUrl = weburl
                self.addObserver(self, forKeyPath: WebObserve.url.keyStr,options: .new, context: nil)
            }
            
            if let webloading = webObserves?.Loading {
                if let _ = webLoading {
                    self.removeObserver(self, forKeyPath: WebObserve.loading.keyStr)
                }
                webLoading = webloading
                self.addObserver(self, forKeyPath: WebObserve.loading.keyStr, options: .new, context: nil)
            }
            
            if let webprogress = webObserves?.Progress {
                if let _ = webProgress {
                    self.removeObserver(self, forKeyPath: WebObserve.progress.keyStr)
                }
                webProgress = webprogress
                self.addObserver(self, forKeyPath: WebObserve.progress.keyStr, options: .new, context: nil)
            }
            
            if let webcangoback = webObserves?.CanGoBack {
                if let _ = webCanGoBack {
                    self.removeObserver(self, forKeyPath: WebObserve.canGoBack.keyStr)
                }
                webCanGoBack = webcangoback
                self.addObserver(self, forKeyPath: WebObserve.canGoBack.keyStr, options: .new, context: nil)
            }
            
            if let webcangoforward = webObserves?.CanGoForward {
                if let _ = webCanGoForward {
                    self.removeObserver(self, forKeyPath: WebObserve.canGoForward.keyStr)
                }
                webCanGoForward = webcangoforward
                self.addObserver(self, forKeyPath: WebObserve.canGoForward.keyStr, options: .new, context: nil)
            }
        }
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == WebObserve.progress.keyStr {
            webProgress?(Float(self.estimatedProgress))
        }else if keyPath == WebObserve.title.keyStr {
            webTitle?(self.title ?? "Null")
        }else if keyPath == WebObserve.url.keyStr {
            webUrl?(self.url)
        }else if keyPath == WebObserve.loading.keyStr {
            webLoading?(self.isLoading)
        }else if keyPath == WebObserve.canGoBack.keyStr {
            webCanGoBack?(self.canGoBack)
        }else if keyPath == WebObserve.canGoForward.keyStr {
            webCanGoForward?(self.canGoForward)
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if let _ = webProgress {
            self.removeObserver(self, forKeyPath: WebObserve.progress.keyStr)
        }
        
        if let _ = webTitle {
            self.removeObserver(self, forKeyPath: WebObserve.title.keyStr)
        }
        
        if let _ = webUrl {
            self.removeObserver(self, forKeyPath: WebObserve.url.keyStr)
        }
        
        if let _ = webLoading {
            self.removeObserver(self, forKeyPath: WebObserve.loading.keyStr)
        }
        
        if let _ = webCanGoBack {
            self.removeObserver(self, forKeyPath: WebObserve.canGoBack.keyStr)
        }
        
        if let _ = webCanGoForward {
            self.removeObserver(self, forKeyPath: WebObserve.canGoForward.keyStr)
        }
    }
}

// MARK: WKNavigationDelegate
extension BaseWebView: WKNavigationDelegate {
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




