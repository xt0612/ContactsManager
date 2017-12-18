//
//  XTMainVC.swift
//  ContactsManager
//
//  Created by xt on 2017/12/7.
//  Copyright © 2017年 xt. All rights reserved.
//

import UIKit
import CallKit
import WCDB

class XTMainVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let contact:XTContactsVC = XTContactsVC()
        contact.title = "联系人"
        let contactNC:UINavigationController = UINavigationController.init(rootViewController: contact)
        let blackList:XTBlacklistVC = XTBlacklistVC()
        blackList.title = "黑名单"
        let blackListNC:UINavigationController = UINavigationController.init(rootViewController: blackList)
        self.viewControllers = [contactNC, blackListNC]
        
        let callManager:CXCallDirectoryManager = CXCallDirectoryManager.sharedInstance;
        callManager.reloadExtension(withIdentifier: "com.ronglian.yunDemo.ex", completionHandler: nil);
    }
}
