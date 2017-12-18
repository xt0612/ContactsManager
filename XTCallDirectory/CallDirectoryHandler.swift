//
//  CallDirectoryHandler.swift
//  ext
//
//  Created by xt on 2017/12/7.
//  Copyright © 2017年 HH. All rights reserved.
//

import Foundation
import CallKit

class CallDirectoryHandler: CXCallDirectoryProvider {
    
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        guard let phoneNumbersToBlock = retrievePhoneNumbersToBlock() else {
            let error = NSError(domain: "CallDirectoryHandler", code: 1, userInfo: nil)
            context.cancelRequest(withError: error)
            return
        }
        
        for phoneNumber in phoneNumbersToBlock {
            context.addBlockingEntry(withNextSequentialPhoneNumber: CXCallDirectoryPhoneNumber(phoneNumber)!)
        }
        
        guard let (phoneNumbersToIdentify, phoneNumberIdentificationLabels) = retrievePhoneNumbersToIdentifyAndLabels() else {
            let error = NSError(domain: "CallDirectoryHandler", code: 2, userInfo: nil)
            context.cancelRequest(withError: error)
            return
        }
        
        for (phoneNumber, label) in zip(phoneNumbersToIdentify, phoneNumberIdentificationLabels) {
            context.addIdentificationEntry(withNextSequentialPhoneNumber: CXCallDirectoryPhoneNumber(phoneNumber)!, label: label)
        }
        
        context.completeRequest { (suc) in
            print(suc)
        }
    }
    
    private func retrievePhoneNumbersToBlock() -> [String]? {
//        let contacts = UserDefaults.init(suiteName: "group.com.ronglian.yunDemo")?.object(forKey: "phone") as! NSDictionary
//        let phones = contacts.allKeys
//        print(phones)
//        return phones as? Array<String>
        return ["+8617600189633"]
    }
    
    private func retrievePhoneNumbersToIdentifyAndLabels() -> (phoneNumbers: [String], labels: [String])? {
        return (["+8617600189633","+8645678901234"], ["abc","def"])
    }
    
}

