//
//  JSParam.swift
//  LAWebView
//
//  Created by xzh on 5/11/25.
//  JavaScript 参数结构体

import Foundation

public struct JSParam {
    private var rawValue: String
    private var isStr: Bool = false
    var finalValue: String {
        return isStr ? "'\(rawValue)'" : rawValue
    }
    public init(_ rawValue: String, _ isStr: Bool = false) {
        self.rawValue = rawValue
        self.isStr = isStr
    }
    
    /// 创建一个字符化的参数
    /// - Parameter rawValue: 原始值
    /// - Returns: 字符化的参数
    public static func sign(_ rawValue: String) -> JSParam {
        JSParam(rawValue, true)
    }
}
