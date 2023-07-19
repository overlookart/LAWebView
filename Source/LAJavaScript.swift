//
//  LAJavaScript.swift
//  LAWebView
//
//  Created by xzh on 2023/7/18.
//

import Foundation

private protocol JavaScriptAPI {
    var js: String { get }
    var handler: ((Any?, Error?) -> Void)? { get }
}

private protocol JavaScriptSyntax {
    var code: String { get }
}

public enum LAJavaScript {
    
    /// 获取 Element 的方式
    public enum ElementByType: JavaScriptSyntax, Equatable {
        
        
        case Id(String)
        case Name(String)
        case TagName(String)
        case ClassName(String)
        var code: String{
            switch self {
                case .Id(let id):
                    return ".getElementById('\(id)')"
                case .Name(let name):
                    return ".getElementsByName('\(name)')"
                case .TagName(let tagName):
                    return ".getElementsByTagName('\(tagName)')"
                case .ClassName(let className):
                    return ".getElementsByClassName('\(className)')"
            }
        }
    }
    
    /// 通过 tagName 获取 element
    case getElement(type:ElementByType, index: Int = 0, handler: LAJSHandler?)
    
    
    case clientWidth(handler: LAJSHandler?)
    case clientHeight(handler: LAJSHandler?)
    case scrollHeight(handler: LAJSHandler?)
    
}

public typealias LAJSHandler = ((Any?, Error?) -> Void)

extension LAJavaScript: JavaScriptAPI {
    var js: String {
        switch self {
            case .getElement(let type, let index, _):
                return "document" + type.code + (type == LAJavaScript.ElementByType.Id("") ? "" : "[\(index)]" ) + ".outerHTML"
            
            case .clientWidth(_):
                return "document.body.clientWidth"
            case .clientHeight(_):
                return "document.body.clientHeight"
            case .scrollHeight(_):
                return "document.body.scrollHeight"
            
            
        }
    }
    
    var handler: LAJSHandler? {
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
}
