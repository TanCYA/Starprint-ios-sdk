//
//  AppDelegate.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

enum LanguageIndex: Int {
    case English = 0
    case Japanese
    case French
    case Portuguese
    case Spanish
    case Russian
    case SimplifiedChinese
    case TraditionalChinese
}

enum PaperSizeIndex: Int {
    case TwoInch = 384
    case ThreeInch = 576
    case FourInch = 832
    case EscPosThreeInch = 512
    case DotImpactThreeInch = 210
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static func isSystemVersionEqualTo(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
    }
    
    static func isSystemVersionGreaterThan(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }
    
    static func isSystemVersionGreaterThanOrEqualTo(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
    }
    
    static func isSystemVersionLessThan(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
    }
    
    static func isSystemVersionLessThanOrEqualTo(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
    }
    
    static func isIPhone() -> Bool {
        return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
    }
    
    static func isIPad() -> Bool {
        return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
    }
    
    var window: UIWindow?
    
    var portName:     String!
    var portSettings: String!
    var modelName:    String!
    var macAddress:   String!
    
    var emulation:           StarIoExtEmulation!
    var allReceiptsSettings: Int!
    var selectedIndex:       Int!
    var selectedLanguage:    LanguageIndex!
    var selectedPaperSize:   PaperSizeIndex!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        NSThread.sleepForTimeInterval(1.0)     // 1000mS!!!
        
        self.loadParam()
        
        self.selectedIndex     = 0
        self.selectedLanguage  = LanguageIndex.English
        self.selectedPaperSize = PaperSizeIndex.TwoInch
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func loadParam() {
        let userDafaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        userDafaults.registerDefaults(["portName"            : ""])
        userDafaults.registerDefaults(["portSettings"        : ""])
        userDafaults.registerDefaults(["modelName"           : ""])
        userDafaults.registerDefaults(["macAddress"          : ""])
        userDafaults.registerDefaults(["emulation"           : StarIoExtEmulation.StarPRNT.rawValue])
        userDafaults.registerDefaults(["allReceiptsSettings" : 0x00000007])
        
        self.portName            =                              userDafaults.stringForKey ("portName")
        self.portSettings        =                              userDafaults.stringForKey ("portSettings")
        self.modelName           =                              userDafaults.stringForKey ("modelName")
        self.macAddress          =                              userDafaults.stringForKey ("macAddress")
        self.emulation           = StarIoExtEmulation(rawValue: userDafaults.integerForKey("emulation"))
        self.allReceiptsSettings =                              userDafaults.integerForKey("allReceiptsSettings")
    }
    
    static func getPortName() -> String {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return delegate.portName!
    }
    
    static func setPortName(portName: String) {
        let userDafaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        delegate.portName = portName
        
        userDafaults.setObject(delegate.portName, forKey: "portName")
        
        userDafaults.synchronize()
    }
    
    static func getPortSettings() -> String {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return delegate.portSettings!
    }
    
    static func setPortSettings(portSettings: String) {
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        delegate.portSettings = portSettings
        
        userDefaults.setObject(delegate.portSettings, forKey: "portSettings")
        
        userDefaults.synchronize()
    }
    
    static func getModelName() -> String {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return delegate.modelName!
    }
    
    static func setModelName(modelName: String) {
        let userDafaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        delegate.modelName = modelName
        
        userDafaults.setObject(delegate.modelName, forKey:"modelName")
        
        userDafaults.synchronize()
    }
    
    static func getMacAddress() -> String {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return delegate.macAddress!
    }
    
    static func setMacAddress(macAddress: String) {
        let userDafaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        delegate.macAddress = macAddress
        
        userDafaults.setObject(delegate.macAddress, forKey:"macAddress")
        
        userDafaults.synchronize()
    }
    
    static func getEmulation() -> StarIoExtEmulation {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return delegate.emulation!
    }
    
    static func setEmulation(emulation: StarIoExtEmulation) {
        let userDafaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        delegate.emulation = emulation
        
        userDafaults.setInteger(delegate.emulation.rawValue, forKey:"emulation")
        
        userDafaults.synchronize()
    }
    
    static func getAllReceiptsSettings() -> Int {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return delegate.allReceiptsSettings!
    }
    
    static func setAllReceiptsSettings(allReceiptsSettings: Int) {
        let userDafaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        delegate.allReceiptsSettings = allReceiptsSettings
        
        userDafaults.setInteger(delegate.allReceiptsSettings, forKey:"allReceiptsSettings")
        
        userDafaults.synchronize()
    }
    
    static func getSelectedIndex() -> Int {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return delegate.selectedIndex!
    }
    
    static func setSelectedIndex(index: Int) {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        delegate.selectedIndex = index
    }
    
    static func getSelectedLanguage() -> LanguageIndex {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return delegate.selectedLanguage!
    }
    
    static func setSelectedLanguage(index: LanguageIndex) {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        delegate.selectedLanguage = index
    }
    
    static func getSelectedPaperSize() -> PaperSizeIndex {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        return delegate.selectedPaperSize!
    }
    
    static func setSelectedPaperSize(index: PaperSizeIndex) {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        delegate.selectedPaperSize = index
    }
}
