//
//  LAJavaScript.swift
//  LAWebView
//
//  Created by xzh on 2023/7/18.
//  https://developer.mozilla.org/zh-CN/docs/Web/API

import Foundation

public typealias LAJSHandler = ((Any?, Error?) -> Void)


public struct JS {
    // 属性/方法体
    var body: JavaScriptGrammar?
    
    // 参数
    var params: [JSParam]?
    
    private(set) var content: String
    
    /// 初始化 JS 语法
    /// - Parameters:
    ///   - grammar: 语法枚举，属性名/方法名
    ///   - paramList: 参数列表
    public init(_ body: JavaScriptGrammar, _ paramList: [JSParam]? = nil) {
        self.body = body
        self.content = body.rawValue
        self.params = paramList
    }
    
    /// 初始化 JS 语法
    /// - Parameters:
    ///   - grammar: 语法枚举，属性名/方法名
    ///   - params: 可变参数列表
    public init(_ body: JavaScriptGrammar, _ params: JSParam...) {
        self.body = body
        self.content = body.rawValue
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
}

/// JavaScript 参数结构体
public struct JSParam {
    private var rawValue: String
    private var isStr: Bool = false
    var finalValue: String {
        return isStr ? "'\(rawValue)'" : rawValue
    }
    public init(_ rawValue: String, _ isStr: Bool = false) {
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

/// JavaScript 值类型枚举
public enum JSValue: JavaScriptSyntax {
    case Var(name: String)
    case Let(name: String)
    case Const(name: String)
    
    public var code: String {
        switch self {
        case .Var(let name):
            return "var \(name) = "
        case .Let(let name):
            return "let \(name) = "
        case .Const(let name):
            return "const \(name) = "
        }
    }
}

public struct LAJavaScript: UserJavaScript {
    public var value: JSValue?
    // 语句
    public var sentence: [JS]
    // 最终的 js 脚本
    public var js: String {
        return makeJS(sentence)
    }
    // 执行处理
    public var handler: LAJSHandler?
    
    
    /// 初始化脚本
    /// - Parameters:
    ///   - sentence: javascript 语句
    ///   - handler: 处理回调
    public init(value: JSValue? = nil, sentence: [JS], handler: LAJSHandler? = nil) {
        self.value = value
        self.sentence = sentence
        self.handler = handler
    }
    
    
    /// 生成 javascript 脚本
    /// - Parameter js: js
    /// - Returns: javascript str
    public func makeJS(_ js: [JS]) -> String {
        let name = value?.code ?? ""
        let str = name + js.map{ $0.code }.joined(separator: ".") + ";"
        debugPrint("js:\(str)")
        return str
    }
}

public struct LAJavaScriptBlock: UserJavaScript {
    
    public var javaScripts: [LAJavaScript] = []
    
    public var js: String {
        return makeJS(javaScripts)
    }
    
    
    public var handler: LAJSHandler?
    
    public init(javaScripts: [LAJavaScript], handler: LAJSHandler? = nil) {
        self.javaScripts = javaScripts
        self.handler = handler
    }
    
    public func makeJS(_ js:[LAJavaScript]) -> String {
        let makejs = js.map{ $0.js }.joined(separator: "\n")
        
        debugPrint("js block:\(makejs)")
        return makejs
    }
}

