//
//  File.swift
//  POS
//
//  Created by Djubo on 29/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation

class UserDefaultsHelper{
    
    internal static func saveStringPreferences(key:String, value:String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey:key)
        userDefaults.synchronize()
    }
    
    internal static func saveBooleanPreferences(key:String, value:Bool){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey:key)
        userDefaults.synchronize()
    }
    
    internal static func saveIntPreferences(key:String, value:Int){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey:key)
        userDefaults.synchronize()
    }
    
    internal static func saveDoublePreferences(key:String, value:Double){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey:key)
        userDefaults.synchronize()
    }
    
    
    static func readPreferencesString(key : String) -> String{
        
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: key)!
        
    }
    
    static func readPreferencesBoolean(key : String) -> Bool{
        
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: key)
        
    }
    
    static func readPreferencesInt(key : String) -> Int{
        
        let userDefaults = UserDefaults.standard
        return userDefaults.integer(forKey: key)
        
    }
    
    
}
