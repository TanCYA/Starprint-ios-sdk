//
//  CashDrawerViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CashDrawerViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
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
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            switch indexPath.row {
            case 0 :
                cell.textLabel!.text = "Channel1 (Check condition.)"
            case 1 :
                cell.textLabel!.text = "Channel1 (Do not check condition.)"
            case 2 :
                cell.textLabel!.text = "Channel2 (Check condition.)"
//          case 3  :
            default :
                cell.textLabel!.text = "Channel2 (Do not check condition.)"
            }
            
            cell.detailTextLabel!.text = ""
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
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
            let commands: NSData
            
            switch indexPath.row {
            case 0, 1 :
                commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.No1)
//          case 2, 3 :
            default   :
                commands = CashDrawerFunctions.createData(AppDelegate.getEmulation(), channel: SCBPeripheralChannel.No2)
            }
            
            self.blind = true
            
            let portName:     String = AppDelegate.getPortName()
            let portSettings: String = AppDelegate.getPortSettings()
            let timeout:      UInt32 = 10000                             // 10000mS!!!
            
            switch indexPath.row {
            case 0, 2 :
                Communication.sendCommands                   (commands, portName: portName, portSettings: portSettings, timeout: timeout)
//          case 1, 3 :
            default   :
                Communication.sendCommandsDoNotCheckCondition(commands, portName: portName, portSettings: portSettings, timeout: timeout)
            }
            
            self.blind = false
        }
        else {
            AppDelegate.setSelectedIndex(indexPath.row)
            
            self.performSegueWithIdentifier("PushCashDrawerExtViewController", sender: nil)
        }
    }
}
