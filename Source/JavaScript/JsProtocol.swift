//
//  File.swift
//  LAWebView
//
//  Created by CaiGou on 2024/4/17.
//

import Foundation

/// 用户脚本协议
public protocol UserJavaScript {
    // 最终 js 脚本
    var js: String { get }
    // 执行处理
    var handler: LAJSHandler? { get }
}

// js 脚本语法协议
public protocol JavaScriptSyntax {
    
    /// js 代码
    var code: String { get }
    
    /// 编码 语法
    /// - Parameter JSG: js 语法
    /// - Returns: 编码
//    func coding(JSG: JavaScriptGrammar) -> String
    
    
    /// 编码 语法，适用于方法，方法有一个或多个参数
    /// - Parameters:
    ///   - JSG: js 方法名
    ///   - params: 方法的参数列表
    /// - Returns: 编码
//    func coding(JSG: JavaScriptGrammar, params: JSParam...) -> String
    
    /// 编码 语法，适用于方法，方法有参数集合
    /// - Parameters:
    ///   - JSG: js 方法名
    ///   - params: 方法的参数集合
    /// - Returns: 编码
//    func coding(JSG: JavaScriptGrammar, paramList: [JSParam]) -> String
    
}
