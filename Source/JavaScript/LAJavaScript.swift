//
//  LAJavaScript.swift
//  LAWebView
//
//  Created by xzh on 2023/7/18.
//  https://developer.mozilla.org/zh-CN/docs/Web/API

import Foundation

public typealias LAJSHandler = ((Any?, Error?) -> Void)


public struct JS {
    var grammar: JavaScriptGrammar?
    var content: String
    var params: [JSParam]?
    
    /// 初始化 JS 语法
    /// - Parameters:
    ///   - syntax: 语法枚举，属性名/方法名
    ///   - paramList: 参数列表
    public init(_ grammar: JavaScriptGrammar, _ paramList: [JSParam]? = nil) {
        self.grammar = grammar
        self.content = grammar.rawValue
        self.params = paramList
    }
    
    /// 初始化 JS 语法
    /// - Parameters:
    ///   - syntax: 语法枚举，属性名/方法名
    ///   - params: 可变参数列表
    public init(_ grammar: JavaScriptGrammar, _ params: JSParam...) {
        self.grammar = grammar
        self.content = grammar.rawValue
        self.params = params
    }
    
    /// 初始化 JS 语法
    /// - Parameters:
    ///   - grammar: 自定义文法，属性名/方法名
    ///   - params: 参数列表
    public init(_ content: String, _ params: [JSParam]? = nil){
        self.content = content
        self.params = params
    }
    
    /// 初始化 JS 语法
    /// - Parameters:
    ///   - grammar: 自定义文法，属性名/方法名
    ///   - params: 可变参数列表
    public init(_ content: String, _ params: JSParam...){
        self.content = content
        self.params = params
    }
    
    /// 构造参数列表
    /// - Parameter params: 原始参数
    /// - Returns: 参数列表
    private func makeParamList(_ params: [JSParam]?) -> String {
        guard let ps = params else { return "" }
        return "(\(ps.map({ $0.finalValue }).joined(separator: ",")))"
    }
}

extension JS: JavaScriptSyntax {
    public var code: String {
        content + makeParamList(params)
    }
    
    public func coding(Dom: JavaScriptGrammar) -> String {
        return content
    }
    
    public func coding(Dom: JavaScriptGrammar, params: JSParam...) -> String {
        return ""
    }
    
    public func coding(Dom: JavaScriptGrammar, paramList: [JSParam]) -> String {
        return ""
    }
    
    
}

/// JavaScript 参数结构体
public struct JSParam {
    private var rawValue: String
    private var isStr: Bool = false
    var finalValue: String {
        return isStr ? "'\(rawValue)'" : rawValue
    }
    init(_ rawValue: String, _ isStr: Bool = false) {
        self.rawValue = rawValue
        self.isStr = isStr
    }
    
    /// 创建一个字符化的参数
    /// - Parameter rawValue: 原始值
    /// - Returns: 字符化的参数
    public static func sign(_ rawValue: String) -> JSParam {
        JSParam(rawValue, true)
    }
}

public struct LAJSSentence: UserJavaScript {
    public var sentence: [JS]
    public var js: String {
        return makeJS(sentence)
    }
    public var handler: LAJSHandler?
    
    public init(sentence: [JS], handler: LAJSHandler? = nil) {
        self.sentence = sentence
        self.handler = handler
    }
    
    public func makeJS(_ js: [JS]) -> String {
         let str =  js.map{ $0.code }.joined(separator: ".") + ";"
        debugPrint("javascript://\(str)")
        return str
    }
}

