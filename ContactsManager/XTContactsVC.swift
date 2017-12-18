//
//  XTContactsVC.swift
//  AddressBookManager
//
//  Created by xt on 2017/12/7.
//  Copyright © 2017年 xt. All rights reserved.
//

import UIKit
import Foundation
import Contacts
import ContactsUI
import WCDB

class XTContactsVC: XTBaseVC, UITableViewDelegate, UITableViewDataSource/*, CNContactPickerDelegate*/{
    var tableView = UITableView()
    var contacts: [CNContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        buildUI()
        judgeAuthorizationStatus()
    }
    func fetchContacts(){
        let contactStore : CNContactStore = CNContactStore()
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactMiddleNameKey, CNContactNicknameKey,
                    CNContactOrganizationNameKey, CNContactJobTitleKey,
                    CNContactDepartmentNameKey, CNContactNoteKey, CNContactPhoneNumbersKey,
                    CNContactEmailAddressesKey, CNContactPostalAddressesKey,
                    CNContactDatesKey, CNContactInstantMessageAddressesKey
        ]
        let fetchRequest : CNContactFetchRequest = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do{
            try contactStore.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) in
                self.contacts.append(contact)
            })
        }catch{
        }
        tableView .reloadData()
    }
    
    func judgeAuthorizationStatus() {
        let contactStore:CNContactStore = CNContactStore()
        if(CNContactStore.authorizationStatus(for: CNEntityType.contacts) == CNAuthorizationStatus.notDetermined){
            contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (granted, error) in
                if(error != nil) {return}
                if(granted){
                    print("授权访问通讯录")
                    self.fetchContacts()
                }else{
                    print("拒绝访问通讯录")
                }
            })
        }else if(CNContactStore.authorizationStatus(for: CNEntityType.contacts) == CNAuthorizationStatus.authorized){
            print("已授权访问")
            self .fetchContacts()
        }else{
            print("已拒绝访问")
        }
    }
    
    //MARK: tableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "XT_Contact_Cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "XT_Contact_Cell")
        }
        let contact = contacts[indexPath.row]
        cell?.textLabel?.text = contact.displyName()
        cell?.detailTextLabel?.text = contact.phone()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let userDefault:UserDefaults = UserDefaults.init(suiteName: "group.com.ronglian.yunDemo")!
        var blackList = [Dictionary<String, String>]()
        if(userDefault.object(forKey: "phone") != nil){
            blackList = userDefault.object(forKey: "phone") as! [Dictionary<String, String>]
        }
        let contact = contacts[indexPath.row]
        blackList.append([contact.phone():contact.displyName()])
        userDefault.set(blackList, forKey: "phone")
        userDefault.synchronize()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "加入黑名单"
    }
    
    //MARK: view创建
    func buildUI(){
        tableView = UITableView(frame: CGRect(x:0, y:0, width:XT_ScreenW, height: XT_ScreenH))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60;
        tableView.tableFooterView = UIView();
        self.view.addSubview(tableView)
    }
}

