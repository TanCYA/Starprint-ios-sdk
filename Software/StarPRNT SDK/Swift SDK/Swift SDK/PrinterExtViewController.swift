//
//  PrinterExtViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class PrinterExtViewController: CommonViewController, StarIoExtManagerDelegate, UIAlertViewDelegate {
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var printButton: UIButton!
    
    var starIoExtManager: StarIoExtManager!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.commentLabel.text = ""
        
        self.commentLabel.adjustsFontSizeToFitWidth = true
        
        self.printButton.enabled           = true
        self.printButton.backgroundColor   = UIColor.cyanColor()
        self.printButton.layer.borderColor = UIColor.blueColor().CGColor
        self.printButton.layer.borderWidth = 1.0
        
//      self.appendRefreshButton                                  ("refreshPrinter")
        self.appendRefreshButton(#selector(PrinterExtViewController.refreshPrinter))
        
        self.starIoExtManager = StarIoExtManager(type: StarIoExtManagerType.Standard,
                                             portName: AppDelegate.getPortName(),
                                         portSettings: AppDelegate.getPortSettings(),
                                      ioTimeoutMillis: 10000)                             // 10000mS!!!
        
        self.starIoExtManager.delegate = self
        
        self.didAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//      NSNotificationCenter.defaultCenter().addObserver(self, selector:                                   "applicationDidBecomeActive", name: "UIApplicationDidBecomeActiveNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PrinterExtViewController.applicationDidBecomeActive), name: "UIApplicationDidBecomeActiveNotification", object: nil)
        
//      self.refreshPrinter()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.refreshPrinter()
        
        if self.didAppear == false {
            if self.starIoExtManager.port != nil {
                self.printButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            
            self.didAppear = true
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.starIoExtManager.disconnect()
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "applicationDidBecomeActive", object: nil)
    }
    
    func applicationDidBecomeActive() {
        self.beginAnimationCommantLabel()
    }
    
    @IBAction func touchUpInsidePrintButton(sender: UIButton) {
        var commands: NSData
        
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        let width: Int = AppDelegate.getSelectedPaperSize().rawValue
        
        let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
        
        switch AppDelegate.getSelectedIndex() {
        case 0 :
            commands = PrinterFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: false)
        case 1 :
            commands = PrinterFunctions.createTextReceiptData(emulation, localizeReceipts: localizeReceipts, utf8: true)
        case 2 :
            commands = PrinterFunctions.createRasterReceiptData(emulation, localizeReceipts: localizeReceipts)
        case 3 :
            commands = PrinterFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: true)
        case 4 :
            commands = PrinterFunctions.createScaleRasterReceiptData(emulation, localizeReceipts: localizeReceipts, width: width, bothScale: false)
        case 5 :
            commands = PrinterFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.Normal)
//      case 6  :
        default :
            commands = PrinterFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.Right90)
        }
        
        self.blind = true
        
        self.starIoExtManager.lock.lock()
        
        Communication.sendCommands(commands, port: self.starIoExtManager.port)
        
        self.starIoExtManager.lock.unlock()
        
        self.blind = false
    }
    
    func refreshPrinter() {
        self.blind = true
        
        if self.starIoExtManager.port != nil {
            self.starIoExtManager.disconnect()
        }
        
        if self.starIoExtManager.connect() == false {
            let alertView: UIAlertView = UIAlertView(title: "Fail to Open Port.", message: "", delegate: self, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        self.blind = false
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.commentLabel.text = "Check the device. (Power and Bluetooth pairing)\nThen touch up the Refresh button."
        
        self.commentLabel.textColor = UIColor.redColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterImpossible(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Impossible."
        
        self.commentLabel.textColor = UIColor.redColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterOnline(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Online."
        
        self.commentLabel.textColor = UIColor.blueColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterOffline(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = "Printer Offline."
//
//      self.commentLabel.textColor = UIColor.redColor()
//
//      self.beginAnimationCommantLabel()
    }
    
    func didPrinterPaperReady(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = "Printer Paper Ready."
//
//      self.commentLabel.textColor = UIColor.blueColor()
//
//      self.beginAnimationCommantLabel()
    }
    
    func didPrinterPaperNearEmpty(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Paper Near Empty."
        
        self.commentLabel.textColor = UIColor.orangeColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterPaperEmpty(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Paper Empty."
        
        self.commentLabel.textColor = UIColor.redColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterCoverOpen(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Printer Cover Open."
        
        self.commentLabel.textColor = UIColor.redColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didPrinterCoverClose(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = "Printer Cover Close."
//
//      self.commentLabel.textColor = UIColor.blueColor()
//
//      self.beginAnimationCommantLabel()
    }
    
    func didAccessoryConnectSuccess(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Accessory Connect Success."
        
        self.commentLabel.textColor = UIColor.blueColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didAccessoryConnectFailure(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Accessory Connect Failure."
        
        self.commentLabel.textColor = UIColor.redColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didAccessoryDisconnect(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Accessory Disconnect."
        
        self.commentLabel.textColor = UIColor.redColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didStatusUpdate(manager: StarIoExtManager!, status: String!) {
        NSLog("%@", MakePrettyFunction())
        
//      self.commentLabel.text = status
//
//      self.commentLabel.textColor = UIColor.greenColor()
//
//      self.beginAnimationCommantLabel()
    }
    
    private func beginAnimationCommantLabel() {
        UIView.beginAnimations(nil, context: nil)
        
        self.commentLabel.alpha = 0.0
        
        UIView.setAnimationDelay             (0.0)                             // 0mS!!!
        UIView.setAnimationDuration          (0.6)                             // 600mS!!!
        UIView.setAnimationRepeatCount       (Float(UINT32_MAX))
        UIView.setAnimationRepeatAutoreverses(true)
        UIView.setAnimationCurve             (UIViewAnimationCurve.EaseIn)
        
        self.commentLabel.alpha = 1.0
        
        UIView.commitAnimations()
    }
}
