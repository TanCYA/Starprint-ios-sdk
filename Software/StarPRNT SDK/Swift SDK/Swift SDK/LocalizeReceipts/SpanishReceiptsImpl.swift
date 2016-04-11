//
//  SpanishReceiptsImpl.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class SpanishReceiptsImpl: ILocalizeReceipts {
    override init() {
        super.init()
        
        languageCode = "Es"
    }
    
    override func append2inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        var encoding: NSStringEncoding
        
        if utf8 == true {
            encoding = NSUTF8StringEncoding
            
            builder.appendCodePage(SCBCodePageType.UTF8)
        }
        else {
            encoding = NSWindowsCP1252StringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
        builder.appendInternational(SCBInternationalType.Spain)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendDataWithMultiple((
            "BAR RESTAURANT\n" +
            "EL POZO\n").dataUsingEncoding(encoding), width: 2, height: 2)
        
        builder.appendData((
            "C/.ROCAFORT 187\n" +
            "08029 BARCELONA\n" +
            "\n" +
            "NIF :X-3856907Z\n" +
            "TEL :934199465\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "--------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "--------------------------------\n" +
            " 4  3,00  JARRA  CERVESA   12,00\n" +
            " 1  1,60  COPA DE CERVESA   1,60\n" +
            "--------------------------------\n" +
            "               SUB TOTAL : 13,60\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Right)
        
        builder.appendDataWithMultipleHeight("TOTAL:     13,60 EUROS\n".dataUsingEncoding(encoding), height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "NO: 000018851     IVA INCLUIDO\n" +
            "--------------------------------\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData((
            "**** GRACIAS POR SU VISITA! ****\n" +
            "\n").dataUsingEncoding(encoding))
        
//      builder.appendBarcodeData("{BStar.".dataUsingEncoding(encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".dataUsingEncoding(NSASCIIStringEncoding), symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
    }
    
    override func append3inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        var encoding: NSStringEncoding
        
        if utf8 == true {
            encoding = NSUTF8StringEncoding
            
            builder.appendCodePage(SCBCodePageType.UTF8)
        }
        else {
            encoding = NSWindowsCP1252StringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
        builder.appendInternational(SCBInternationalType.Spain)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
//      builder.appendData("[If loaded.. Logo1 goes here]\n".dataUsingEncoding(encoding))
//
//      builder.appendLogo(SCBLogoSize.Normal, number: 1)
        
        builder.appendDataWithMultiple("BAR RESTAURANT EL POZO\n".dataUsingEncoding(encoding), width: 2, height: 2)
        
        builder.appendData((
            "C/.ROCAFORT 187 08029 BARCELONA\n" +
            "NIF :X-3856907Z  TEL :934199465\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "------------------------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "------------------------------------------------\n" +
            " 4     3,00      JARRA  CERVESA            12,00\n" +
            " 1     1,60      COPA DE CERVESA            1,60\n" +
            "------------------------------------------------\n" +
            "                           SUB TOTAL :     13,60\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Right)
        
        builder.appendDataWithMultipleHeight("TOTAL:     13,60 EUROS\n".dataUsingEncoding(encoding), height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "NO: 000018851  IVA INCLUIDO\n" +
            "------------------------------------------------\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData((
            "**** GRACIAS POR SU VISITA! ****\n" +
            "\n").dataUsingEncoding(encoding))
        
//      builder.appendBarcodeData("{BStar.".dataUsingEncoding(encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".dataUsingEncoding(NSASCIIStringEncoding), symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
    }
    
    override func append4inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        var encoding: NSStringEncoding
        
        if utf8 == true {
            encoding = NSUTF8StringEncoding
            
            builder.appendCodePage(SCBCodePageType.UTF8)
        }
        else {
            encoding = NSWindowsCP1252StringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
        builder.appendInternational(SCBInternationalType.Spain)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
//      builder.appendData("[If loaded.. Logo1 goes here]\n".dataUsingEncoding(encoding))
//
//      builder.appendLogo(SCBLogoSize.Normal, number: 1)
        
        builder.appendDataWithMultiple("BAR RESTAURANT EL POZO\n".dataUsingEncoding(encoding), width: 2, height: 2)
        
        builder.appendData((
            "C/.ROCAFORT 187 08029 BARCELONA\n" +
            "NIF :X-3856907Z  TEL :934199465\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "---------------------------------------------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "---------------------------------------------------------------------\n" +
            " 4     3,00          JARRA  CERVESA                             12,00\n" +
            " 1     1,60          COPA DE CERVESA                             1,60\n" +
            "---------------------------------------------------------------------\n" +
            "                                         SUB TOTAL :            13,60\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Right)
        
        builder.appendDataWithMultipleHeight("TOTAL:     13,60 EUROS\n".dataUsingEncoding(encoding), height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "NO: 000018851  IVA INCLUIDO\n" +
            "---------------------------------------------------------------------\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData((
            "**** GRACIAS POR SU VISITA! ****\n" +
            "\n").dataUsingEncoding(encoding))
        
//      builder.appendBarcodeData("{BStar.".dataUsingEncoding(encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".dataUsingEncoding(NSASCIIStringEncoding), symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
    }
    
    override func create2inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "     BAR RESTAURANT\n" +
        "                   EL POZO\n" +
        "C/.ROCAFORT 187\n" +
        "08029 BARCELONA\n" +
        "NIF :X-3856907Z\n" +
        "TEL :934199465\n" +
        "--------------------------\n" +
        "MESA: 100 P: -\n" +
        "    FECHA: YYYY-MM-DD\n" +
        "CAN P/U DESCRIPCION  SUMA\n" +
        "--------------------------\n" +
        "3,00 JARRA CERVESA   12,00\n" +
        "1,60 COPA DE CERVESA  1,60\n" +
        "--------------------------\n" +
        "         SUB TOTAL : 13,60\n" +
        "TOTAL:         13,60 EUROS\n" +
        " NO:000018851 IVA INCLUIDO\n" +
        "\n" +
        "--------------------------\n" +
        "**GRACIAS POR SU VISITA!**\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 384)     // 2inch(384dots)
    }
    
    override func create3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "                        BAR RESTAURANT\n" +
        "                               EL POZO\n" +
        "C/.ROCAFORT 187\n" +
        "08029 BARCELONA\n" +
        "NIF :X-3856907Z\n" +
        "TEL :934199465\n" +
        "--------------------------------------\n" +
        "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
        "CAN P/U DESCRIPCION  SUMA\n" +
        "--------------------------------------\n" +
        "4 3,00 JARRA  CERVESA   12,00\n" +
        "1 1,60 COPA DE CERVESA  1,60\n" +
        "--------------------------------------\n" +
        "                     SUB TOTAL : 13,60\n" +
        "TOTAL:               13,60 EUROS\n" +
        "NO: 000018851 IVA INCLUIDO\n" +
        "\n" +
        "--------------------------------------\n" +
        "            **GRACIAS POR SU VISITA!**\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 576)     // 3inch(576dots)
    }
    
    override func create4inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "                                   BAR RESTAURANT EL POZO\n" +
        "                          C/.ROCAFORT 187 08029 BARCELONA\n" +
        "                          NIF :X-3856907Z  TEL :934199465\n" +
        "---------------------------------------------------------\n" +
        "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
        "CAN P/U DESCRIPCION  SUMA\n" +
        "---------------------------------------------------------\n" +
        "4    3,00    JARRA  CERVESA                         12,00\n" +
        "1    1,60    COPA DE CERVESA                         1,60\n" +
        "---------------------------------------------------------\n" +
        "                                  SUB TOTAL :       13,60\n" +
        "                                 TOTAL :      13,60 EUROS\n" +
        "NO: 000018851 IVA INCLUIDO\n" +
        "\n" +
        "---------------------------------------------------------\n" +
        "                             ***GRACIAS POR SU VISITA!***\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 832)     // 4inch(832dots)
    }
    
    override func createCouponImage() -> UIImage {
        return UIImage(named: "SpanishCouponImage.png")!
    }
    
    override func createEscPos3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "                     BAR RESTAURANT\n" +
        "                            EL POZO\n" +
        "C/.ROCAFORT 187\n" +
        "08029 BARCELONA\n" +
        "NIF :X-3856907Z\n" +
        "TEL :934199465\n" +
        "-----------------------------------\n" +
        "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
        "CAN P/U DESCRIPCION  SUMA\n" +
        "-----------------------------------\n" +
        "4 3,00 JARRA  CERVESA   12,00\n" +
        "1 1,60 COPA DE CERVESA  1,60\n" +
        "-----------------------------------\n" +
        "                  SUB TOTAL : 13,60\n" +
        "TOTAL:               13,60 EUROS\n" +
        "NO: 000018851 IVA INCLUIDO\n" +
        "\n" +
        "-----------------------------------\n" +
        "         **GRACIAS POR SU VISITA!**\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 512)     // EscPos3inch(512dots)
    }
    
    override func appendEscPos3inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        var encoding: NSStringEncoding
        
        if utf8 == true {
            encoding = NSUTF8StringEncoding
            
            builder.appendCodePage(SCBCodePageType.UTF8)
        }
        else {
            encoding = NSWindowsCP1252StringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
        builder.appendInternational(SCBInternationalType.Spain)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
//      builder.appendData("[If loaded.. Logo1 goes here]\n".dataUsingEncoding(encoding))
//
//      builder.appendLogo(SCBLogoSize.Normal, number: 1)
        
        builder.appendDataWithMultiple("BAR RESTAURANT EL POZO\n".dataUsingEncoding(encoding), width: 2, height: 2)
        
        builder.appendData((
            "C/.ROCAFORT 187 08029 BARCELONA\n" +
            "NIF :X-3856907Z  TEL :934199465\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "------------------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "------------------------------------------\n" +
            " 4    3,00    JARRA  CERVESA         12,00\n" +
            " 1    1,60    COPA DE CERVESA         1,60\n" +
            "------------------------------------------\n" +
            "                     SUB TOTAL :     13,60\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Right)
        
        builder.appendDataWithMultipleHeight("TOTAL:     13,60 EUROS\n".dataUsingEncoding(encoding), height: 2)
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "NO: 000018851  IVA INCLUIDO\n" +
            "------------------------------------------\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData((
            "**** GRACIAS POR SU VISITA! ****\n" +
            "\n").dataUsingEncoding(encoding))
        
//      builder.appendBarcodeData("{BStar.".dataUsingEncoding(encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".dataUsingEncoding(NSASCIIStringEncoding), symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
    }
    
    override func appendDotImpact3inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        var encoding: NSStringEncoding
        
        if utf8 == true {
            encoding = NSUTF8StringEncoding
            
            builder.appendCodePage(SCBCodePageType.UTF8)
        }
        else {
            encoding = NSWindowsCP1252StringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP1252)
        }
        
        builder.appendInternational(SCBInternationalType.Spain)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
//      builder.appendData("[If loaded.. Logo1 goes here]\n".dataUsingEncoding(encoding))
//
//      builder.appendLogo(SCBLogoSize.Normal, number: 1)
        
        builder.appendDataWithMultipleHeight("BAR RESTAURANT EL POZO\n".dataUsingEncoding(encoding), height: 2)
        
        builder.appendData((
            "C/.ROCAFORT 187 08029 BARCELONA\n" +
            "NIF :X-3856907Z  TEL :934199465\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "------------------------------------------\n" +
            "MESA: 100 P: - FECHA: YYYY-MM-DD\n" +
            "CAN P/U DESCRIPCION  SUMA\n" +
            "------------------------------------------\n" +
            " 4 3,00 JARRA  CERVESA               12,00\n" +
            " 1 1,60 COPA DE CERVESA               1,60\n" +
            "------------------------------------------\n" +
            " SUB TOTAL :                         13,60\n" +
            "                     TOTAL:    13,60 EUROS\n" +
            "NO: 000018851  IVA INCLUIDO\n" +
            "------------------------------------------\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData("**** GRACIAS POR SU VISITA! ****\n".dataUsingEncoding(encoding))
    }
}
