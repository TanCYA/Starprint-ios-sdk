//
//  BarcodeReaderExtViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class BarcodeReaderExtViewController: CommonViewController, StarIoExtManagerDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    enum CellParamIndex: Int {
        case BarcodeData = 0
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    var cellArray: NSMutableArray!
    
    var starIoExtManager: StarIoExtManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.commentLabel.text = ""
        
        self.commentLabel.adjustsFontSizeToFitWidth = true
        
//      self.appendRefreshButton                                        ("refreshBarcodeReader")
        self.appendRefreshButton(#selector(BarcodeReaderExtViewController.refreshBarcodeReader))
        
        self.cellArray = NSMutableArray()
        
        self.starIoExtManager = StarIoExtManager(type: StarIoExtManagerType.OnlyBarcodeReader,
                                             portName: AppDelegate.getPortName(),
                                         portSettings: AppDelegate.getPortSettings(),
                                      ioTimeoutMillis: 10000)                                      // 10000mS!!!
        
        self.starIoExtManager.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//      NSNotificationCenter.defaultCenter().addObserver(self, selector:                                         "applicationDidBecomeActive", name: "UIApplicationDidBecomeActiveNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BarcodeReaderExtViewController.applicationDidBecomeActive), name: "UIApplicationDidBecomeActiveNotification", object: nil)
        
//      self.refreshBarcodeReader()
        
        self.blind = true
        
//      self.cellArray.removeAllObjects()
        
        if self.starIoExtManager.port != nil {
            self.starIoExtManager.disconnect()
        }
        
        if self.starIoExtManager.connect() == false {
            let alertView: UIAlertView = UIAlertView(title: "Fail to Open Port.", message: "", delegate: self, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        self.tableView.reloadData()
        
        self.blind = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.starIoExtManager.disconnect()
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "applicationDidBecomeActive", object: nil)
    }
    
    func applicationDidBecomeActive() {
        self.beginAnimationCommantLabel()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellParam: [String] = self.cellArray[indexPath.row] as! [String]
        
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
//      var cell: UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        var cell: UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            cell      .textLabel!.text = cellParam[CellParamIndex.BarcodeData.rawValue]
            cell.detailTextLabel!.text = ""
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Contents"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func refreshBarcodeReader() {
        self.blind = true
        
        self.cellArray.removeAllObjects()
        
        if self.starIoExtManager.port != nil {
            self.starIoExtManager.disconnect()
        }
        
        if self.starIoExtManager.connect() == false {
            let alertView: UIAlertView = UIAlertView(title: "Fail to Open Port.", message: "", delegate: self, cancelButtonTitle: "OK")
            
            alertView.show()
        }
        
        self.tableView.reloadData()
        
        self.blind = false
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.commentLabel.text = "Check the device. (Power and Bluetooth pairing)\nThen touch up the Refresh button."
        
        self.commentLabel.textColor = UIColor.redColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didBarcodeDataReceive(manager: StarIoExtManager!, data: NSData!) {
        NSLog("%@", MakePrettyFunction())
        
        var text: String = ""
        
        var buffer: Array<UInt8> = Array<UInt8>(count: data.length, repeatedValue: 0)
        
        data.getBytes(&buffer, length: data.length)
        
        for i: Int in 0 ..< data.length {
            let ch: UInt8 = buffer[i]
            
            if ch >= 0x20 && ch <= 0x7f {
                text += String(format: "%c", ch)
            }
            else if ch == 0x0d {
                if self.cellArray.count > 30 {     // Max.30Line
                    self.cellArray.removeObjectAtIndex(0)
                    
                    self.tableView.reloadData()
                }
                
                self.cellArray.addObject([text])
                
                text = ""
            }
        }
        
        self.tableView.reloadData()
        
        let indexPath: NSIndexPath = NSIndexPath(forRow: self.cellArray.count - 1, inSection: 0)
        
//      self.tableView.selectRowAtIndexPath(indexPath, animated:false, scrollPosition: UITableViewScrollPosition.Bottom)
        self.tableView.selectRowAtIndexPath(indexPath, animated:true,  scrollPosition: UITableViewScrollPosition.Bottom)
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    func didBarcodeReaderImpossible(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Barcode Reader Impossible."
        
        self.commentLabel.textColor = UIColor.redColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didBarcodeReaderConnect(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Barcode Reader Connect."
        
        self.commentLabel.textColor = UIColor.blueColor()
        
        self.beginAnimationCommantLabel()
    }
    
    func didBarcodeReaderDisconnect(manager: StarIoExtManager!) {
        NSLog("%@", MakePrettyFunction())
        
        self.commentLabel.text = "Barcode Reader Disconnect."
        
        self.commentLabel.textColor = UIColor.redColor()
        
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
