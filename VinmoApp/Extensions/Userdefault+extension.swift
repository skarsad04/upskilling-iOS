//
//  Userdefault+extension.swift
//  VinmoApp
//
//  Created by asif hussain on 3/19/23.
//

import Foundation
extension UserDefaults {
    
    func isUserLogin() -> Bool {
        return bool(forKey: UserDefaultKeys.kIsLoggedIn)
    }
        
    func getAccessToken() -> String {
        return String.getString(string(forKey: UserDefaultKeys.accessToken))
    }
    func getRefereshToken() -> String {
        return String.getString(string(forKey: UserDefaultKeys.refereshToken))
    }
   
}
