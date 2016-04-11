//
//  SMDefine.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import Foundation

// func MakePrettyFunction(filePath: String = __FILE__, line: Int = __LINE__, funcName: String = __FUNCTION__) -> String {
   func MakePrettyFunction(filePath: String = #file,    line: Int = #line,    funcName: String = #function)    -> String {
    let fileName: String = filePath.componentsSeparatedByString("/").last!
    
    return "-[\(fileName)(\(line)) \(funcName):]"
}

let sm_true:  UInt32 = 1     // SM_TRUE
let sm_false: UInt32 = 0     // SM_FALSE
