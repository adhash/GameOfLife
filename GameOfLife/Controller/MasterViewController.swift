//
//  MasterViewController.swift
//  GameOfLife
//
//  Created by wojtek on 24/07/2020.
//  Copyright © 2020 wojtek. All rights reserved.
//

import UIKit

class MasterViewController : UIViewController {
    @IBOutlet weak var noOfIterations: UITextField!
    var svc: UISplitViewController?
    
    override func viewDidLoad() {
        
    }
    @IBAction func update_click(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(Application.numberOfIterations.rawValue),
                                        object: self.noOfIterations.text)
    }
}
