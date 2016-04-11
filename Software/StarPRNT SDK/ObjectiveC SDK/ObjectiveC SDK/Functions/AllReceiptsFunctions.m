//
//  AllReceiptsFunctions.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "AllReceiptsFunctions.h"

#import <SMCloudServices/SMCSAllReceipts.h>

@implementation AllReceiptsFunctions

+ (NSData *)createRasterReceiptData:(StarIoExtEmulation)emulation
                   localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                            receipt:(BOOL)receipt
                               info:(BOOL)info
                             qrCode:(BOOL)qrCode
                         completion:(void (^)(NSInteger statusCode, NSError *error))completion {
    UIImage *image = [localizeReceipts createRasterReceiptImage];
    
    NSString *urlString = [SMCSAllReceipts uploadBitmap:image completion:completion];
    
    if (receipt == YES ||
        info    == YES ||
        qrCode  == YES) {
        ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
        
        [builder beginDocument];
        
        if (receipt == YES) {
            [builder appendBitmap:image diffusion:NO];
        }
        
        if (info   == YES ||
            qrCode == YES) {
            NSData *data = [SMCSAllReceipts generateAllReceipts:urlString emulation:emulation info:info qrCode:qrCode];
            
//          [builder appendData   :data];
            [builder appendRawData:data];
        }
        
        [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
        
        [builder endDocument];
        
        return [builder.commands copy];
    }
    
    return nil;
}

+ (NSData *)createScaleRasterReceiptData:(StarIoExtEmulation)emulation
                        localizeReceipts:(ILocalizeReceipts *)localizeReceipts
                                   width:(NSInteger)width
                               bothScale:(BOOL)bothScale
                                 receipt:(BOOL)receipt
                                    info:(BOOL)info
                                  qrCode:(BOOL)qrCode
                              completion:(void (^)(NSInteger statusCode, NSError *error))completion {
    UIImage *image = [localizeReceipts createScaleRasterReceiptImage];
    
    if (receipt == YES ||
        info    == YES ||
        qrCode  == YES) {
        NSString *urlString = [SMCSAllReceipts uploadBitmap:image completion:completion];
        
        ISCBBuilder *builder = [StarIoExt createCommandBuilder:emulation];
        
        [builder beginDocument];
        
        if (receipt == YES) {
            [builder appendBitmap:image diffusion:NO width:width bothScale:bothScale];
        }
        
        if (info   == YES ||
            qrCode == YES) {
            NSData *data = [SMCSAllReceipts generateAllReceipts:urlString emulation:emulation info:info qrCode:qrCode];
            
//          [builder appendData   :data];
            [builder appendRawData:data];
        }
        
        [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
        
        [builder endDocument];
        
        return [builder.commands copy];
    }
    
    return nil;
}

@end
