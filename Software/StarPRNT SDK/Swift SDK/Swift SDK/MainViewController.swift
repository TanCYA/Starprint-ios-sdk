//
//  MainViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class MainViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    enum SectionIndex: Int {
        case Device = 0
        case Printer
        case CashDrawer
        case BarcodeReader
        case Combination
        case Api
        case AllReceipts
    }
    
    enum AlertViewIndex: Int {
        case Language = 0
        case LanguageFixedPaperSize
        case PaperSize
        case Confirm
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndexPath: NSIndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let title: String = "StarPRNT Swift SDK"
        
        let version: String = String(format: "Ver.%@", NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String)
        
        self.navigationItem.title = String(format: "%@ %@", title, version)
        
        self.selectedIndexPath = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//      return SectionIndex.Device       .rawValue + 1
//      return SectionIndex.Printer      .rawValue + 1
//      return SectionIndex.CashDrawer   .rawValue + 1
//      return SectionIndex.BarcodeReader.rawValue + 1
//      return SectionIndex.Combination  .rawValue + 1
//      return SectionIndex.Api          .rawValue + 1
        return SectionIndex.AllReceipts  .rawValue + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if SectionIndex(rawValue: indexPath.section)! == SectionIndex.Device {
            if AppDelegate.getModelName() == "" {
                let cellIdentifier: String = "UITableViewCellStyleValue1"
                
                cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
                
                if cell == nil {
                    cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
                }
                
                if cell != nil {
                    cell.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
                    
                    cell      .textLabel!.text = "Unselected State"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor.redColor()
                    cell.detailTextLabel!.textColor = UIColor.redColor()
                    
                    UIView.beginAnimations(nil, context: nil)
                    
                    cell      .textLabel!.alpha = 0.0
                    cell.detailTextLabel!.alpha = 0.0
                    
                    UIView.setAnimationDelay             (0.0)                             // 0mS!!!
                    UIView.setAnimationDuration          (0.6)                             // 600mS!!!
                    UIView.setAnimationRepeatCount       (Float(UINT32_MAX))
                    UIView.setAnimationRepeatAutoreverses(true)
                    UIView.setAnimationCurve             (UIViewAnimationCurve.EaseIn)
                    
                    cell      .textLabel!.alpha = 1.0
                    cell.detailTextLabel!.alpha = 1.0
                    
                    UIView.commitAnimations()
                    
                    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                    
                    cell.userInteractionEnabled = true
                }
            }
            else {
                let cellIdentifier: String = "UITableViewCellStyleSubtitle"
                
                cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
                
                if cell == nil {
                    cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
                }
                
                if cell != nil {
                    cell.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
                    
//                  cell      .textLabel!.text = AppDelegate.getPortName()
                    cell      .textLabel!.text = AppDelegate.getModelName()
//                  cell.detailTextLabel!.text = AppDelegate.getModelName()
                    
                    if AppDelegate.getMacAddress() == "" {
                        cell.detailTextLabel!.text = AppDelegate.getPortName()
                    }
                    else {
                        cell.detailTextLabel!.text = "\(AppDelegate.getPortName()) (\(AppDelegate.getMacAddress()))"
                    }
                    
                    cell      .textLabel!.textColor = UIColor.blueColor()
                    cell.detailTextLabel!.textColor = UIColor.blueColor()
                    
                    cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                }
            }
        }
        else {
            let cellIdentifier: String = "UITableViewCellStyleValue1"
            
            cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
            
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
            }
            
            if cell != nil {
                switch SectionIndex(rawValue: indexPath.section)! {
                case SectionIndex.Printer,
                     SectionIndex.CashDrawer :
                    cell.backgroundColor = UIColor.whiteColor()
                    
                    cell      .textLabel!.text = "Sample"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                case SectionIndex.BarcodeReader :
                    cell.backgroundColor = UIColor.whiteColor()
                    
                    cell      .textLabel!.text = "StarIoExtManager Sample"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                case SectionIndex.Combination :
                    cell.backgroundColor = UIColor.whiteColor()
                    
                    cell      .textLabel!.text = "StarIoExtManager Sample"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                    cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
                case SectionIndex.Api :
                    cell.backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 1.0, alpha: 1.0)
                    
                    cell      .textLabel!.text = "Sample"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor.blueColor()
                    cell.detailTextLabel!.textColor = UIColor.blueColor()
//              case SectionIndex.AllReceipts :
                default                       :
                    cell.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.9, alpha: 1.0)
                    
                    cell      .textLabel!.text = "Sample"
                    cell.detailTextLabel!.text = ""
                    
                    cell      .textLabel!.textColor = UIColor.blueColor()
                    cell.detailTextLabel!.textColor = UIColor.blueColor()
                }
                
                var userInteractionEnabled: Bool = true
                
                if AppDelegate.getModelName() == "" {
                    userInteractionEnabled = false
                }
                
                let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
                
                if emulation == StarIoExtEmulation.StarLine    ||
                   emulation == StarIoExtEmulation.StarGraphic ||
                   emulation == StarIoExtEmulation.EscPos {
                    if indexPath.section == SectionIndex.BarcodeReader.rawValue ||
                       indexPath.section == SectionIndex.Combination  .rawValue {
                        userInteractionEnabled = false
                    }
                }
                
                if emulation == StarIoExtEmulation.EscPosMobile {
                    if indexPath.section == SectionIndex.CashDrawer   .rawValue ||
                       indexPath.section == SectionIndex.BarcodeReader.rawValue ||
                       indexPath.section == SectionIndex.Combination  .rawValue {
                        userInteractionEnabled = false
                    }
                }
                
                if emulation == StarIoExtEmulation.StarDotImpact {
                    if indexPath.section == SectionIndex.BarcodeReader.rawValue ||
                       indexPath.section == SectionIndex.Combination  .rawValue ||
                       indexPath.section == SectionIndex.AllReceipts  .rawValue {
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
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String!
        
        switch SectionIndex(rawValue: section)! {
        case SectionIndex.Device :
            title = "Destination Device"
        case SectionIndex.Printer :
            title = "Printer"
        case SectionIndex.CashDrawer :
            title = "Cash Drawer"
        case SectionIndex.BarcodeReader :
            title = "Barcode Reader (for mPOP)"
        case SectionIndex.Combination :
            title = "Combination (for mPOP)"
        case SectionIndex.Api :
            title = "API"
//      case SectionIndex.AllReceipts :
        default                       :
            title = "AllReceipts"
        }
        
        return title
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.selectedIndexPath = indexPath
        
        var alertView: UIAlertView
        
        switch SectionIndex(rawValue: self.selectedIndexPath.section)! {
        case SectionIndex.Device :
            self.performSegueWithIdentifier("PushSearchPortViewController", sender: nil)
        case SectionIndex.Printer :
            alertView = UIAlertView(title: "Select language.",
                                  message: "",
                                 delegate: self,
                        cancelButtonTitle: "Cancel",
                        otherButtonTitles: "English", "Japanese", "French", "Portuguese", "Spanish", "Russian", "Simplified Chinese", "Traditional Chinese")
            
            if AppDelegate.getEmulation() == StarIoExtEmulation.EscPos ||
               AppDelegate.getEmulation() == StarIoExtEmulation.StarDotImpact {
                alertView.tag = AlertViewIndex.LanguageFixedPaperSize.rawValue
            }
            else {
                alertView.tag = AlertViewIndex.Language.rawValue
            }
            
            alertView.show()
        case SectionIndex.CashDrawer :
            self.performSegueWithIdentifier("PushCashDrawerViewController", sender: nil)
        case SectionIndex.BarcodeReader,
             SectionIndex.Combination :
            alertView = UIAlertView(title: "This menu is for mPOP.",
                                  message: "",
                                 delegate: self,
                        cancelButtonTitle: "Cancel",
                        otherButtonTitles: "Continue")
            
            alertView.tag = AlertViewIndex.Confirm.rawValue
            
            alertView.show()
        case SectionIndex.Api :
            if AppDelegate.getEmulation() == StarIoExtEmulation.EscPos {
                AppDelegate.setSelectedPaperSize(PaperSizeIndex.EscPosThreeInch)
                
                self.performSegueWithIdentifier("PushApiViewController", sender: nil)
            }
            else if AppDelegate.getEmulation() == StarIoExtEmulation.StarDotImpact {
                AppDelegate.setSelectedPaperSize(PaperSizeIndex.DotImpactThreeInch)
                
                self.performSegueWithIdentifier("PushApiViewController", sender: nil)
            }
            else {
                alertView = UIAlertView(title: "Select paper size.",
                    message: "",
                    delegate: self,
                    cancelButtonTitle: "Cancel",
                    otherButtonTitles: "2\" (384dots)", "3\" (576dots)", "4\" (832dots)")
                
                alertView.tag = AlertViewIndex.PaperSize.rawValue
                
                alertView.show()
            }
//      case SectionIndex.AllReceipts :
        default                       :
            alertView = UIAlertView(title: "Select language.",
                                  message: "",
                                 delegate: self,
                        cancelButtonTitle: "Cancel",
//                      otherButtonTitles: "English", "Japanese", "French", "Portuguese", "Spanish", "Russian", "Simplified Chinese", "Traditional Chinese")
                        otherButtonTitles: "English", "Japanese", "French", "Portuguese", "Spanish")
            
            if AppDelegate.getEmulation() == StarIoExtEmulation.EscPos {
                alertView.tag = AlertViewIndex.LanguageFixedPaperSize.rawValue
            }
            else {
                alertView.tag = AlertViewIndex.Language.rawValue
            }
            
            alertView.show()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex != 0 {     // Not Cancel!!!
            var nestAlertView: UIAlertView
            
            switch AlertViewIndex(rawValue: alertView.tag)! {
            case AlertViewIndex.Language :
                AppDelegate.setSelectedLanguage(LanguageIndex(rawValue: buttonIndex - 1)!)     // Same!!!
                
                nestAlertView = UIAlertView(title: "Select paper size.",
                                          message: "",
                                         delegate: self,
                                cancelButtonTitle: "Cancel",
                                otherButtonTitles: "2\" (384dots)", "3\" (576dots)", "4\" (832dots)")
                
                nestAlertView.tag = AlertViewIndex.PaperSize.rawValue
                
                nestAlertView.show()
            case AlertViewIndex.LanguageFixedPaperSize :
                AppDelegate.setSelectedLanguage(LanguageIndex(rawValue: buttonIndex - 1)!)     // Same!!!
                
                switch SectionIndex(rawValue: self.selectedIndexPath.section)! {
                case SectionIndex.Printer :
                    if AppDelegate.getEmulation() == StarIoExtEmulation.EscPos {
                        AppDelegate.setSelectedPaperSize(PaperSizeIndex.EscPosThreeInch)
                    }
                    else {
                        AppDelegate.setSelectedPaperSize(PaperSizeIndex.DotImpactThreeInch)
                    }
                    
                    self.performSegueWithIdentifier("PushPrinterViewController",     sender: nil)
                case SectionIndex.Combination :
                    AppDelegate.setSelectedPaperSize(PaperSizeIndex.TwoInch)
                    
                    self.performSegueWithIdentifier("PushCombinationViewController", sender: nil)
//              case SectionIndex.AllReceipts :
                default                       :
                    AppDelegate.setSelectedPaperSize(PaperSizeIndex.EscPosThreeInch)
                    
                    self.performSegueWithIdentifier("PushAllReceiptsViewController", sender: nil)
              }
            case AlertViewIndex.PaperSize :
                switch (buttonIndex - 1) {
                case 0 :
                    AppDelegate.setSelectedPaperSize(PaperSizeIndex.TwoInch)
                case 1 :
                    AppDelegate.setSelectedPaperSize(PaperSizeIndex.ThreeInch)
//              case 2  :
                default :
                    AppDelegate.setSelectedPaperSize(PaperSizeIndex.FourInch)
                }
                
                switch SectionIndex(rawValue: self.selectedIndexPath.section)! {
                case SectionIndex.Printer :
                    self.performSegueWithIdentifier("PushPrinterViewController",     sender: nil)
                case SectionIndex.Api :
                    self.performSegueWithIdentifier("PushApiViewController",         sender: nil)
//              case SectionIndex.AllReceipts :
                default                       :
                    self.performSegueWithIdentifier("PushAllReceiptsViewController", sender: nil)
                }
            case AlertViewIndex.Confirm :
                switch SectionIndex(rawValue: self.selectedIndexPath.section)! {
                case SectionIndex.BarcodeReader :
                    self.performSegueWithIdentifier("PushBarcodeReaderExtViewController", sender: nil)
//              case SectionIndex.Combination :
                default                       :
                    nestAlertView = UIAlertView(title: "Select language.",
                                              message: "",
                                             delegate: self,
                                    cancelButtonTitle: "Cancel",
                                    otherButtonTitles: "English", "Japanese", "French", "Portuguese", "Spanish", "Russian", "Simplified Chinese", "Traditional Chinese")
                    
                    nestAlertView.tag = AlertViewIndex.LanguageFixedPaperSize.rawValue
                    
                    nestAlertView.show()
                }
            }
        }
    }
}
