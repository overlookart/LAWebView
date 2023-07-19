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
//snippets
private protocol JavaScriptSyntax {
    var code: String { get }
}


enum DomSyntaxTree: String {
    case body = ".body"
    case head = ".head"
}

/// element api
private protocol DocumentAPI {
    
}

typealias DomApiSyntax = String

extension DocumentAPI {
    
    var document: DomApiSyntax {
        return "document"
    }
    
    func getElementBy(Id id: String) -> DomApiSyntax {
        return ".getElementById('\(id)')"
    }
    
    func getElementBy(Name name: String) -> DomApiSyntax {
        return ".getElementsByName('\(name)')"
    }
    
    func getElementBy(TagName tagName: String) -> DomApiSyntax {
        return ".getElementsByTagName('\(tagName)')"
    }
    
    func getElementBy(ClassName className: String) -> DomApiSyntax{
        return ".getElementsByClassName('\(className)')"
    }
}

public enum Element{
    case body
    case head
}

/// js 代码片段
public enum LAJSSnippet {
    
    /// 获取 Element 的方式
    public enum ElementByType: JavaScriptSyntax {
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

extension LAJSSnippet: JavaScriptAPI {
    var js: String {
        switch self {
            case .getElement(let type, let index, _):
                var j = "document" + type.code
            if case .Id = type {

            }else{
                j = j + "[\(index)]"
            }
            j = j + ".outerHTML"
                return j
            
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
