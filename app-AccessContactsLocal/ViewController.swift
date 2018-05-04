//
//  ViewController.swift
//  app-AccessContactsLocal
//
//  Created by Walter Junior on 04/05/2018.
//  Copyright © 2018 Walter Junior. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {
    
    // MARK: - outlet / variable
    @IBOutlet weak var tableView: UITableView!
    var contactStore = CNContactStore()
    var contacts = [ContactStruct]()
    
    
    // MARK: - view manipulation
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestContactsStore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - functions
    private func requestContactsStore() {
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Authorization Successfull...")
            }
        }
        
        fetchContacts()
    }
    
    func fetchContacts() {
        
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: key)
        
         try! contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
            let name = contact.givenName
            let familyName = contact.familyName
            let number = contact.phoneNumbers.first?.value.stringValue
            
            let contactToAppend = ContactStruct(givenName: name, familyName: familyName, number: number!)
            
            self.contacts.append(contactToAppend)
        }
        
        tableView.reloadData()
        
    }

}

