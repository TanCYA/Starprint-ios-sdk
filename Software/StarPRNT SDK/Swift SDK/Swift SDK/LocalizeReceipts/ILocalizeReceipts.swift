//
//  ILocalizeReceipts.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import Foundation

class LocalizeReceipts {
    static func createLocalizeReceipts(languageIndex: LanguageIndex, paperSizeIndex: PaperSizeIndex) -> ILocalizeReceipts {
        var localizeReceipts: ILocalizeReceipts
        
        switch languageIndex {
        case LanguageIndex.English :
            localizeReceipts = EnglishReceiptsImpl()
        case LanguageIndex.Japanese :
            localizeReceipts = JapaneseReceiptsImpl()
        case LanguageIndex.French :
            localizeReceipts = FrenchReceiptsImpl()
        case LanguageIndex.Portuguese :
            localizeReceipts = PortugueseReceiptsImpl()
        case LanguageIndex.Spanish :
            localizeReceipts = SpanishReceiptsImpl()
        case LanguageIndex.Russian :
            localizeReceipts = RussianReceiptsImpl()
        case LanguageIndex.SimplifiedChinese :
            localizeReceipts = SimplifiedChineseReceiptsImpl()
//      case LanguageIndex.TraditionalChinese :
        default                               :
            localizeReceipts = TraditionalChineseReceiptsImpl()
        }
        
        switch paperSizeIndex {
        case PaperSizeIndex.TwoInch :
            localizeReceipts.paperSize      = "2\""
            localizeReceipts.scalePaperSize = "3\""     // 3inch -> 2inch
        case PaperSizeIndex.ThreeInch,
             PaperSizeIndex.EscPosThreeInch,
             PaperSizeIndex.DotImpactThreeInch :
            localizeReceipts.paperSize      = "3\""
            localizeReceipts.scalePaperSize = "4\""     // 4inch -> 3inch
//      case PaperSizeIndex.FourInch :
        default                      :
            localizeReceipts.paperSize      = "4\""
            localizeReceipts.scalePaperSize = "3\""     // 3inch -> 4inch
        }
        
        localizeReceipts.languageIndex  = languageIndex
        localizeReceipts.paperSizeIndex = paperSizeIndex
        
        return localizeReceipts
    }
}

class ILocalizeReceipts {
    private var languageIndex:  LanguageIndex!
    private var paperSizeIndex: PaperSizeIndex!
    
    var languageCode:   String!
    var paperSize:      String!
    var scalePaperSize: String!
    
    func appendTextReceiptData(builder: ISCBBuilder, utf8: Bool) {
        switch self.paperSizeIndex! {
        case PaperSizeIndex.TwoInch :
            self.append2inchTextReceiptData         (builder, utf8: utf8)
        case PaperSizeIndex.ThreeInch :
            self.append3inchTextReceiptData         (builder, utf8: utf8)
        case PaperSizeIndex.FourInch :
            self.append4inchTextReceiptData         (builder, utf8: utf8)
        case PaperSizeIndex.EscPosThreeInch :
            self.appendEscPos3inchTextReceiptData   (builder, utf8: utf8)
//      case PaperSizeIndex.DotImpactThreeInch :
        default                                :
            self.appendDotImpact3inchTextReceiptData(builder, utf8: utf8)
        }
    }
    
    func createRasterReceiptImage() -> UIImage? {
        let image: UIImage
        
        switch self.paperSizeIndex! {
        case PaperSizeIndex.TwoInch :
            image = self.create2inchRasterReceiptImage()!
        case PaperSizeIndex.ThreeInch :
            image = self.create3inchRasterReceiptImage()!
        case PaperSizeIndex.FourInch :
            image = self.create4inchRasterReceiptImage()!
        case PaperSizeIndex.EscPosThreeInch :
            image = self.createEscPos3inchRasterReceiptImage()!
//      case PaperSizeIndex.DotImpactThreeInch :
        default                                :
            image = self.createCouponImage()!
        }
        
        return image
    }
    
    func createScaleRasterReceiptImage() -> UIImage? {
        let image: UIImage
        
        switch self.paperSizeIndex! {
        case PaperSizeIndex.TwoInch :
            image = self.create3inchRasterReceiptImage()!      // 3inch -> 2inch
        case PaperSizeIndex.ThreeInch,
             PaperSizeIndex.EscPosThreeInch :
            image = self.create4inchRasterReceiptImage()!      // 4inch -> 3inch
        case PaperSizeIndex.FourInch :
            image = self.create3inchRasterReceiptImage()!      // 3inch -> 4inch
//      case PaperSizeIndex.DotImpactThreeInch :
        default                                :
            image = self.createCouponImage()!
        }
        
        return image
    }
    
    func append2inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {     // abstract!!!
    }
    
    func append3inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {     // abstract!!!
    }
    
    func append4inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {     // abstract!!!
    }
    
    func create2inchRasterReceiptImage() -> UIImage? {     // abstract!!!
        return nil
    }
    
    func create3inchRasterReceiptImage() -> UIImage? {     // abstract!!!
        return nil
    }
    
    func create4inchRasterReceiptImage() -> UIImage? {     // abstract!!!
        return nil
    }
    
    func createCouponImage() -> UIImage? {     // abstract!!!
        return nil
    }
    
    func createEscPos3inchRasterReceiptImage() -> UIImage? {     // abstract!!!
        return nil
    }
    
    func appendEscPos3inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {     // abstract!!!
    }
    
    func appendDotImpact3inchTextReceiptData(builder: ISCBBuilder, utf8: Bool) {     // abstract!!!
    }
    
    static func imageWithString(string: String, font: UIFont, width: CGFloat) -> UIImage {
        let attributeDic: NSDictionary = NSDictionary(dictionary: [NSFontAttributeName : font])
        
        let stringDrawingOptions: NSStringDrawingOptions = [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.TruncatesLastVisibleLine]
        
        let size: CGSize = (string.boundingRectWithSize(CGSizeMake(width, 10000), options: stringDrawingOptions, attributes: attributeDic as? [String : AnyObject], context: nil)).size
        
//      if UIScreen.mainScreen().respondsToSelector                                  ("scale") {
        if UIScreen.mainScreen().respondsToSelector(#selector(NSDecimalNumberBehaviors.scale)) {
            if UIScreen.mainScreen().scale == 2.0 {
                UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
            } else {
                UIGraphicsBeginImageContext(size)
            }
        } else {
            UIGraphicsBeginImageContext(size)
        }
        
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        UIColor.whiteColor().set()
        
        let rect: CGRect = CGRectMake(0, 0, size.width + 1, size.height + 1)
        
        CGContextFillRect(context, rect)
        
        let attributes: NSDictionary = NSDictionary(dictionary: [NSForegroundColorAttributeName : UIColor.blackColor(), NSFontAttributeName : font])
        
        string.drawInRect(rect, withAttributes: attributes as? [String : AnyObject])
        
        let imageToPrint: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imageToPrint
    }
}
