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
    private(set) var config: WebConfig?
    //web UI 组件
    private(set) var webUIComponent: WebUIComponent?
    
    
    
    
    
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
    convenience public init(config: WebConfig, webUI: WebUIComponent? = nil) {
        self.init(frame: CGRect.zero, configuration: config)
        self.config = config
        self.webUIComponent = webUI
        
        if let _ = self.webUIComponent {
            self.uiDelegate = self.webUIComponent
        }
        
    }
    public init(config: WebConfig) {
        super.init(frame: .zero, configuration: config)
    }
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)

    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension LAWebView {
    
    //MARK: - load
    
    public func loadUrl(urlStr: String, cachePolicy:URLRequest.CachePolicy = .useProtocolCachePolicy, timeout: TimeInterval = 60.0) throws {
        var urls: String = ""
        /// url 编码
        if let str = urlStr.removingPercentEncoding {
            urls = str.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
        }else{
            urls = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
        }
        // 还原被编码的“#”
        urls = urls.replacingOccurrences(of: "%23", with: "#")
        guard let url = URL(string: urls) else { throw URLError(.badURL) }
        load(URLRequest(url: url))
    }
    
    public func runJavaScript(js: UserJavaScript){
        self.evaluateJavaScript(js.js, completionHandler: js.handler)
    }
    
    
    
    @available(iOS 13.0, *)
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

