//
//  Communication.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import Foundation

class Communication {
    static func sendCommands(commands: NSData!, port: SMPort!) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        let length: UInt32 = UInt32(commands.length)
        
        var array: [UInt8] = [UInt8](count: commands.length, repeatedValue: 0)
        
        commands.getBytes(&array, length: commands.length)
        
        while true {
            if port == nil {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.beginCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (BeginCheckedBlock)"
                break
            }
            
            let startDate: NSDate = NSDate()
            
            var total: UInt32 = 0
            
            while total < length {
                let written: UInt32 = port.writePort(array, total, length - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if NSDate().timeIntervalSinceDate(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < length {
                break
            }
            
            port.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
            
            port.endCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (endCheckedBlock)"
                break
            }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        return result
    }
    
    static func sendCommandsDoNotCheckCondition(commands: NSData!, port: SMPort!) -> Bool {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        let length: UInt32 = UInt32(commands.length)
        
        var array: [UInt8] = [UInt8](count: commands.length, repeatedValue: 0)
        
        commands.getBytes(&array, length: commands.length)
        
        while true {
            if port == nil {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (getParsedStatus)"
//              break
//          }
            
            let startDate: NSDate = NSDate()
            
            var total: UInt32 = 0
            
            while total < length {
                let written: UInt32 = port.writePort(array, total, length - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if NSDate().timeIntervalSinceDate(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < length {
                break
            }
            
            port.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (getParsedStatus)"
//              break
//          }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
            
            alertView.show()
        }
        
        return result
    }
    
    static func sendCommands(commands: NSData!, portName: String!, portSettings: String!, timeout: UInt32) -> Bool! {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        let length: UInt32 = UInt32(commands.length)
        
        var array: [UInt8] = [UInt8](count: commands.length, repeatedValue: 0)
        
        commands.getBytes(&array, length: commands.length)
        
        var port: SMPort?
        
        while true {
            port = SMPort.getPort(portName, portSettings, timeout)
            
            if port == nil {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            defer {
                SMPort.releasePort(port)
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port!.beginCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (BeginCheckedBlock)"
                break
            }
            
            let startDate: NSDate = NSDate()
            
            var total: UInt32 = 0
            
            while total < length {
                let written: UInt32 = port!.writePort(array, total, length - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if NSDate().timeIntervalSinceDate(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < length {
                break
            }
            
            port!.endCheckedBlockTimeoutMillis = 30000     // 30000mS!!!
            
            port!.endCheckedBlock(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
            if printerStatus.offline == sm_true {
                title   = "Printer Error"
                message = "Printer is offline (endCheckedBlock)"
                break
            }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        return result
    }
    
    static func sendCommandsDoNotCheckCondition(commands: NSData!, portName: String!, portSettings: String!, timeout: UInt32) -> Bool! {
        var result: Bool = false
        
        var title:   String = ""
        var message: String = ""
        
        var error: NSError?
        
        let length: UInt32 = UInt32(commands.length)
        
        var array: [UInt8] = [UInt8](count: commands.length, repeatedValue: 0)
        
        commands.getBytes(&array, length: commands.length)
        
        var port: SMPort?
        
        while true {
            port = SMPort.getPort(portName, portSettings, timeout)
            
            if port == nil {
                title   = "Fail to Open Port"
                message = ""
                break
            }
            
            defer {
                SMPort.releasePort(port)
            }
            
            var printerStatus: StarPrinterStatus_2 = StarPrinterStatus_2()
            
            port!.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (getParsedStatus)"
//              break
//          }
            
            let startDate: NSDate = NSDate()
            
            var total: UInt32 = 0
            
            while total < length {
                let written: UInt32 = port!.writePort(array, total, length - total, &error)
                
                if error != nil {
                    break
                }
                
                total += written
                
                if NSDate().timeIntervalSinceDate(startDate) >= 30.0 {     // 30000mS!!!
                    title   = "Printer Error"
                    message = "Write port timed out"
                    break
                }
            }
            
            if total < length {
                break
            }
            
            port!.getParsedStatus(&printerStatus, 2, &error)
            
            if error != nil {
                break
            }
            
//          if printerStatus.offline == sm_true {     // Do not check condition.
//              title   = "Printer Error"
//              message = "Printer is offline (getParsedStatus)"
//              break
//          }
            
            title   = "Send Commands"
            message = "Success"
            
            result = true
            break
        }
        
        if error != nil {
            title   = "Printer Error"
            message = error!.description
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        return result
    }
}
