//
//  AppDelegate.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <StarIO_Extension/StarIoExt.h>

#define SYSTEM_VERSION_EQUAL_TO(ver)                 ([[[UIDevice currentDevice] systemVersion] compare:ver options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(ver)             ([[[UIDevice currentDevice] systemVersion] compare:ver options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(ver) ([[[UIDevice currentDevice] systemVersion] compare:ver options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(ver)                ([[[UIDevice currentDevice] systemVersion] compare:ver options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(ver)    ([[[UIDevice currentDevice] systemVersion] compare:ver options:NSNumericSearch] != NSOrderedDescending)

#define IS_IPHONE() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD()   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

typedef NS_ENUM(NSInteger, LanguageIndex) {
    LanguageIndexEnglish = 0,
    LanguageIndexJapanese,
    LanguageIndexFrench,
    LanguageIndexPortuguese,
    LanguageIndexSpanish,
    LanguageIndexRussian,
    LanguageIndexSimplifiedChinese,
    LanguageIndexTraditionalChinese
};

typedef NS_ENUM(NSInteger, PaperSizeIndex) {
    PaperSizeIndexTwoInch = 384,
    PaperSizeIndexThreeInch = 576,
    PaperSizeIndexFourInch = 832,
    PaperSizeIndexEscPosThreeInch = 512,
    PaperSizeIndexDotImpactThreeInch = 210
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (NSString *)getPortName;

+ (void)setPortName:(NSString *)portName;

+ (NSString *)getPortSettings;

+ (void)setPortSettings:(NSString *)portSettings;

+ (NSString *)getModelName;

+ (void)setModelName:(NSString *)modelName;

+ (NSString *)getMacAddress;

+ (void)setMacAddress:(NSString *)macAddress;

+ (StarIoExtEmulation)getEmulation;

+ (void)setEmulation:(StarIoExtEmulation)emulation;

+ (NSInteger)getAllReceiptsSettings;

+ (void)setAllReceiptsSettings:(NSInteger)allReceiptsSettings;

+ (NSInteger)getSelectedIndex;

+ (void)setSelectedIndex:(NSInteger)index;

+ (LanguageIndex)getSelectedLanguage;

+ (void)setSelectedLanguage:(LanguageIndex)index;

+ (PaperSizeIndex)getSelectedPaperSize;

+ (void)setSelectedPaperSize:(PaperSizeIndex)index;

@end
