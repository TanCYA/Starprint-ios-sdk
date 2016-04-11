//
//  CommonViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    @IBOutlet weak var blindView: UIView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var blind: Bool {
        get {
            return self.navigationItem.hidesBackButton
        }
        
        set(blind) {
            if blind == true {
                self.navigationItem.hidesBackButton = true
                
                self.navigationItem.rightBarButtonItem?.enabled = false
                
                self.blindView            .hidden = false
                self.activityIndicatorView.hidden = false
                
                self.activityIndicatorView.startAnimating()
                
                NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.1))     // Update View
            }
            else {
                self.activityIndicatorView.stopAnimating()
                
                self.blindView            .hidden = true
                self.activityIndicatorView.hidden = true
                
                self.navigationItem.rightBarButtonItem?.enabled = true
                
                self.navigationItem.hidesBackButton = false
                
//              NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.1))     // Update View(No need)
            }
        }
    }
    
    func appendRefreshButton(action: Selector) {
        let item: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: action)
        
        self.navigationItem.rightBarButtonItem = item
    }
}
