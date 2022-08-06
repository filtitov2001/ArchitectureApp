//
//  CourseDetailsViewModel.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/5/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

protocol CourseDetailsViewModelProtocol {
    var courseName: String { get }
    var numberOfLessons: String { get }
    var numberOfTests: String  { get }
    var imageData: Data? { get }
    
    var isFavorite: Box<Bool> { get }
    
    init(course: Course)
    
    func favoriteButtonPressed()
}

class CourseDetailsViewModel: CourseDetailsViewModelProtocol {
    
    var courseName: String {
        course.name
    }
    
    var numberOfLessons: String {
        "Number of lessons: \(course.numberOfLessons)"
    }
    
    var numberOfTests: String {
        "Number of lessons: \(course.numberOfTests)"
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: course.imageUrl)
    }
    
    var isFavorite: Box<Bool>
    
    
    private let course: Course
    
    required init(course: Course) {
        isFavorite = Box(DataManager.shared.getFavoriteStatus(for: course.name))
        self.course = course
    }
    
    func favoriteButtonPressed() {
        isFavorite.value.toggle()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite.value)
    }
    
}
