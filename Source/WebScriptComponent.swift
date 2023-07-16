//
//  WebScriptComponent.swift
//  LookArt
//
//  Created by xzh on 2021/7/24.
//

import Foundation
import WebKit
public class WebScriptComponent: NSObject {
    var scripts: [LAUserScript] = []
    
    /// 配置脚本
    /// - Parameter userContentController: userContentController description
    func setupScripts(userContentController: WKUserContentController) {
        for script in scripts {
            userContentController.addUserScript(script)
            if let messageName = script.messageName {
                userContentController.removeScriptMessageHandler(forName: messageName)
                userContentController.add(self, name: messageName)
            }
        }
    }
    
    /// 删除所有用户脚本
    /// - Parameter userContentControll: userContentControll description
    func removeAllScripts(userContentControll: WKUserContentController) {
        userContentControll.removeAllUserScripts()
    }
}

// js window.webkit.messageHandlers.xxx.postMessage() 调用
extension WebScriptComponent: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name, message.body)
    }
}


// 脚本协议
protocol WebScriptProtocol {
    // 脚本名称
    var scriptName: String? {get}
    // 作者名称
    var authorName: String? {get}
    // 版本号
    var versionNum: String? {get}
    // 脚本描述
    var describe: String? {get}
}

class LAUserScript: WKUserScript, WebScriptProtocol {
    var scriptName: String?
    
    var authorName: String?
    
    var versionNum: String?
    
    var describe: String?
    
    // js 发送 messageHandlers 的名称
    var messageName: String?
    
    ///
    /// - Parameters: 初始化脚本方法
    ///   - source: 源代码
    ///   - injectionTime: 注入时机
    ///   - forMainFrameOnly: 是否仅在主 frame 启用
    ///   - messageName: js 发送 messageHandlers 的名称
    init(source: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool, messageName: String? = nil) {
        super.init(source: source, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly)
        self.messageName = messageName
    }
    
    /// 初始化脚本方法
    /// - Parameters:
    ///   - fileURL: js 脚本文件路径
    ///   - injectionTime: 注入时机
    ///   - forMainFrameOnly: 是否仅在主 frame 启用
    ///   - messageName: js 发送 messageHandlers 的名称
    init(fileURL: URL, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool, messageName: String? = nil) {
        var source = ""
        if let data = try? Data(contentsOf: fileURL), let str = String(data: data, encoding: .utf8) {
            source = str
        }
        super.init(source: source, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly)
        self.messageName = messageName
    }
    
    @available(iOS 14.0, *)
    override init(source: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool, in contentWorld: WKContentWorld) {
        super.init(source: source, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly, in: contentWorld)
    }
}




