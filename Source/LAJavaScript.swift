//
//  LAJavaScript.swift
//  LAWebView
//
//  Created by xzh on 2023/7/18.
//

import Foundation

public typealias LAJSHandler = ((Any?, Error?) -> Void)

public protocol JavaScriptAPI {
    var js: String { get }
    var handler: LAJSHandler? { get }
    func makeJS(_ documentApis: DocumentApi...) -> String
}


private protocol JavaScriptSyntax {
    var code: String { get }
}


/// Dom 语法
public enum DocumentApi {
    case window
    case document
    case body
    case head
    case getElementById(String)
    case getElementsByName(String)
    case getElementsByTagName(String)
    case getElementsByClassName(String)
    case item(UInt)
    case clientWidth
    case clientHeight
    case scrollHeight
    case outerHTML
}

extension DocumentApi: JavaScriptSyntax {
    var code: String {
        switch self {
            case .window: return "window"
            case .document: return "document"
            case .body: return "body"
            case .head: return "head"
            case .getElementById(let id): return "getElementById('\(id)')"
            case .getElementsByName(let name): return "getElementsByName('\(name)')"
            case .getElementsByTagName(let tagName): return "getElementsByTagName('\(tagName)')"
            case .getElementsByClassName(let className): return "getElementsByClassName('\(className)')"
            case .item(let index): return "item(\(index))"
            case .clientWidth: return "clientWidth"
            case .clientHeight: return "clientHeight"
            case .scrollHeight: return "scrollHeight"
            case .outerHTML: return "outerHTML"
        }
    }
}




/// js 代码片段
public enum LAJSSnippet {
    
    /// 获取 Element 的方式
    public enum ElementByType {
        case Id(String)
        case Name(String)
        case TagName(String)
        case ClassName(String)
        
    }
    
    /// 通过 tagName 获取 element
    case getElement(type:ElementByType, index: UInt = 0, handler: LAJSHandler?)
    case clientWidth(handler: LAJSHandler?)
    case clientHeight(handler: LAJSHandler?)
    case scrollHeight(handler: LAJSHandler?)
    
}



extension LAJSSnippet: JavaScriptAPI {
    public var js: String {
        switch self {
            case .getElement(let type, let index, _):
                
            if case .Id(let id) = type {
                return makeJS(.document,.getElementById(id),.outerHTML)
            }else if case .Name(let name) = type {
                return makeJS(.document,.getElementsByName(name),.item(index),.outerHTML)
            }else if case .TagName(let tagName) = type {
                return makeJS(.document,.getElementsByTagName(tagName),.item(index),.outerHTML)
            }else if case .ClassName(let className) = type {
                return makeJS(.document,.getElementsByClassName(className),.item(index),.outerHTML)
            }
            return ""
            
            
            case .clientWidth(_):
                return makeJS(.document,.body,.clientWidth)
            case .clientHeight(_):
                return makeJS(.document,.body,.clientHeight)
            case .scrollHeight(_):
                return makeJS(.document,.body,.scrollHeight)
        }
    }
    
    public var handler: LAJSHandler? {
        switch self {
            case .getElement(_, _, let handler):
                return handler
            case .clientWidth(let handler):
                return handler
            case .clientHeight(let handler):
                return handler
            case .scrollHeight(let handler):
                return handler
        }
    }
    
    public func makeJS(_ documentApis: DocumentApi...) -> String {
         let str =  documentApis.map{ $0.code }.joined(separator: ".")
        print("abc",str)
        return str
    }
}
