//
//  AppDelegate.m
//  IOS_SDK
//
//  Created by satsuki on 12/07/13.
//  Copyright 2012 - 2013 STAR MICRONICS CO., LTD. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

static NSString *portName = nil;
static NSString *portSettings = nil;
static NSString *drawerPortName = nil;

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

#pragma mark getter/setter

+ (NSString*)getPortName
{
    return portName;
}

+ (void)setPortName:(NSString *)m_portName
{
    if (portName != m_portName) {
        [portName release];
        portName = [m_portName copy];
    }    
}

+ (NSString *)getPortSettings
{
    return portSettings;
}

+ (void)setPortSettings:(NSString *)m_portSettings
{
    if (portSettings != m_portSettings) {
        [portSettings release];
        portSettings = [m_portSettings copy];
    }
}

+ (NSString *)getDrawerPortName {
    return drawerPortName;
}

+ (void)setDrawerPortName:(NSString *)portName {
    if (drawerPortName != portName) {
        [drawerPortName release];
        drawerPortName = [portName copy];
    }
}

#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.

    UIViewController *viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

+ (void)setButtonArrayAsOldStyle:(NSArray *)buttons {
    for (id object in buttons) {
        if ([object isKindOfClass:[UIButton class]] == NO) {
            continue;
        }
        
        UIButton *button = (UIButton *)object;
        button.layer.backgroundColor = [[UIColor whiteColor] CGColor];
        button.layer.borderColor = [[UIColor grayColor] CGColor];
        button.layer.borderWidth = 1.0;
        button.layer.cornerRadius = 10.0;
        button.clipsToBounds = YES;
    }
}

+ (SMPrinterType)parsePortSettings:(NSString *)portSettings {
    if (portSettings == nil) {
        return SMPrinterTypeDesktopPrinterStarLine;
    }
    
    NSArray *params = [portSettings componentsSeparatedByString:@";"];
    
    BOOL isESCPOSMode = NO;
    BOOL isPortablePrinter = NO;
    
    for (NSString *param in params) {
        NSString *str = [param stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        
        if ([str caseInsensitiveCompare:@"mini"] == NSOrderedSame) {
            return SMPrinterTypePortablePrinterESCPOS;
        }
        
        if ([str caseInsensitiveCompare:@"Portable"] == NSOrderedSame) {
            isPortablePrinter = YES;
            continue;
        }
        
        if ([str caseInsensitiveCompare:@"escpos"] == NSOrderedSame) {
            isESCPOSMode = YES;
            continue;
        }
    }
    
    if (isPortablePrinter) {
        if (isESCPOSMode) {
            return SMPrinterTypePortablePrinterESCPOS;
        } else {
            return SMPrinterTypePortablePrinterStarLine;
        }
    }

    return SMPrinterTypeDesktopPrinterStarLine;
}

#pragma mark Help

+ (NSString *)HTMLCSS
{
    NSString *cssDefninition = @"<html>\
    <head>\
    <style type=\"text/css\">\
    Code {color:blue;}\n\
    CodeDef {color:blue;font-weight:bold}\n\
    TitleBold {font-weight:bold}\n\
    It1 {font-style:italic; font-size:12}\n\
    LargeTitle{font-size:20px}\n\
    SectionHeader{font-size:17;font-weight:bold}\n\
    UnderlineTitle {text-decoration:underline}\n\
    div_cutParam {position:absolute; top:100; left:30; width:200px;font-style:italic;}\n\
    div_cutParam0 {position:absolute; top:130; left:30; font-style:italic;}\n\
    div_cutParam1 {position:absolute; top:145; left:30; font-style:italic;}\n\
    div_cutParam2 {position:absolute; top:160; left:30; font-style:italic;}\n\
    div_cutParam3 {position:absolute; top:175; left:30; font-style:italic;}\n\
    .div-tableBarcodeWidth{display:table;}\n\
    .div-table-rowBarcodeWidth{display:table-row;}\n\
    .div-table-colBarcodeWidthHeader{display:table-cell;border:1px solid #000000;background: #800000;color:#ffffff}\n\
    .div-table-colBarcodeWidthHeader2{display:table-cell;border:1px solid #000000;background: #800000;color:#ffffff}\n\
    .div-table-colBarcodeWidth{display:table-cell;border:1px solid #000000;}\n\
    rightMov {position:absolute; left:30px; font-style:italic;}\n\
    rightMov_NOI {position:absolute; left:55px;}\n\
    rightMov_NOI2 {position:absolute; left:90px;}\n\
    StandardItalic {font-style:italic}\
    .div-tableCut{display:table;}\n\
    .div-table-rowCut{display:table-row;}\n\
    .div-table-colFirstCut{display:table-cell;width:40px}\n\
    .div-table-colCut{display:table-cell;}\n\
    .div-table-colRaster{display:table-cell; border:1px solid #000000;}\n\
    </style>\
    </head>";

    return cssDefninition;
}

@end
