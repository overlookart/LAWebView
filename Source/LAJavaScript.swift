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

public enum LAJavaScript {
    
    /// 通过 tagName 获取 element
    case getElement(tagName: String, index: Int = 0, handler: ((Any?, Error?) -> Void)?)
    
}

extension LAJavaScript: JavaScriptAPI {
    var js: String {
        switch self {
        case .getElement(let tagName, let index, _):
                return "document.getElementsByTagName('\(tagName)')[\(index)].outerHTML"
        }
    }
    
    var handler: ((Any?, Error?) -> Void)? {
        switch self {
            case .getElement(_, _, let handler):
                return handler
        }
    }
}
