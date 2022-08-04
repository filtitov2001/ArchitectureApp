//
//  NetworkManager.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/4/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let api = "https://swiftbook.ru/wp-content/uploads/api/api_courses"
    
    private init() {}
    
    func fetchData(completion: @escaping(_ courses: [Course]) -> Void) {
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
