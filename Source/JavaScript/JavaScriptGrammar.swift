//
//  JavaScriptGrammar.swift
//  LAWebView
//
//  Created by CaiGou on 2024/7/30.
//

import Foundation
public enum JavaScriptGrammar: String  {
    
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
