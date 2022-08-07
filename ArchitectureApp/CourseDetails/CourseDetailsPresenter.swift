//
//  CourseDetailsPresenter.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/6/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  

import Foundation

struct CourseDetailsData {
    let courseName: String
    let numberOfLessons: Int
    let numberOfTests: Int
    let imageData: Data?
    let isFavorite: Bool
}

class CourseDetailsPresenter: CourseDetailsViewOutputProtocol {

    unowned let view: CourseDetailsViewInputProtocol
    var interactor: CourseDetailsInteractorInputProtocol!
    
    required init(view: CourseDetailsViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideCourseDetails()
    }
    
    func favoriteButtonPressed() {
        interactor.toggleFavoriteStatus()
    }
}

// MARK: - CourseDetailsInteractorOutputProtocol
extension CourseDetailsPresenter: CourseDetailsInteractorOutputProtocol {
    func receiveCourseDetails(with courseData: CourseDetailsData) {
        let numberOfLessons = "Number of lessons: \(courseData.numberOfLessons)"
        let numberOfTests = "Number of tests: \(courseData.numberOfTests)"
        
        view.displayCourseName(with: courseData.courseName)
        view.displayNumberOfLessons(with: numberOfLessons)
        view.displayNumberOfTests(with: numberOfTests)
        view.displayColorForFavoriteButton(with: courseData.isFavorite)
        
        guard let data = courseData.imageData else { return }
        view.displayCourseImage(with: data)
    }
    
    func receiveFavoriteStatus(with status: Bool) {
        view.displayColorForFavoriteButton(with: status)
    }
}
