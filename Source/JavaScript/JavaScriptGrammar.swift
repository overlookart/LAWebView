//
//  JavaScriptGrammar.swift
//  LAWebView
//
//  Created by CaiGou on 2024/7/30.
//

import Foundation
public enum JavaScriptGrammar: String  {
    
// MARK:  Properties
    case window, document, body, head
    
// MARK: Window Properties
    /// debgu
    case console, log, debug, info, error, clear
    
// MARK: Document Properties
    case clientLeft, clientTop, clientWidth, clientHeight

    case scrollLeft, scrollTop, scrollWidth, scrollHeight
    
    case childElementCount, children, firstElementChild, lastElementChild, previousElementSibling, nextElementSibling
    
    case id, tagName, className, classList, attributes
    
    case innerHTML, outerHTML
    
// MARK: Document Methods
    case getElementById, getElementsByName, getElementsByTagName, getElementsByClassName
    case item
    
    case createElement
    
    case setAttribute
    
    case appendChild
    case after
    
// MARK: Window Methods
    case postMessage
}
