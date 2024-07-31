//
//  File.swift
//  LAWebView
//
//  Created by CaiGou on 2024/4/17.
//

import Foundation

/// 用户脚本协议
public protocol UserJavaScript {
    var js: String { get }
    var handler: LAJSHandler? { get }
}


public protocol JavaScriptSyntax {
    
    /// js 代码
    var code: String { get }
    
    /// 编码 Dom语法，适用于 Dom 元素的属性
    /// - Parameter Dom: Dom语法
    /// - Returns: 编码
    func coding(Dom: JavaScriptGrammar) -> String
    
    
    /// 编码 Dom语法，适用于 Dom 元素的方法，方法有一个或多个参数
    /// - Parameters:
    ///   - Dom: Dom: Dom 方法名
    ///   - params: Dom 方法的参数列表
    /// - Returns: 编码
    func coding(Dom: JavaScriptGrammar, params: JSParam...) -> String
    
    /// 编码 Dom语法，适用于 Dom 元素的方法，方法有参数集合
    /// - Parameters:
    ///   - Dom: Dom: Dom 方法名
    ///   - params: Dom 方法的参数集合
    /// - Returns: 编码
    func coding(Dom: JavaScriptGrammar, paramList: [JSParam]) -> String
}
