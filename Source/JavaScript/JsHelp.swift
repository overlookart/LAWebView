//
//  JsHelp.swift
//  LAWebView
//
//  Created by xzh on 5/11/25.
//

import Foundation

public struct JsHelp {
    /// 构造参数列表
    /// - Parameter params: 原始参数
    /// - Returns: 参数列表
    static func  makeParamList(_ params: [JSParam]?) -> String {
        guard let ps = params else { return "" }
        return "(\(ps.map({ $0.finalValue }).joined(separator: ",")))"
    }
    
    /// 构造语句列表
    static func makeCodeList(_ codes: [JavaScriptCode]?) -> String {
        guard let c = codes else { return "" }
        return """
        \(c.map({ $0.code }).joined(separator: "\n"))
        """
    }
}
