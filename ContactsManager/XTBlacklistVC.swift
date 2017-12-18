//
//  XTBlacklistVC.swift
//  ContactsManager
//
//  Created by xt on 2017/12/7.
//  Copyright © 2017年 xt. All rights reserved.
//

import UIKit
import Foundation
import Contacts

class XTBlacklistVC: XTBaseVC, UITableViewDelegate, UITableViewDataSource {
    var tableView = UITableView()
    var name: [String] = []
    var blackList = [Dictionary<String, String>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefault:UserDefaults = UserDefaults.init(suiteName: "group.com.ronglian.yunDemo")!
        if userDefault.object(forKey: "phone") != nil {
            blackList = userDefault.object(forKey: "phone") as! [Dictionary]
        }
        self.buildUI()
    }
    
    //MARK: tableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "XT_Contact_Cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "XT_Contact_Cell")
        }
        let contact = blackList[indexPath.row]
        let key = Array(contact.keys)[0]
        cell?.textLabel?.text = contact[key]
        cell?.detailTextLabel?.text = key
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath)
        let userDefault:UserDefaults = UserDefaults.init(suiteName: "group.com.ronglian.yunDemo")!
        blackList.remove(at: indexPath.row)
        userDefault.set(blackList, forKey: "phone")
        userDefault.synchronize()
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "移出黑名单"
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
