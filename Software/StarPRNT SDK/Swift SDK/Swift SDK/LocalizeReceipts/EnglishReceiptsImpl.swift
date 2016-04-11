//
//  EnglishReceiptsImpl.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class EnglishReceiptsImpl: ILocalizeReceipts {
    override init() {
        super.init()
        
        languageCode = "En"
    }
    
    override func append2inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        var encoding: NSStringEncoding
        
        if utf8 == true {
            encoding = NSUTF8StringEncoding
            
            builder.appendCodePage(SCBCodePageType.UTF8)
        }
        else {
            encoding = NSASCIIStringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP998)
        }
        
        builder.appendInternational(SCBInternationalType.USA)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData((
            "Star Clothing Boutique\n" +
            "123 Star Road\n" +
            "City, State 12345\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "Date:MM/DD/YYYY    Time:HH:MM PM\n" +
            "--------------------------------\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithEmphasis(("SALE\n").dataUsingEncoding(encoding))
        
        builder.appendData((
            "SKU         Description    Total\n" +
            "300678566   PLAIN T-SHIRT  10.99\n" +
            "300692003   BLACK DENIM    29.99\n" +
            "300651148   BLUE DENIM     29.99\n" +
            "300642980   STRIPED DRESS  49.99\n" +
            "300638471   BLACK BOOTS    35.99\n" +
            "\n" +
            "Subtotal                  156.95\n" +
            "Tax                         0.00\n" +
            "--------------------------------\n").dataUsingEncoding(encoding))
        
        builder.appendData(("Total     ").dataUsingEncoding(encoding))
        
        builder.appendDataWithMultiple(("   $156.95\n").dataUsingEncoding(encoding), width: 2, height: 2)
        
        builder.appendData((
            "--------------------------------\n" +
            "\n" +
            "Charge\n" +
            "159.95\n" +
            "Visa XXXX-XXXX-XXXX-0123\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithInvert(("Refunds and Exchanges\n").dataUsingEncoding(encoding))
        
        builder.appendData(("Within ").dataUsingEncoding(encoding))
        
        builder.appendDataWithUnderLine(("30 days").dataUsingEncoding(encoding))
        
        builder.appendData((" with receipt\n").dataUsingEncoding(encoding))
        
        builder.appendData((
            "And tags attached\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
//      builder.appendBarcodeData(("{BStar.").dataUsingEncoding(encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData(("{BStar.").dataUsingEncoding(NSASCIIStringEncoding), symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
    }
    
    override func append3inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        var encoding: NSStringEncoding
        
        if utf8 == true {
            encoding = NSUTF8StringEncoding
            
            builder.appendCodePage(SCBCodePageType.UTF8)
        }
        else {
            encoding = NSASCIIStringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP998)
        }
        
        builder.appendInternational(SCBInternationalType.USA)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData((
            "Star Clothing Boutique\n" +
            "123 Star Road\n" +
            "City, State 12345\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "Date:MM/DD/YYYY                    Time:HH:MM PM\n" +
            "------------------------------------------------\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithEmphasis(("SALE \n").dataUsingEncoding(encoding))
        
        builder.appendData((
            "SKU               Description              Total\n" +
            "300678566         PLAIN T-SHIRT            10.99\n" +
            "300692003         BLACK DENIM              29.99\n" +
            "300651148         BLUE DENIM               29.99\n" +
            "300642980         STRIPED DRESS            49.99\n" +
            "300638471         BLACK BOOTS              35.99\n" +
            "\n" +
            "Subtotal                                  156.95\n" +
            "Tax                                         0.00\n" +
            "------------------------------------------------\n").dataUsingEncoding(encoding))
        
        builder.appendData(("Total                       ").dataUsingEncoding(encoding))
        
        builder.appendDataWithMultiple("   $156.95\n".dataUsingEncoding(encoding), width: 2, height: 2)
        
        builder.appendData((
            "------------------------------------------------\n" +
            "\n" +
            "Charge\n" +
            "159.95\n" +
            "Visa XXXX-XXXX-XXXX-0123\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithInvert(("Refunds and Exchanges\n").dataUsingEncoding(encoding))
        
        builder.appendData(("Within ").dataUsingEncoding(encoding))
        
        builder.appendDataWithUnderLine(("30 days").dataUsingEncoding(encoding))
        
        builder.appendData((" with receipt\n").dataUsingEncoding(encoding))
        
        builder.appendData((
            "And tags attached\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
//      builder.appendBarcodeData("{BStar.".dataUsingEncoding(encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height:,40, hri: true)
        builder.appendBarcodeData("{BStar.".dataUsingEncoding(NSASCIIStringEncoding), symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
    }
    
    override func append4inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        var encoding: NSStringEncoding
        
        if utf8 == true {
            encoding = NSUTF8StringEncoding
            
            builder.appendCodePage(SCBCodePageType.UTF8)
        }
        else {
            encoding = NSASCIIStringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP998)
        }
        
        builder.appendInternational(SCBInternationalType.USA)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData((
            "Star Clothing Boutique\n" +
            "123 Star Road\n" +
            "City, State 12345\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "Date:MM/DD/YYYY                                         Time:HH:MM PM\n" +
            "---------------------------------------------------------------------\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithEmphasis(("SALE \n").dataUsingEncoding(encoding))
        
        builder.appendData((
            "SKU                        Description                          Total\n" +
            "300678566                  PLAIN T-SHIRT                        10.99\n" +
            "300692003                  BLACK DENIM                          29.99\n" +
            "300651148                  BLUE DENIM                           29.99\n" +
            "300642980                  STRIPED DRESS                        49.99\n" +
            "300638471                  BLACK BOOTS                          35.99\n" +
            "\n" +
            "Subtotal                                                       156.95\n" +
            "Tax                                                              0.00\n" +
            "---------------------------------------------------------------------\n").dataUsingEncoding(encoding))
        
        builder.appendData(("Total                                            ").dataUsingEncoding(encoding))
        
        builder.appendDataWithMultiple("   $156.95\n".dataUsingEncoding(encoding), width: 2, height: 2)
        
        builder.appendData((
            "---------------------------------------------------------------------\n" +
            "\n" +
            "Charge\n" +
            "159.95\n" +
            "Visa XXXX-XXXX-XXXX-0123\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithInvert(("Refunds and Exchanges\n").dataUsingEncoding(encoding))
        
        builder.appendData(("Within ").dataUsingEncoding(encoding))
        
        builder.appendDataWithUnderLine(("30 days").dataUsingEncoding(encoding))
        
        builder.appendData((" with receipt\n").dataUsingEncoding(encoding))
        
        builder.appendData((
            "And tags attached\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
//      builder.appendBarcodeData("{BStar.".dataUsingEncoding(encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
        builder.appendBarcodeData("{BStar.".dataUsingEncoding(NSASCIIStringEncoding), symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
    }
    
    override func create2inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "   Star Clothing Boutique\n" +
        "        123 Star Road\n" +
        "      City, State 12345\n" +
        "\n" +
        "Date:MM/DD/YYYY Time:HH:MM PM\n" +
        "-----------------------------\n" +
        "SALE\n" +
        "SKU       Description   Total\n" +
        "300678566 PLAIN T-SHIRT 10.99\n" +
        "300692003 BLACK DENIM   29.99\n" +
        "300651148 BLUE DENIM    29.99\n" +
        "300642980 STRIPED DRESS 49.99\n" +
        "30063847  BLACK BOOTS   35.99\n" +
        "\n" +
        "Subtotal               156.95\n" +
        "Tax                      0.00\n" +
        "-----------------------------\n" +
        "Total                 $156.95\n" +
        "-----------------------------\n" +
        "\n" +
        "Charge\n" +
        "159.95\n" +
        "Visa XXXX-XXXX-XXXX-0123\n" +
        "Refunds and Exchanges\n" +
        "Within 30 days with receipt\n" +
        "And tags attached\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 10 * 2)!
//      let font: UIFont = UIFont(name: "Menlo", size: 11 * 2)!
//      let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 384)     // 2inch(384dots)
    }
    
    override func create3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "        Star Clothing Boutique\n" +
        "             123 Star Road\n" +
        "           City, State 12345\n" +
        "\n" +
        "Date:MM/DD/YYYY          Time:HH:MM PM\n" +
        "--------------------------------------\n" +
        "SALE\n" +
        "SKU            Description       Total\n" +
        "300678566      PLAIN T-SHIRT     10.99\n" +
        "300692003      BLACK DENIM       29.99\n" +
        "300651148      BLUE DENIM        29.99\n" +
        "300642980      STRIPED DRESS     49.99\n" +
        "30063847       BLACK BOOTS       35.99\n" +
        "\n" +
        "Subtotal                        156.95\n" +
        "Tax                               0.00\n" +
        "--------------------------------------\n" +
        "Total                          $156.95\n" +
        "--------------------------------------\n" +
        "\n" +
        "Charge\n" +
        "159.95\n" +
        "Visa XXXX-XXXX-XXXX-0123\n" +
        "Refunds and Exchanges\n" +
        "Within 30 days with receipt\n" +
        "And tags attached\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 576)     // 3inch(576dots)
    }
    
    override func create4inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "                   Star Clothing Boutique\n" +
        "                        123 Star Road\n" +
        "                      City, State 12345\n" +
        "\n" +
        "Date:MM/DD/YYYY                             Time:HH:MM PM\n" +
        "---------------------------------------------------------\n" +
        "SALE\n" +
        "SKU                     Description                 Total\n" +
        "300678566               PLAIN T-SHIRT               10.99\n" +
        "300692003               BLACK DENIM                 29.99\n" +
        "300651148               BLUE DENIM                  29.99\n" +
        "300642980               STRIPED DRESS               49.99\n" +
        "300638471               BLACK BOOTS                 35.99\n" +
        "\n" +
        "Subtotal                                           156.95\n" +
        "Tax                                                  0.00\n" +
        "---------------------------------------------------------\n" +
        "Total                                             $156.95\n" +
        "---------------------------------------------------------\n" +
        "\n" +
        "Charge\n" +
        "159.95\n" +
        "Visa XXXX-XXXX-XXXX-0123\n" +
        "Refunds and Exchanges\n" +
        "Within 30 days with receipt\n" +
        "And tags attached\n"
        
        let font: UIFont = UIFont(name: "Menlo", size: 12 * 2)!
        
        return ILocalizeReceipts.imageWithString(textToPrint, font: font, width: 832)     // 4inch(832dots)
    }
    
    override func createCouponImage() -> UIImage {
        return UIImage(named: "EnglishCouponImage.png")!
    }
    
    override func createEscPos3inchRasterReceiptImage() -> UIImage {
        let textToPrint: String =
        "      Star Clothing Boutique\n" +
        "           123 Star Road\n" +
        "         City, State 12345\n" +
        "\n" +
        "Date:MM/DD/YYYY       Time:HH:MM PM\n" +
        "-----------------------------------\n" +
        "SALE\n" +
        "SKU          Description      Total\n" +
        "300678566    PLAIN T-SHIRT    10.99\n" +
        "300692003    BLACK DENIM      29.99\n" +
        "300651148    BLUE DENIM       29.99\n" +
        "300642980    STRIPED DRESS    49.99\n" +
        "30063847     BLACK BOOTS      35.99\n" +
        "\n" +
        "Subtotal                     156.95\n" +
        "Tax                            0.00\n" +
        "-----------------------------------\n" +
        "Total                       $156.95\n" +
        "-----------------------------------\n" +
        "\n" +
        "Charge\n" +
        "159.95\n" +
        "Visa XXXX-XXXX-XXXX-0123\n" +
        "Refunds and Exchanges\n" +
        "Within 30 days with receipt\n" +
        "And tags attached\n"
        
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
            encoding = NSASCIIStringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP998)
        }
        
        builder.appendInternational(SCBInternationalType.USA)
        
        builder.appendCharacterSpace(0)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData((
            "Star Clothing Boutique\n" +
            "123 Star Road\n" +
            "City, State 12345\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "Date:MM/DD/YYYY              Time:HH:MM PM\n" +
            "------------------------------------------\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithEmphasis(("SALE \n").dataUsingEncoding(encoding))
        
        builder.appendData((
            "SKU            Description           Total\n" +
            "300678566      PLAIN T-SHIRT         10.99\n" +
            "300692003      BLACK DENIM           29.99\n" +
            "300651148      BLUE DENIM            29.99\n" +
            "300642980      STRIPED DRESS         49.99\n" +
            "300638471      BLACK BOOTS           35.99\n" +
            "\n" +
            "Subtotal                            156.95\n" +
            "Tax                                   0.00\n" +
            "------------------------------------------\n").dataUsingEncoding(encoding))
        
        builder.appendData(("Total                 ").dataUsingEncoding(encoding))
        
        builder.appendDataWithMultiple("   $156.95\n".dataUsingEncoding(encoding), width: 2, height: 2)
        
        builder.appendData((
            "------------------------------------------\n" +
            "\n" +
            "Charge\n" +
            "159.95\n" +
            "Visa XXXX-XXXX-XXXX-0123\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithInvert(("Refunds and Exchanges\n").dataUsingEncoding(encoding))
        
        builder.appendData(("Within ").dataUsingEncoding(encoding))
        
        builder.appendDataWithUnderLine(("30 days").dataUsingEncoding(encoding))
        
        builder.appendData((" with receipt\n").dataUsingEncoding(encoding))
        
        builder.appendData((
            "And tags attached\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
//      builder.appendBarcodeData("{BStar.".dataUsingEncoding(encoding),              symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height:,40, hri: true)
        builder.appendBarcodeData("{BStar.".dataUsingEncoding(NSASCIIStringEncoding), symbology: SCBBarcodeSymbology.Code128, width: SCBBarcodeWidth.Mode2, height: 40, hri: true)
    }
    
    override func appendDotImpact3inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        var encoding: NSStringEncoding
        
        if utf8 == true {
            encoding = NSUTF8StringEncoding
            
            builder.appendCodePage(SCBCodePageType.UTF8)
        }
        else {
            encoding = NSASCIIStringEncoding
            
            builder.appendCodePage(SCBCodePageType.CP998)
        }
        
        builder.appendInternational(SCBInternationalType.USA)
        
        builder.appendAlignment(SCBAlignmentPosition.Center)
        
        builder.appendData((
            "Star Clothing Boutique\n" +
            "123 Star Road\n" +
            "City, State 12345\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendAlignment(SCBAlignmentPosition.Left)
        
        builder.appendData((
            "Date:MM/DD/YYYY              Time:HH:MM PM\n" +
            "------------------------------------------\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithEmphasis(("SALE \n").dataUsingEncoding(encoding))
        
        builder.appendData((
            "SKU             Description          Total\n" +
            "300678566       PLAIN T-SHIRT        10.99\n" +
            "300692003       BLACK DENIM          29.99\n" +
            "300651148       BLUE DENIM           29.99\n" +
            "300642980       STRIPED DRESS        49.99\n" +
            "300638471       BLACK BOOTS          35.99\n" +
            "\n" +
            "Subtotal                            156.95\n" +
            "Tax                                   0.00\n" +
            "------------------------------------------\n" +
            "Total                              $156.95\n" +
            "------------------------------------------\n" +
            "\n" +
            "Charge\n" +
            "159.95\n" +
            "Visa XXXX-XXXX-XXXX-0123\n" +
            "\n").dataUsingEncoding(encoding))
        
        builder.appendDataWithInvert(("Refunds and Exchanges\n").dataUsingEncoding(encoding))
        
        builder.appendData(("Within").dataUsingEncoding(encoding))
        
        builder.appendDataWithUnderLine((" 30 days").dataUsingEncoding(encoding))
        
        builder.appendData((" with receipt\n").dataUsingEncoding(encoding))
    }
}
