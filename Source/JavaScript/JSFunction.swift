//
//  JSFunction.swift
//  LAWebView
//
//  Created by xzh on 5/11/25.
//

import Foundation
public struct JSFunction: JavaScriptCode {
    public var code: String {
        return makeJS()
    }
    
    public var name: String
    public var body: [JavaScriptCode] = []
    public var params: [JSParam] = []
    
    public init(name: String, body: [JavaScriptCode] = [], params: [JSParam] = []) {
        self.name = name
        self.body = body
        self.params = params
    }
    
    private func makeJS() -> String {
        let code = """
        function \(name)\(JsHelp.makeParamList(params)) {
            \(JsHelp.makeCodeList(body))
        }
        """
        debugPrint("js function:\(code)")
        return code
    }
}
