//
//  WebView.swift
//  LAWebViewDemo
//
//  Created by xzh on 2023/7/31.
//

import Foundation
import LAWebView
class WebView: LAWebView {
    override init(config: WebConfig) {
        super.init(config: config)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
