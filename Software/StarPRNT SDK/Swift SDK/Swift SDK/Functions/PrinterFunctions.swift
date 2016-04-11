//
//  PrinterFunctions.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import Foundation

class PrinterFunctions {
    static func createTextReceiptData(emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, utf8: Bool) -> NSData {
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        localizeReceipts.appendTextReceiptData(builder, utf8: utf8)
        
        builder.appendCutPaper(SCBCutPaperAction.PartialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! NSData
    }
    
    static func createRasterReceiptData(emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts) -> NSData {
        let image: UIImage = localizeReceipts.createRasterReceiptImage()!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: false)
        
        builder.appendCutPaper(SCBCutPaperAction.PartialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! NSData
    }
    
    static func createScaleRasterReceiptData(emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, width: Int, bothScale: Bool) -> NSData {
        let image: UIImage = localizeReceipts.createScaleRasterReceiptImage()!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: false, width: width, bothScale: bothScale)
        
        builder.appendCutPaper(SCBCutPaperAction.PartialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! NSData
    }
    
    static func createCouponData(emulation: StarIoExtEmulation, localizeReceipts: ILocalizeReceipts, width: Int, rotation: SCBBitmapConverterRotation) -> NSData {
        let image: UIImage = localizeReceipts.createCouponImage()!
        
        let builder: ISCBBuilder = StarIoExt.createCommandBuilder(emulation)
        
        builder.beginDocument()
        
        builder.appendBitmap(image, diffusion: false, width: width, bothScale: true, rotation: rotation)
        
        builder.appendCutPaper(SCBCutPaperAction.PartialCutWithFeed)
        
        builder.endDocument()
        
        return builder.commands.copy() as! NSData
    }
}
