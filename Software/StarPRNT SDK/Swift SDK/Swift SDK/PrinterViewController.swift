//
//  PrinterViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class PrinterViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
            
            switch indexPath.row {
            case 0 :
                cell.textLabel!.text = String(format: "%@ %@ Text Receipt",                localizeReceipts.languageCode, localizeReceipts.paperSize)
            case 1 :
                cell.textLabel!.text = String(format: "%@ %@ Text Receipt (UTF8)",         localizeReceipts.languageCode, localizeReceipts.paperSize)
            case 2 :
                cell.textLabel!.text = String(format: "%@ %@ Raster Receipt",              localizeReceipts.languageCode, localizeReceipts.paperSize)
            case 3 :
                cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Both Scale)", localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
            case 4 :
                cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Scale)",      localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
            case 5 :
                cell.textLabel!.text = String(format: "%@ Raster Coupon",                  localizeReceipts.languageCode)
//          case 6  :
            default :
                cell.textLabel!.text = String(format: "%@ Raster Coupon (Rotation90)",     localizeReceipts.languageCode)
            }
            
            cell.detailTextLabel!.text = ""
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
//          cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            var userInteractionEnabled: Bool = true
            
            let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
            
            if emulation == StarIoExtEmulation.StarGraphic {
                if (indexPath.row == 0 ||     // Text Receipt
                    indexPath.row == 1) {     // Text Receipt (UTF8)
                    userInteractionEnabled = false
                }
            }
            
            if emulation == StarIoExtEmulation.EscPos ||
               emulation == StarIoExtEmulation.EscPosMobile {
                if indexPath.row == 1 {     // Text Receipt (UTF8)
                    userInteractionEnabled = false
                }
            }
            
            if emulation == StarIoExtEmulation.StarDotImpact {
                if indexPath.row == 2 ||     // Raster Receipt
                   indexPath.row == 3 ||     // Raster Receipt (Both Scale)
                   indexPath.row == 4 {      // Raster Receipt (Scale)
                    userInteractionEnabled = false
                }
            }
            
            if userInteractionEnabled == true {
                cell      .textLabel!.alpha = 1.0
                cell.detailTextLabel!.alpha = 1.0
                
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
                cell.userInteractionEnabled = true
            }
            else {
                cell      .textLabel!.alpha = 0.3
                cell.detailTextLabel!.alpha = 0.3
                
                cell.accessoryType = UITableViewCellAccessoryType.None
                
                cell.userInteractionEnabled = false
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String
        
        if section == 0 {
            title = "Like a StarIO-SDK Sample"
        }
        else {
            title = "StarIoExtManager Sample"
        }
        
        return title
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 {
            var commands: NSData
            
            let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
            
            let width: Int = AppDelegate.getSelectedPaperSize().rawValue
            
            let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: AppDelegate.getSelectedPaperSize())
            
            switch indexPath.row {
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
//          case 6  :
            default :
                commands = PrinterFunctions.createCouponData(emulation, localizeReceipts: localizeReceipts, width: width, rotation: SCBBitmapConverterRotation.Right90)
            }
            
            self.blind = true
            
            Communication.sendCommands(commands, portName: AppDelegate.getPortName(), portSettings: AppDelegate.getPortSettings(), timeout: 10000)     // 10000mS!!!
            
            self.blind = false
        }
        else {
            AppDelegate.setSelectedIndex(indexPath.row)
            
            self.performSegueWithIdentifier("PushPrinterExtViewController", sender: nil)
        }
    }
}
