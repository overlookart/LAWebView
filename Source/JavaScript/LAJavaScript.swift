//
//  LAJavaScript.swift
//  LAWebView
//
//  Created by xzh on 2023/7/18.
//  https://developer.mozilla.org/zh-CN/docs/Web/API

import Foundation

public typealias LAJSHandler = ((Any?, Error?) -> Void)


public struct JS: JavaScriptCode {
    // 属性/方法
    var grammar: JavaScriptGrammar?
    
    // 参数
    var params: [JSParam]?
    
    private(set) var content: String
    
    /// 初始化 JS 语法
    /// - Parameters:
    ///   - grammar: 语法枚举，属性名/方法名
    ///   - paramList: 参数列表
    public init(_ grammar: JavaScriptGrammar, _ paramList: [JSParam]? = nil) {
        self.grammar = grammar
        self.content = grammar.rawValue
        self.params = paramList
    }
    
    /// 初始化 JS 语法
    /// - Parameters:
    ///   - grammar: 语法枚举，属性名/方法名
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
    
    public var code: String {
        content + JsHelp.makeParamList(params)
    }
}

public struct LAJavaScript: UserJavaScript {
    public var value: JSValue?
    // 语句
    public var sentence: [JavaScriptCode]
    // 最终的 js 脚本
    public var code: String {
        return makeJS(sentence)
    }
    // 执行处理
    public var handler: LAJSHandler?
    
    
    /// 初始化脚本
    /// - Parameters:
    ///   - sentence: javascript 语句
    ///   - handler: 处理回调
    public init(value: JSValue? = nil, sentence: [JavaScriptCode], handler: LAJSHandler? = nil) {
        self.value = value
        self.sentence = sentence
        self.handler = handler
    }
    
    
    /// 生成 javascript 脚本
    /// - Parameter js: js
    /// - Returns: javascript str
    public func makeJS(_ js: [JavaScriptCode]) -> String {
        let name = value?.code ?? ""
        let str = name + js.map{ $0.code }.joined(separator: ".") + ";"
        debugPrint("js:\(str)")
        return str
    }
}



public struct LAJavaScriptBlock: UserJavaScript {
    
    public var javaScripts: [JavaScriptCode] = []
    
    public var code: String {
        let str = JsHelp.makeCodeList(javaScripts)
        debugPrint("js block:", str)
        return str
    }
    
    public var handler: LAJSHandler?
    
    public init(javaScripts: [JavaScriptCode], handler: LAJSHandler? = nil) {
        self.javaScripts = javaScripts
        self.handler = handler
    }
}

