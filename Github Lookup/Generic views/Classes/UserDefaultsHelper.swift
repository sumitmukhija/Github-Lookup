//
//  UserDefaultsHelper.swift
//  Github Lookup
//
//  Created by Sumit on 11/21/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    
    static let userDefaults = UserDefaults.standard
    
    class func addSearchCount(){
        let num = getSearchCount() + 1
        userDefaults.set(num, forKey: IDENTIFIERS.DEF_SEARCH_COUNT)
    }
    
    class func addSavedCount(){
        let num = getSavedCount() + 1
        userDefaults.set(num, forKey: IDENTIFIERS.DEF_SAVE_COUNT)
    }
    
    class func addViewedCount(){
        let num = getViewedCount() + 1
        userDefaults.set(num, forKey: IDENTIFIERS.DEF_VIEW_COUNT)
    }
    
    class func getSearchCount() -> Int
    {
        return userDefaults.integer(forKey: IDENTIFIERS.DEF_SEARCH_COUNT)
    }
    
    class func getSavedCount() -> Int
    {
        return userDefaults.integer(forKey: IDENTIFIERS.DEF_SAVE_COUNT)
    }
    
    class func getViewedCount() -> Int
    {
        return userDefaults.integer(forKey: IDENTIFIERS.DEF_VIEW_COUNT)
    }
}
