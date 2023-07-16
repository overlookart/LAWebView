//
//  WebUIComponent.swift
//  LookArt
//
//  Created by CaiGou on 2021/11/9.
//

import Foundation
import WebKit
class WebUIComponent: NSObject {
    
}

// js alert, input,  UI 调用
extension WebUIComponent: WKUIDelegate {
    /// 创建 webview
    /// - Parameters:
    ///   - webView: 调用委托方法的 WebView
    ///   - configuration: 创建新 Webview 时要使用的配置
    ///   - navigationAction: 导致创建新 Webview 的导航操作
    ///   - windowFeatures: 网页请求的窗口功能
    /// - Returns: 必须使用指定的配置创建返回的 Web 视图 WebKit 在返回的 Web 视图中加载请求
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("创建 webview")
        return WKWebView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), configuration: configuration)
        return nil
    }
    
    /// 通知您的应用 DOM 窗口已成功关闭
    /// - Parameter webView: 调用委托方法的 WebView
    /// 您的应用程序应该从视图层次结构中删除 Web 视图并根据需要更新 UI
    /// 例如通过关闭包含的浏览器选项卡或窗口
    func webViewDidClose(_ webView: WKWebView) {
        
    }
    
    /// 显示包含指定消息的 JavaScript 警报面板
    /// - Parameters:
    ///   - webView: 调用委托方法的 WebView
    ///   - message: 要显示的消息
    ///   - frame: 有关其 JavaScript 进程发起此调用的框架的信息
    ///   - completionHandler: 关闭警报面板后调用的完成处理程序
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    /// 显示带有指定消息的 JavaScript 确认面板
    /// - Parameters:
    ///   - webView: 调用委托方法的 WebView
    ///   - message: 在确认面板中显示的消息
    ///   - frame: 其 JavaScript 发起此调用的 Web 框架
    ///   - completionHandler: 在确认面板被解除后调用的完成处理程序。 如果用户选择 OK 则传递 true，如果用户选择 Cancel 则传递 false
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    /// 显示 JavaScript 文本输入面板
    /// - Parameters:
    ///   - webView: 调用委托方法的 WebView
    ///   - prompt: 要显示的消息
    ///   - defaultText: 要在文本输入字段中显示的初始文本
    ///   - frame: 有关其 JavaScript 进程发起此调用的框架的信息
    ///   - completionHandler: 在文本输入面板被关闭后调用的完成处理程序。 如果用户选择 OK，则传递输入的文本，否则 nil
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print(prompt);
        if prompt == "_ThemeConfig_" {
            let theme = LookArtData.settingTheme()
            var isNight = "false"
            var isNightDark = "false"
            var isDark = "false"
            if theme == .Dark {
                isNight = "true"
                isNightDark = "true"
                isDark = "true"
            }
            if theme == .NigthDark {
                isNightDark = "true"
                isNight = "true"
            }
            if theme == .Night {
                isNight = "true"
            }
            let themestr = "\(isNight)==\(isNightDark)==\(theme == ThemeType.Green)==\(isDark)"
            print(themestr)
            completionHandler(themestr)
        }
    }
}
