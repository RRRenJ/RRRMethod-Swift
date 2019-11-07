//
//  CustomBundle.swift
//  RRRExtensionDemo
//
//  Created by 任敬 on 2019/8/29.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit


let  AppLanguageDidChangeNotification = Notification.Name(rawValue: "com.rrren.languagedidchange")
private let  AppLanguageSwitchKey = "App_Language_Switch_Key"
private var  kBundleKey = "kBundleKey";

private class BundleEx: Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle = objc_getAssociatedObject(self, &kBundleKey) as! Bundle?
        
        if let _ = bundle {
            return bundle!.localizedString(forKey: key, value: value, table: tableName)
        }else{
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
    }
    
}


public extension Bundle {
 
    class func initBundle() {
        object_setClass(Bundle.main, BundleEx.self)
        let language = BundleEx.getCurrentLanguage()
        BundleEx.setLanguage(language: language)
    }
    
    
    class func setLanguage(language:String?) {
        
        var value : Bundle?
        if let _ = language{
            let path = Bundle.main.path(forResource: language!, ofType: "lproj")
            if let _ = path {
                value = Bundle.init(path: path!)
                if let _ = value{
                    UserDefaults.standard.set(language, forKey: AppLanguageSwitchKey)
                    UserDefaults.standard.synchronize()
                }
            }
        }else{
            UserDefaults.standard.removeObject(forKey: AppLanguageSwitchKey)
            UserDefaults.standard.synchronize()
        }
       objc_setAssociatedObject(Bundle.main, &kBundleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
       NotificationCenter.default.post(name: AppLanguageDidChangeNotification, object: nil);
        
        
    }
    
    class func getCurrentLanguage() -> String{
        let language = UserDefaults.standard.object(forKey: AppLanguageSwitchKey) as! String?
        if let _ = language {
            return language!
        }else{
            let appLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! Array<String>?
            if let _ = appLanguages{
               let languageName = appLanguages?.first
                if languageName?.contains("zh-Hans") ?? false {
                    return "zh-Hans"
                }else {
                    return "en"
                }
            }
            return "en"
        }
    }
    
    class func restoreSystemLanguage() {
        self.setLanguage(language: nil)
    }
    
   
    
}
