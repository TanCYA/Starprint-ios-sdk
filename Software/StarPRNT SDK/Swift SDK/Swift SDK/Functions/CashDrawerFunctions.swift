//
//  CashDrawerFunctions.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class CashDrawerFunctions {
    static func createData(emulation: StarIoExtEmulation, channel: SCBPeripheralChannel) -> NSData {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendPeripheral(channel)
        
        builder.endDocument()
        
        return builder.commands.copy() as! NSData
    }
}
