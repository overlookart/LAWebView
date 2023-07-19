//
//  ViewController.swift
//  LAWebView
//
//  Created by CaiGou on 2023/7/17.
//

import UIKit
import LAWebView
import WebKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let web = LAWebView(config: WebConfigComponent())
        web.backgroundColor = .orange
        web.frame = view.frame
        view.addSubview(web)
        
        
        /// webObserves
        web.webObserves = (Title:{ title in
            debugPrint("web->title:",title)
        },Url:{ url in
            debugPrint("web->url:",url)
        },Loading:{ isLoading in
            debugPrint("web->isLoading:",isLoading)
        },Progress:{ progress in
            debugPrint("web->progress:",progress)
        },CanGoBack:{ canGoBack in
            debugPrint("web->canGoBack:",canGoBack)
        },CanGoForward:{ canGoForward in
            debugPrint("web->canGoForward:",canGoForward)
        })
        
        do {
            //https://developer.mozilla.org/zh-CN/docs/Web/API/Document
            try web.loadUrl(urlStr: "https://swift.gg")
        } catch  {
            debugPrint(error)
        }
        
        
        /// 滚动代理
        web.scrollDelegates = (DidScroll:{
            debugPrint("滑动中...")
        },BeginDragging:{
            debugPrint("开始拖拽")
        },WillEndDragging:{ point in
            debugPrint("将要结束拖拽")
        },EndDragging:{
            debugPrint("结束拖拽")
        },BeginDecelerating:{
            debugPrint("开始减速")
        },EndDecelerating:{
            debugPrint("停止减速")
        },DidScrollToTop:{
            debugPrint("滑动到顶部")
        })
        
        /// navigation
        web.navigationDelegates = (DecidePolicyNavigationAction:{ navAction in
            debugPrint("是否允许导航")
            return WKNavigationActionPolicy.allow
        },DidStartNavigation:{ nav in
            debugPrint("开始导航")
        },DecidePolicyNavigationResponse:{ navResponse in
            debugPrint("是否允许请求")
            return WKNavigationResponsePolicy.allow
        },DidCommitNavigation:{ nav in
            
        },DidReceiveServerRedirect: { nav in
            
        },DidReceiveAuthChallenge: {
            return (AuthChallenge:URLSession.AuthChallengeDisposition.rejectProtectionSpace,Credential: nil)
        },DidFinishNavigation: { nav in
            debugPrint("导航完成")
            web.runJavaScript(js: .getElement(type: .Id("Playground"), handler: { result, error in
                debugPrint(result,error)
            }))
        },DidFailNavigation:{ nav, err in
            debugPrint("导航失败", err)
        },DidFailProvisional:{ nav, err in
            debugPrint("加载内容失败", err)
        },DidTerminate:{
            
        })
    }


}

