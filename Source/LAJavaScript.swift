//
//  LAJavaScript.swift
//  LAWebView
//
//  Created by xzh on 2023/7/18.
//  https://developer.mozilla.org/zh-CN/docs/Web/API

import Foundation

public typealias LAJSHandler = ((Any?, Error?) -> Void)

private protocol JavaScriptAPI {
    var js: String { get }
    var handler: LAJSHandler? { get }
    func makeJS(_ documentApis: DocumentApi...) -> String
}


private protocol JavaScriptSyntax {
    var code: String { get }
}


/// Dom 语法
enum DocumentApi {
    case window
    case document
    case body
    case head
    case getElementById(String)
    case getElementsByName(String)
    case item(UInt)
    
    
    
    case createElement(String)
    case appendChild(String)
    
    // Element API
    /// 表示一个元素的左边框的宽度
    case clientLeft
    /// 一个元素顶部边框的宽度
    case clientTop
    /// 一个元素宽度
    case clientWidth
    /// 一个元素高度
    case clientHeight
    /// 读取或设置元素滚动条到元素左边的距离
    case scrollLeft
    /// 获取或设置一个元素的内容垂直滚动的像素值
    case scrollTop
    /// 元素内容宽度
    case scrollWidth
    /// 元素内容高度
    case scrollHeight
    case attributes
    /// 元素的子元素个数
    case childElementCount
    /// 元素的子元素集合
    case children
    /// 元素的第一个子元素
    case firstElementChild
    /// 元素的最后一个子元素
    case lastElementChild
    /// 元素 class 属性的动态 DOMTokenList 集合
    case classList
    /// 获取或设置元素的 class 属性的值
    case className
    /// 设置或获取 HTML 语法表示的元素的后代
    case innerHTML
    /// 获取描述元素（包括其后代）的序列化 HTML 片段
    case outerHTML
    /// 返回当前元素的标签名
    case tagName
    /// 返回指定元素的命名空间前缀
    case prefix
    case setAttribute(String, String)
    case getAttributeNames
    case getAttribute(String)
    /// 返回一个动态的包含所有指定标签名的元素的 HTML 集合HTMLCollection
    case getElementsByTagName(String)
    /// 返回一个包含了所有拥有指定 class 的子元素的 HTML 集合HTMLCollection
    case getElementsByClassName(String)
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
            
            case .item(let index): return "item(\(index))"
            
            
            
            case .createElement(let tagName): return "createElement('\(tagName)')"
            case .appendChild(let ele): return "appendChild(\(ele))"
              
            case .clientLeft: return "clientLeft"
            case .clientTop: return "clientTop"
            case .clientWidth: return "clientWidth"
            case .clientHeight: return "clientHeight"
            case .scrollLeft: return "scrollLeft"
            case .scrollTop: return "scrollTop"
            case .scrollWidth: return "scrollWidth"
            case .scrollHeight: return "scrollHeight"
            case .attributes: return "attributes"
            case .childElementCount: return "childElementCount"
            case .children: return "children"
            case .firstElementChild: return "firstElementChild"
            case .lastElementChild: return "lastElementChild"
            case .classList: return "classList"
            case .className: return "className"
            case .innerHTML: return "innerHTML"
            case .outerHTML: return "outerHTML"
            case .tagName: return "tagName"
            case .prefix: return "prefix"
            case .setAttribute(let name, let value): return "setAttribute('\(name)','\(value)')"
            case .getAttributeNames: return "getAttributeNames()"
            case .getAttribute(let attributeName): return "getAttribute('\(attributeName)')"
            case .getElementsByTagName(let tagName): return "getElementsByTagName('\(tagName)')"
            case .getElementsByClassName(let className): return "getElementsByClassName('\(className)')"
            
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
    var js: String {
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
    
    func makeJS(_ documentApis: DocumentApi...) -> String {
         let str =  documentApis.map{
            
            return $0.code
        }.joined(separator: ".")
        print("abc",str)
        return str
    }
}
