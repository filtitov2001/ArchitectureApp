//
//  DataManager.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/5/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func getFavoriteStatus(for courseName: String) -> Bool {
        UserDefaults.standard.bool(forKey: courseName)
    }
    
    func setFavoriteStatus(for courseName: String, with status: Bool) {
        UserDefaults.standard.set(status, forKey: courseName)
    }
}
