//
//  AppDelegate.swift
//  AddressBookManager
//
//  Created by xt on 2017/12/7.
//  Copyright © 2017年 xt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        configTheme()
        window?.rootViewController = XTMainVC()
        window?.makeKeyAndVisible()
        return true
    }
    
    func configTheme() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black]
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.white
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool{
        print(options)
        let source: String = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String
        if(source.isEqual("com.apple.mobilesafari")){
            let alertController = UIAlertController(title: "系统提示", message: "您确定要进入吗？", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {action in
                print("点击了确定")
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }
}

