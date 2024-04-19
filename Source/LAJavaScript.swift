//
//  LAJavaScript.swift
//  LAWebView
//
//  Created by xzh on 2023/7/18.
//  https://developer.mozilla.org/zh-CN/docs/Web/API

import Foundation

public typealias LAJSHandler = ((Any?, Error?) -> Void)


/// document 属性
public enum DocumentAttr: String {
    case window
    case document
    case body
    case head
}

/// document 方法
public enum DocumentFunc {
    case getElementById(String)
    case getElementsByName(String)
}


extension DocumentAttr: JavaScriptSyntax {
    public var code: String { return self.rawValue }
}

extension DocumentFunc: JavaScriptSyntax {
    public var code: String {
        switch self {
            case .getElementById(let id):
                return "getElementById('\(id)')"
            case .getElementsByName(let name):
                return "getElementsByName('\(name)')"
        }
    }
}

struct DocumentAbc {
    
}



/// Dom 语法
public enum DocumentApi {
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
    /// 元素的所有属性节点的实时集合
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
    /// 返回与指定的选择器组匹配的元素的后代的第一个元素
    case querySelector(String)
    /// 将一个给定的元素节点插入到相对于被调用的元素的给定的一个位置
    /// @param position: beforebegin在该元素本身的前面, afterbegin只在该元素当中，在该元素第一个子孩子前面, beforeend只在该元素当中，在该元素最后一个子孩子后面, afterend在该元素本身的后面
    /// @param element: 要插入到树中的元素
    case insertAdjacentElement(position:String, element:String)
    /// 将指定的html文本解析为 Element 元素，并将结果节点插入到 DOM 树中的指定位置
    case insertAdjacentHTML(position:String, htmlStr: String)
    /// 将一个给定的文本节点插入在相对于被调用的元素给定的位置
    case insertAdjacentText(position:String, textEle: String)
}

extension DocumentApi: JavaScriptSyntax {
    public var code: String {
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
            case .querySelector(let selectors): return "querySelector('\(selectors)')"
            case .insertAdjacentElement(let position, let element): return "insertAdjacentElement(\(position),\(element)"
            case .insertAdjacentHTML(let position, let htmlStr): return "insertAdjacentHTML(\(position),\(htmlStr))"
            case .insertAdjacentText(let position, let textEle): return "insertAdjacentText(\(position),\(textEle))"
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
        debugPrint("javascript://\(str)")
        debugPrint(DocumentAttr.window.rawValue)
        return str
    }
}
