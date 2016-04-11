//
//  ApiViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import UIKit

class ApiViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
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
        return 22
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UITableViewCellStyleValue1"
        
        var cell: UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
        }
        
        if cell != nil {
            switch indexPath.row {
            case 0  :
                cell.textLabel!.text = "Generic"
            case 1  :
                cell.textLabel!.text = "Font Style"
            case 2  :
                cell.textLabel!.text = "Initialization"
            case 3  :
                cell.textLabel!.text = "Code Page"
            case 4  :
                cell.textLabel!.text = "International"
            case 5  :
                cell.textLabel!.text = "Feed"
            case 6  :
                cell.textLabel!.text = "Character Space"
            case 7  :
                cell.textLabel!.text = "Line Space"
            case 8  :
                cell.textLabel!.text = "Emphasis"
            case 9  :
                cell.textLabel!.text = "Invert"
            case 10 :
                cell.textLabel!.text = "Under Line"
            case 11 :
                cell.textLabel!.text = "Multiple"
            case 12 :
                cell.textLabel!.text = "Absolute Position"
            case 13 :
                cell.textLabel!.text = "Alignment"
            case 14 :
                cell.textLabel!.text = "Logo"
            case 15 :
                cell.textLabel!.text = "Cut Paper"
            case 16 :
                cell.textLabel!.text = "Peripheral"
            case 17 :
                cell.textLabel!.text = "Sound"
            case 18 :
                cell.textLabel!.text = "Bitmap"
            case 19 :
                cell.textLabel!.text = "Barcode"
            case 20 :
                cell.textLabel!.text = "PDF417"
//          case 21 :
            default :
                cell.textLabel!.text = "QR Code"
            }
            
            cell.detailTextLabel!.text = ""
            
            cell      .textLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            cell.detailTextLabel!.textColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sample"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var commands: NSData
        
        let emulation: StarIoExtEmulation = AppDelegate.getEmulation()
        
        let width: Int = AppDelegate.getSelectedPaperSize().rawValue
        
        switch indexPath.row {
        case 0  :
            commands = ApiFunctions.createGenericData(emulation)
        case 1  :
            commands = ApiFunctions.createFontStyleData(emulation)
        case 2  :
            commands = ApiFunctions.createInitializationData(emulation)
        case 3  :
            commands = ApiFunctions.createCodePageData(emulation)
        case 4  :
            commands = ApiFunctions.createInternationalData(emulation)
        case 5  :
            commands = ApiFunctions.createFeedData(emulation)
        case 6  :
            commands = ApiFunctions.createCharacterSpaceData(emulation)
        case 7  :
            commands = ApiFunctions.createLineSpaceData(emulation)
        case 8  :
            commands = ApiFunctions.createEmphasisData(emulation)
        case 9  :
            commands = ApiFunctions.createInvertData(emulation)
        case 10 :
            commands = ApiFunctions.createUnderLineData(emulation)
        case 11 :
            commands = ApiFunctions.createMultipleData(emulation)
        case 12 :
            commands = ApiFunctions.createAbsolutePositionData(emulation)
        case 13 :
            commands = ApiFunctions.createAlignmentData(emulation)
        case 14 :
            commands = ApiFunctions.createLogoData(emulation)
        case 15 :
            commands = ApiFunctions.createCutPaperData(emulation)
        case 16 :
            commands = ApiFunctions.createPeripheralData(emulation)
        case 17 :
            commands = ApiFunctions.createSoundData(emulation)
        case 18 :
            commands = ApiFunctions.createBitmapData(emulation, width: width)
        case 19 :
            commands = ApiFunctions.createBarcodeData(emulation)
        case 20 :
            commands = ApiFunctions.createPdf417Data(emulation)
//      case 21 :
        default :
            commands = ApiFunctions.createQrCodeData(emulation)
        }
        
        self.blind = true
        
        Communication.sendCommands(commands, portName: AppDelegate.getPortName(), portSettings: AppDelegate.getPortSettings(), timeout: 10000)     // 10000mS!!!
        
        self.blind = false
    }
}
