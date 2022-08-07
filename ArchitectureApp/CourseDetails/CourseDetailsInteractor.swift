//
//  CourseDetailsInteractor.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/6/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

protocol CourseDetailsInteractorInputProtocol {
    var isFavorite: Bool { get }
    init(presenter: CourseDetailsInteractorOutputProtocol, course: Course)
    func provideCourseDetails()
    func toggleFavoriteStatus()
}

protocol CourseDetailsInteractorOutputProtocol: AnyObject {
    func receiveCourseDetails(with courseData: CourseDetailsData)
    func receiveFavoriteStatus(with status: Bool)
}

class CourseDetailsInteractor: CourseDetailsInteractorInputProtocol {
    
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: course.name)
        }
        
        set {
            DataManager.shared.setFavoriteStatus(for: course.name, with: newValue)
        }
    }
    
    unowned let presenter: CourseDetailsInteractorOutputProtocol
    
    private let course: Course
    
    required init(presenter: CourseDetailsInteractorOutputProtocol, course: Course) {
        self.presenter = presenter
        self.course = course
    }
    
    func provideCourseDetails() {
        let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl)
        
        let courseDatailsData = CourseDetailsData(
            courseName: course.name,
            numberOfLessons: course.numberOfLessons,
            numberOfTests: course.numberOfTests,
            imageData: imageData,
            isFavorite: isFavorite
        )
        presenter.receiveCourseDetails(with: courseDatailsData)
    }
    
    func toggleFavoriteStatus() {
        isFavorite.toggle()
        presenter.receiveFavoriteStatus(with: isFavorite)
    }
}
