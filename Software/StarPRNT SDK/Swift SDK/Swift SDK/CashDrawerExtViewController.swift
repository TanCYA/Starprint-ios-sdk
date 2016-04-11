//
//  CashDrawerExtViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CashDrawerExtViewController: CommonViewController, StarIoExtManagerDelegate, UIAlertViewDelegate {
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var openButton: UIButton!
    
    var starIoExtManager: StarIoExtManager!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.commentLabel.text = ""
        
        self.commentLabel.adjustsFontSizeToFitWidth = true
        
        self.openButton.enabled           = true
        self.openButton.backgroundColor   = UIColor.cyanColor()
        self.openButton.layer.borderColor = UIColor.blueColor().CGColor
        self.openButton.layer.borderWidth = 1.0
        
//      self.appendRefreshButton                                     ("refreshCashDrawer")
        self.appendRefreshButton(#selector(CashDrawerExtViewController.refreshCashDrawer))
        
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
        
//      NSNotificationCenter.defaultCenter().addObserver(self, selector:                                      "applicationDidBecomeActive", name: "UIApplicationDidBecomeActiveNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CashDrawerExtViewController.applicationDidBecomeActive), name: "UIApplicationDidBecomeActiveNotification", object: nil)
        
//      self.refreshCashDrawer()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.refreshCashDrawer()
        
        if self.didAppear == false {
            if self.starIoExtManager.port != nil {
                self.openButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
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
    
    @IBAction func touchUpInsideOpenButton(sender: UIButton) {
        let commands: NSData
        
        switch AppDelegate.getSelectedIndex() {
        case 0, 1 :
            commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.No1)
//      case 2, 3 :
        default   :
            commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.No2)
        }
        
        self.blind = true
        
        self.starIoExtManager.lock.lock()
        
        switch AppDelegate.getSelectedIndex() {
        case 0, 2 :
            Communication.sendCommands                   (commands, port: self.starIoExtManager.port)
//      case 1, 3 :
        default   :
            Communication.sendCommandsDoNotCheckCondition(commands, port: self.starIoExtManager.port)
        }
        
        self.starIoExtManager.lock.unlock()
        
        self.blind = false
    }
    
    func refreshCashDrawer() {
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
    
    func didCashDrawerOpen(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Cash Drawer Open."
        
//      self.commentLabel.textColor = UIColor.redColor()
        self.commentLabel.textColor = UIColor.magentaColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didCashDrawerClose(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Cash Drawer Close."
        
        self.commentLabel.textColor = UIColor.blueColor()
        
        self.beginAnimationCommantLabel()
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
