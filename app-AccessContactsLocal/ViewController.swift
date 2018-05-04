//
//  ViewController.swift
//  app-AccessContactsLocal
//
//  Created by Walter Junior on 04/05/2018.
//  Copyright © 2018 Walter Junior. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - outlet / variable
    @IBOutlet weak var tableView: UITableView!
    
    var contactStore = CNContactStore()
    var contacts = [ContactStruct]()
    
    
    // MARK: - view manipulation
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
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
            guard let number = contact.phoneNumbers.first?.value.stringValue else { return }
            
            let contactToAppend = ContactStruct(givenName: name, familyName: familyName, number: number)
            
            self.contacts.append(contactToAppend)
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: table manipulation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contactToDisplay = contacts[indexPath.row]
        
        let cellReuse = "cellReuse"
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuse, for: indexPath) as! ContactCell
        
        cell.lblName.text = contactToDisplay.givenName + " " + contactToDisplay.familyName!
        cell.lblNumber.text = contactToDisplay.number
        
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        //cell.textLabel?.text = contactToDisplay.givenName + " " + contactToDisplay.familyName!
        //cell.detailTextLabel?.text = contactToDisplay.number
        
        return cell
    }
    
    // MARK: next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailContactSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contactSelect = self.contacts[indexPath.row]
                
                let viewControllerDestino = segue.destination as! DetailContactViewController
                viewControllerDestino.contact = contactSelect
            }
        }
    }
}

