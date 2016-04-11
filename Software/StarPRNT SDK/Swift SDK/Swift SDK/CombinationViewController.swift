//
//  CombinationViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CombinationViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
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
        return 1
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
            let localizeReceipts: ILocalizeReceipts = LocalizeReceipts.createLocalizeReceipts(AppDelegate.getSelectedLanguage(), paperSizeIndex: PaperSizeIndex.TwoInch)
            
            switch indexPath.row {
            case 0 :
                cell.textLabel!.text = String(format: "%@ %@ Text Receipt",                localizeReceipts.languageCode, localizeReceipts.paperSize)
            case 1 :
                cell.textLabel!.text = String(format: "%@ %@ Text Receipt (UTF8)",         localizeReceipts.languageCode, localizeReceipts.paperSize)
            case 2 :
                cell.textLabel!.text = String(format: "%@ %@ Raster Receipt",              localizeReceipts.languageCode, localizeReceipts.paperSize)
            case 3 :
                cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Both Scale)", localizeReceipts.languageCode, localizeReceipts.paperSize)
            case 4 :
                cell.textLabel!.text = String(format: "%@ %@ Raster Receipt (Scale)",      localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
            case 5 :
                cell.textLabel!.text = String(format: "%@ Raster Coupon",                  localizeReceipts.languageCode, localizeReceipts.scalePaperSize)
//          case 6  :
            default :
                cell.textLabel!.text = String(format: "%@ Raster Coupon (Rotation90)",     localizeReceipts.languageCode)
            }
            
            cell.detailTextLabel!.text = ""
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "StarIoExtManager Sample"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        AppDelegate.setSelectedIndex(indexPath.row)
        
        self.performSegueWithIdentifier("PushCombinationExtViewController", sender: nil)
    }
}
