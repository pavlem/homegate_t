//
//  UserDefaultsHelper.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 9.5.21..
//

import Foundation

class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    
    enum Keys: String, CaseIterable {
        case homes
        
        var string: String {
            return self.rawValue
        }
    }
    
    // MARK: - Properties
    var homes: Data? {
        get {
            return UserDefaults.standard.data(forKey: Keys.homes.string)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.homes.string)
            UserDefaults.standard.synchronize()
        }
    }
}
