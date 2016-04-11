//
//  SearchPortViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class SearchPortViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    enum CellParamIndex: Int {
        case PortName = 0
        case ModelName
        case MacAddress
    }
    
    enum AlertViewIndex: Int {
        case RefreshPort = 0
        case Confirm0
        case Confirm1
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellArray: NSMutableArray!
    
    var selectedIndexPath: NSIndexPath!
    
    var didAppear: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//      self.appendRefreshButton                                  ("refreshPortInfo")
        self.appendRefreshButton(#selector(SearchPortViewController.refreshPortInfo))
        
        self.cellArray = NSMutableArray()
        
        self.selectedIndexPath = nil
        
        self.didAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if didAppear == false {
            self.refreshPortInfo()
            
            self.didAppear = true
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleSubtitle"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            let cellParam: [String] = self.cellArray[indexPath.row] as! [String]
            
//          cell      .textLabel!.text = cellParam[CellParamIndex.PortName.rawValue]
            cell      .textLabel!.text = cellParam[CellParamIndex.ModelName.rawValue]
//          cell.detailTextLabel!.text = cellParam[CellParamIndex.ModelName.rawValue]
            
            if cellParam[CellParamIndex.MacAddress.rawValue] == "" {
                cell.detailTextLabel!.text = cellParam[CellParamIndex.PortName.rawValue]
            }
            else {
                cell.detailTextLabel!.text = "\(cellParam[CellParamIndex.PortName.rawValue]) (\(cellParam[CellParamIndex.MacAddress.rawValue]))"
            }
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            if self.selectedIndexPath != nil {
                if indexPath.compare(self.selectedIndexPath) == NSComparisonResult.OrderedSame {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//      self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var cell: UITableViewCell!
        
        if self.selectedIndexPath != nil {
            cell = tableView.cellForRowAtIndexPath(self.selectedIndexPath)
            
            if cell != nil {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
        cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        self.selectedIndexPath = indexPath
        
        let cellParam: [String] = self.cellArray[self.selectedIndexPath.row] as! [String]
        
//      let portName:   String = cellParam[CellParamIndex.PortName  .rawValue]
        let modelName:  String = cellParam[CellParamIndex.ModelName .rawValue]
//      let macAddress: String = cellParam[CellParamIndex.MacAddress.rawValue]
        
        if false {     // Ex1. Direct Setting.
//          let portSettings: String = ""
//          let portSettings: String = "mini"
//          let portSettings: String = "escpos"
//          let portSettings: String = "Portable"
//
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.StarPRNT
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.StarLine
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.StarGraphic
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.EscPos
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.EscPosMobile
//          let emulation: StarIoExtEmulation = StarIoExtEmulation.StarDotImpact
//
//          AppDelegate.setPortName    (portName)
//          AppDelegate.setModelName   (modelName)
//          AppDelegate.setMacAddress  (macAddress)
//          AppDelegate.setPortSettings(portSettings)
//          AppDelegate.setEmulation   (emulation)
//
//          self.navigationController!.popViewControllerAnimated(true)
        }
        else if false {     // Ex2. Direct Setting.
//          let modelIndex: ModelIndex = ModelIndex.MPOP
//          let modelIndex: ModelIndex = ModelIndex.FVP10
//          let modelIndex: ModelIndex = ModelIndex.TSP100
//          let modelIndex: ModelIndex = ModelIndex.TSP650II
//          let modelIndex: ModelIndex = ModelIndex.TSP700II
//          let modelIndex: ModelIndex = ModelIndex.TSP800II
//          let modelIndex: ModelIndex = ModelIndex.SM_S210I
//          let modelIndex: ModelIndex = ModelIndex.SM_S220I
//          let modelIndex: ModelIndex = ModelIndex.SM_S230I
//          let modelIndex: ModelIndex = ModelIndex.SM_T300I
//          let modelIndex: ModelIndex = ModelIndex.SM_T400I
//          let modelIndex: ModelIndex = ModelIndex.BSC10
//          let modelIndex: ModelIndex = ModelIndex.SM_S210I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_S220I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_S230I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_T300I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_T400I_StarPRNT
//          let modelIndex: ModelIndex = ModelIndex.SM_L200
//          let modelIndex: ModelIndex = ModelIndex.SP700
//
//          let portSettings: String             = ModelCapability.portSettingsAtModelIndex(modelIndex)
//          let emulation:    StarIoExtEmulation = ModelCapability.emulationAtModelIndex   (modelIndex)
//
//          AppDelegate.setPortName    (portName)
//          AppDelegate.setModelName   (modelName)
//          AppDelegate.setMacAddress  (macAddress)
//          AppDelegate.setPortSettings(portSettings)
//          AppDelegate.setEmulation   (emulation)
//
//          self.navigationController!.popViewControllerAnimated(true)
        }
        else if false {     // Ex3. Indirect Setting.
//          let modelIndex: ModelIndex = ModelCapability.modelIndexAtModelName(modelName)
//
//          let portSettings: String             = ModelCapability.portSettingsAtModelIndex(modelIndex)
//          let emulation:    StarIoExtEmulation = ModelCapability.emulationAtModelIndex   (modelIndex)
//
//          AppDelegate.setPortName    (portName)
//          AppDelegate.setModelName   (modelName)
//          AppDelegate.setMacAddress  (macAddress)
//          AppDelegate.setPortSettings(portSettings)
//          AppDelegate.setEmulation   (emulation)
//
//          self.navigationController!.popViewControllerAnimated(true)
        }
        else {     // Ex4. Indirect Setting.
            let modelIndex: ModelIndex = ModelCapability.modelIndexAtModelName(modelName)
            
            if modelIndex != ModelIndex.None {
                let message: String = String(format: "Is your printer %@?", ModelCapability.titleAtModelIndex(modelIndex))
                
                let alertView: UIAlertView = UIAlertView.init(title: "Confirm.", message: message, delegate: self, cancelButtonTitle: "NO", otherButtonTitles: "YES")
                
                alertView.tag = AlertViewIndex.Confirm0.rawValue
                
                alertView.show()
            }
            else {
                let alertView: UIAlertView = UIAlertView.init(title: "Confirm.", message: "What is your printer?", delegate: self, cancelButtonTitle: "Cancel")
                
//              for var i: Int = 0; i < ModelCapability.modelIndexCount(); i += 1 {
                for     i: Int in 0 ..< ModelCapability.modelIndexCount()         {
                    alertView.addButtonWithTitle(ModelCapability.titleAtModelIndex(ModelCapability.modelIndexAtIndex(i)))
                }
                
                alertView.tag = AlertViewIndex.Confirm1.rawValue
                
                alertView.show()
            }
        }
    }
    
    func refreshPortInfo() {
        let alertView: UIAlertView = UIAlertView.init(title: "Select Interface.", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "LAN", "Bluetooth", "Bluetooth Low Energy", "All")
        
        alertView.tag = AlertViewIndex.RefreshPort.rawValue
        
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == AlertViewIndex.Confirm0.rawValue {
            if buttonIndex == 1 {     // YES!!!
                let cellParam: [String] = self.cellArray[self.selectedIndexPath.row] as! [String]
                
                let portName:   String = cellParam[CellParamIndex.PortName  .rawValue]
                let modelName:  String = cellParam[CellParamIndex.ModelName .rawValue]
                let macAddress: String = cellParam[CellParamIndex.MacAddress.rawValue]
                
                let modelIndex: ModelIndex = ModelCapability.modelIndexAtModelName(modelName)
                
                let portSettings: String             = ModelCapability.portSettingsAtModelIndex(modelIndex)
                let emulation:    StarIoExtEmulation = ModelCapability.emulationAtModelIndex   (modelIndex)
                
                AppDelegate.setPortName    (portName)
                AppDelegate.setModelName   (modelName)
                AppDelegate.setMacAddress  (macAddress)
                AppDelegate.setPortSettings(portSettings)
                AppDelegate.setEmulation   (emulation)
                
                alertView.delegate = nil
                
                self.navigationController!.popViewControllerAnimated(true)
            }
            else {     // NO!!!
                let alertView: UIAlertView = UIAlertView.init(title: "Confirm.", message: "What is your printer?", delegate: self, cancelButtonTitle: "Cancel")
                
//              for var i: Int = 0; i < ModelCapability.modelIndexCount(); i += 1 {
                for     i: Int in 0 ..< ModelCapability.modelIndexCount()         {
                    alertView.addButtonWithTitle(ModelCapability.titleAtModelIndex(ModelCapability.modelIndexAtIndex(i)))
                }
                
                alertView.tag = AlertViewIndex.Confirm1.rawValue
                
                alertView.show()
            }
        }
        else if alertView.tag == AlertViewIndex.Confirm1.rawValue {
            if buttonIndex != 0 {     // Not Cancel!!!
                let cellParam: [String] = self.cellArray[self.selectedIndexPath.row] as! [String]
                
                let portName:   String = cellParam[CellParamIndex.PortName  .rawValue]
                let modelName:  String = cellParam[CellParamIndex.ModelName .rawValue]
                let macAddress: String = cellParam[CellParamIndex.MacAddress.rawValue]
                
                let modelIndex: ModelIndex = ModelCapability.modelIndexAtIndex(buttonIndex - 1)
                
                let portSettings: String             = ModelCapability.portSettingsAtModelIndex(modelIndex)
                let emulation:    StarIoExtEmulation = ModelCapability.emulationAtModelIndex   (modelIndex)
                
                AppDelegate.setPortName    (portName)
                AppDelegate.setModelName   (modelName)
                AppDelegate.setMacAddress  (macAddress)
                AppDelegate.setPortSettings(portSettings)
                AppDelegate.setEmulation   (emulation)
                
                alertView.delegate = nil
                
                self.navigationController!.popViewControllerAnimated(true)
            }
        }
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if alertView.tag == AlertViewIndex.RefreshPort.rawValue {
            if buttonIndex == 0 {     // Cancel
                alertView.delegate = nil
                
                self.navigationController!.popViewControllerAnimated(true)
            }
            else {
                self.blind = true
                
                self.cellArray.removeAllObjects()
                
                self.selectedIndexPath = nil
                
                var portInfoArray: [PortInfo]
                
                switch buttonIndex {
                case 1  :     // LAN
                    portInfoArray = SMPort.searchPrinter("TCP:") as! [PortInfo]
                case 2  :     // Bluetooth
                    portInfoArray = SMPort.searchPrinter("BT:")  as! [PortInfo]
                case 3  :     // Bluetooth Low Energy
                    portInfoArray = SMPort.searchPrinter("BLE:") as! [PortInfo]
//              case 4  :     // All
                default :
                    portInfoArray = SMPort.searchPrinter()       as! [PortInfo]
                }
                
                let portName:   String = AppDelegate.getPortName()
                let modelName:  String = AppDelegate.getModelName()
                let macAddress: String = AppDelegate.getMacAddress()
                
                var row: Int = 0
                
                for portInfo: PortInfo in portInfoArray {
                    self.cellArray.addObject([portInfo.portName, portInfo.modelName, portInfo.macAddress])
                    
                    if portInfo.portName   == portName  &&
                       portInfo.modelName  == modelName &&
                       portInfo.macAddress == macAddress {
                        self.selectedIndexPath = NSIndexPath(forRow: row, inSection: 0)
                    }
                    
                    row += 1
                }
                
                self.tableView.reloadData()
                
                self.blind = false
            }
        }
    }
}
