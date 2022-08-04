//
//  Course.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/4/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

struct Course: Decodable {
    let name: String
    let imageUrl: URL
    let numberOfLessons: Int
    let numberOfTests: Int
}
