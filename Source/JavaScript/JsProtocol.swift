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
    
    /// 参数是否字符化
    var paramStr: Bool { get }
    func coding(Dom: DomSyntax, params: String...) -> String
    func coding(Dom: DomSyntax, paramList: [String]) -> String
}
