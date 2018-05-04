//
//  DetailContactViewController.swift
//  app-AccessContactsLocal
//
//  Created by Walter Junior on 04/05/2018.
//  Copyright © 2018 Walter Junior. All rights reserved.
//

import Foundation
import UIKit

class DetailContactViewController: UIViewController {
    
    // MARK: - outlet / variable
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    var contact: ContactStruct!
    
    
    // MARK: - view manipulation
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingInterface()
    }
    
    // MARK: - loading
    private func loadingInterface() {
        lblName.text = contact.givenName + " " + contact.familyName!
        lblNumber.text = contact.number
    }
}
