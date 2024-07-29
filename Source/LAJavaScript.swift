//
//  LAJavaScript.swift
//  LAWebView
//
//  Created by xzh on 2023/7/18.
//  https://developer.mozilla.org/zh-CN/docs/Web/API

import Foundation

public typealias LAJSHandler = ((Any?, Error?) -> Void)


public struct JS {
    var syntax: DomSyntax
    var params: [JSParam]?
    init(_ syntax: DomSyntax, _ params: [JSParam]? = nil) {
        self.syntax = syntax
        self.params = params
    }
    
    init(_ syntax: DomSyntax, _ params: JSParam...) {
        self.syntax = syntax
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
        syntax.rawValue + makeParamList(params)
    }
    
    public func coding(Dom: DomSyntax) -> String {
        return syntax.rawValue
    }
    
    public func coding(Dom: DomSyntax, params: JSParam...) -> String {
        return ""
    }
    
    public func coding(Dom: DomSyntax, paramList: [JSParam]) -> String {
        return ""
    }
    
    
}

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
    static func sign(_ rawValue: String) -> JSParam {
        JSParam(rawValue, true)
    }
}

public enum DomSyntax: String  {
    
// TODO: debgu
    case console, log, debug, info, error, clear
// MARK:  Properties
    case window, document, body, head
    
    case clientLeft, clientTop, clientWidth, clientHeight

    case scrollLeft, scrollTop, scrollWidth, scrollHeight
    
    case childElementCount, children, firstElementChild, lastElementChild, previousElementSibling, nextElementSibling
    
    case id, tagName, className, classList, attributes
    
    case innerHTML, outerHTML
    
// MARK:  Methods
    case getElementById, getElementsByName, getElementsByTagName, getElementsByClassName
    case item
    
    case createElement
    case appendChild
    case after
}

/// Dom 语法
public enum DocumentApi {
    case console, log([JSParam]), debug([JSParam]), info([JSParam]), error([JSParam]), clear
    
    case window, document, body, head
    
    /// 表示一个元素的左边框的宽度
    case clientLeft, clientTop, clientWidth, clientHeight
    
    /// 读取或设置元素滚动条到元素左边的距离
    case scrollLeft, scrollTop, scrollWidth, scrollHeight
    
    /// 子元素
    case childElementCount, children, firstElementChild, lastElementChild, previousElementSibling, nextElementSibling
    
    /// 获取或设置元素的 class 属性的值
    case id, tagName, className, classList, attributes
    
    /// 设置或获取 HTML 语法表示的元素的后代
    case innerHTML, outerHTML
    
    case getElementById(JSParam), getElementsByName(JSParam), getElementsByTagName(JSParam), getElementsByClassName(JSParam)
    /// 从 HTML 集合HTMLCollection 通过下标取出某个元素
    case item(JSParam)
    case after([JSParam])
    case createElement(JSParam)
    case appendChild(JSParam)
    case setAttribute(JSParam, JSParam)
    case getAttributeNames
    case getAttribute(JSParam)
    
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

extension DocumentApi {
    public var code: String {
        switch self {
            case .console: return coding(Dom: .console)
            case .log(let params): return coding(Dom: .log, paramList: params)
            case .debug(let params): return coding(Dom: .debug, paramList: params)
            case .info(let params): return coding(Dom: .info, paramList: params)
            case .error(let params): return coding(Dom: .error, paramList: params)
            case .clear: return coding(Dom: .clear, paramList: [])
            
            case .window: return coding(Dom: .window)
            case .document: return coding(Dom: .document)
            case .body: return coding(Dom: .body)
            case .head: return coding(Dom: .head)
            
            case .clientLeft: return coding(Dom: .clientLeft)
            case .clientTop: return coding(Dom: .clientTop)
            case .clientWidth: return coding(Dom: .clientWidth)
            case .clientHeight: return coding(Dom: .clientHeight)
                
            case .scrollLeft: return coding(Dom: .scrollLeft)
            case .scrollTop: return coding(Dom: .scrollTop)
            case .scrollWidth: return coding(Dom: .scrollWidth)
            case .scrollHeight: return coding(Dom: .scrollHeight)
                
            case .childElementCount: return coding(Dom: .childElementCount)
            case .children: return coding(Dom: .children)
            case .firstElementChild: return coding(Dom: .firstElementChild)
            case .lastElementChild: return coding(Dom: .lastElementChild)
            case .previousElementSibling: return coding(Dom: .previousElementSibling)
            case .nextElementSibling: return coding(Dom: .nextElementSibling)
            
            case .id: return coding(Dom: .id)
            case .tagName: return coding(Dom: .tagName)
            case .className: return coding(Dom: .className)
            case .classList: return coding(Dom: .classList)
            case .attributes: return coding(Dom: .attributes)
            
            case .innerHTML: return coding(Dom: .innerHTML)
            case .outerHTML: return coding(Dom: .outerHTML)
            
            case .getElementById(let id): return coding(Dom: .getElementById, params: id)
            case .getElementsByName(let name): return coding(Dom: .getElementsByName, params: name)
            case .getElementsByTagName(let tagName): return coding(Dom: .getElementsByTagName, params: tagName)
            case .getElementsByClassName(let className): return coding(Dom: .getElementsByClassName, params: className)
            case .item(let index): return coding(Dom: .item, params: index)
            
            case .createElement(let tagName): return coding(Dom: .createElement, params: tagName)
            case .appendChild(let ele): return coding(Dom: .appendChild, params: ele)
            case .after(let eles): return coding(Dom: .after, paramList: eles)
            case .setAttribute(let name, let value): return "setAttribute('\(name)','\(value)')"
            case .getAttributeNames: return "getAttributeNames()"
            case .getAttribute(let attributeName): return "getAttribute('\(attributeName)')"
            
            case .querySelector(let selectors): return "querySelector('\(selectors)')"
            case .insertAdjacentElement(let position, let element): return "insertAdjacentElement(\(position),\(element)"
            case .insertAdjacentHTML(let position, let htmlStr): return "insertAdjacentHTML(\(position),\(htmlStr))"
            case .insertAdjacentText(let position, let textEle): return "insertAdjacentText(\(position),\(textEle))"
        }
    }
    
    
    func coding(Dom: DomSyntax) -> String {
        return Dom.rawValue
    }
    
    public func coding(Dom: DomSyntax, params: JSParam...) -> String {
        return Dom.rawValue + makeParamList(params.map({ $0.finalValue }))
    }
    
    public func coding(Dom: DomSyntax, paramList: [JSParam]) -> String {
        return Dom.rawValue + makeParamList(paramList.map({ $0.finalValue }))
    }
    
    
    /// 构造参数列表
    /// - Parameter params: 原始参数
    /// - Returns: 参数列表
    private func makeParamList(_ params: [String]) -> String {
        return "(\(params.joined(separator: ",")))"
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
    
    case testCreateElement(tagName: String, handler: LAJSHandler?)
    
}



extension LAJSSnippet: JavaScriptAPI {
    public var js: String {
        switch self {
            case .getElement(let type, let index, _):
                
            if case .Id(let id) = type {
                return makeJS(.document,.getElementById(.sign(id)),.outerHTML)
            }else if case .Name(let name) = type {
                return makeJS(.document,.getElementsByName(.sign(name)),.item(.init("\(index)")),.outerHTML)
            }else if case .TagName(let tagName) = type {
                return makeJS(.document,.getElementsByTagName(.sign(tagName)),.item(.init("\(index)")),.outerHTML)
            }else if case .ClassName(let className) = type {
                return makeJS(.document,.getElementsByClassName(.sign(className)),.item(.init("\(index)")),.outerHTML)
            }
            return ""
            
            
            case .clientWidth(_):
                return makeJS(.document,.body,.clientWidth)
            case .clientHeight(_):
                return makeJS(.document,.body,.clientHeight)
            case .scrollHeight(_):
                return makeJS(.document,.body,.scrollHeight)
            case .testCreateElement(let tagName, _):
            return makeJS(.document, .createElement(.sign(tagName)), .outerHTML)
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
            case .testCreateElement(_, let handler):
                return handler
        }
    }
    
    public func makeJS(_ documentApis: DocumentApi...) -> String {
         let str =  documentApis.map{ $0.code }.joined(separator: ".")
        debugPrint("javascript://\(str)")
        return str
    }
    
    public static func testSyntax(){
        
        debugPrint("testSyntax:",JS(DomSyntax(rawValue: "abs")!).code)
        
    }
}
