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

    private lazy var testItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "test", style: .plain, target: self, action: #selector(testItemAction))
        return item
    }()
    
    private lazy var webView: WebView = {
        let webConfig = WebConfig()
        let js = """
            var meta = document.createElement('meta');
            meta.setAttribute('name', 'viewport');
            meta.setAttribute('content', 'width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no');
            document.getElementsByTagName('head')[0].appendChild(meta);
        """
        webConfig.addUserScript(script: js, injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let web = WebView(config: webConfig)
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = testItem
        webView.backgroundColor = .orange
        webView.frame = view.frame
        view.addSubview(webView)
        /// webObserves
        webView.webObserves = (Title:{ title in
            debugPrint("webObserves://title->",title)
        },Url:{ url in
            debugPrint("webObserves://:url->",url)
        },Loading:{ isLoading in
            debugPrint("webObserves://isLoading->",isLoading)
        },Progress:{ progress in
            debugPrint("webObserves://progress->",progress)
        },CanGoBack:{ canGoBack in
            debugPrint("webObserves://canGoBack->",canGoBack)
        },CanGoForward:{ canGoForward in
            debugPrint("webObserves://canGoForward->",canGoForward)
        })
        
        do {
            //https://developer.mozilla.org/zh-CN/docs/Web/API/Document
            try webView.loadUrl(urlStr: "https://www.swift.org")
        } catch  {
            debugPrint(error)
        }
        
        
        /// navigation
        webView.navigationDelegates = (DecidePolicyNavigationAction:{ navAction in
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
        },DidFailNavigation:{ nav, err in
            debugPrint("导航失败", err)
        },DidFailProvisional:{ nav, err in
            debugPrint("加载内容失败", err)
        },DidTerminate:{
            
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @objc private func testItemAction(){

        let userScript1 = LAJavaScript(value: .Let(name: "meta1"), sentence: [JS(.document), JS(.createElement,.sign("meta"))])
        let userScript2 = LAJavaScript(sentence: [JS("meta"), JS(.setAttribute, .sign("name"), .sign("viewport"))])
        let userScript3 = LAJavaScript(sentence: [JS("meta"), JS(.setAttribute, .sign("content"), .sign("width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"))])
        let userScript4 = LAJavaScript(sentence: [JS(.document), JS(.head), JS(.appendChild, JSParam("meta"))])
        let jsBlock = LAJavaScriptBlock(javaScripts: [userScript1]) { result, error in
            debugPrint(result, error)
        }
        
        webView.runJavaScript(js: jsBlock)
    }

}

