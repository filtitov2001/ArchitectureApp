//
//  CourseListInteractor.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/6/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

protocol CourseListInteractorInputProtocol {
    func fetchCourses()
    init(presenter: CourseListInteractorOutputProtocol)
}

protocol CourseListInteractorOutputProtocol: AnyObject {
    func coursesDidReceive(with dataStore: CourseListDataStore)
}

class CourseListInteractor: CourseListInteractorInputProtocol {
    unowned let presenter: CourseListInteractorOutputProtocol
    
    required init(presenter: CourseListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchCourses() {
        NetworkManager.shared.fetchData { [unowned self] courses in
            let dataStore = CourseListDataStore(courses: courses)
            self.presenter.coursesDidReceive(with: dataStore)
        }
    }
    
}
