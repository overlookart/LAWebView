//
//  File.swift
//  LAWebView
//
//  Created by CaiGou on 2024/4/17.
//

import Foundation
public protocol JavaScriptAPI {
    var js: String { get }
    var handler: LAJSHandler? { get }
    func makeJS(_ documentApis: DocumentApi...) -> String
}


public protocol JavaScriptSyntax {
    var code: String { get }
    func coding(Dom: DomSyntax, params: String...) -> String 
}
