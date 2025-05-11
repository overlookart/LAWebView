//
//  JSValue.swift
//  LAWebView
//
//  Created by xzh on 5/11/25.
//  JavaScript 值类型枚举

import Foundation

public enum JSValue: JavaScriptValue {
    public var name: String {
        switch self {
        case .Var(let name):
            return name
        case .Let(let name):
            return name
        case .Const(let name):
            return name
        }
    }
    
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
