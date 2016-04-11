//
//  SwitchTableViewCell.swift
//  Swift SDK
//
//  Created by Yuji on 2016/03/19.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate {
    func tableView(tableView: UITableView, valueChangedStateSwitch on: Bool, indexPath: NSIndexPath)
}

class SwitchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var stateSwitch: UISwitch!
    
    var delegate: SwitchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//  @IBAction func valueChangedStateSwitch(var sender: UIView) {
    @IBAction func valueChangedStateSwitch    (sender: UIView) {
        var sender = sender
        
        while sender.isKindOfClass(UITableView) == false {
            sender = sender.superview!
        }
        
        let indexPath: NSIndexPath = (sender as! UITableView).indexPathForCell(self)!
        
        self.delegate?.tableView(sender as! UITableView, valueChangedStateSwitch: self.stateSwitch.on, indexPath: indexPath)
    }
}
