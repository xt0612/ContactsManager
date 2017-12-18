//
//  File.swift
//  ContactsManager
//
//  Created by xt on 2017/12/7.
//  Copyright © 2017年 xt. All rights reserved.
//

import Contacts

extension CNContact {
    func displyName() -> String {
        return familyName + middleName + givenName
    }
    
    func phone() -> String {
        if phoneNumbers.count <= 0{
            return "无手机号"
        }
        return "+86" + phoneNumbers[0].value.stringValue.replacingOccurrences(of: "-", with: "")
    }
}

