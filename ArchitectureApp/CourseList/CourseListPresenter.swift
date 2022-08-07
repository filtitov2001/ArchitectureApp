//
//  CourseListPresenter.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/6/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  

import Foundation

struct CourseListDataStore {
    let courses: [Course]
}

class CourseListPresenter: CourseListViewOutputProtocol {
    
    unowned let view: CourseListViewInputProtocol
    var interactor: CourseListInteractorInputProtocol!
    var router: CourseListRouterInputProtocol!
    
    private var dataStore: CourseListDataStore?
    
    required init(view: CourseListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchCourses()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let course = dataStore?.courses[indexPath.row] else { return }
        router.openCourseDetailsViewController(with: course)
    }
}

extension CourseListPresenter: CourseListInteractorOutputProtocol {
    func coursesDidReceive(with dataStore: CourseListDataStore) {
        self.dataStore = dataStore
        let section = CourseSectionViewModel()
        
        /*
        dataStore.courses.forEach { course in
            let courseCellViewModel = CourseCellViewModel(course: course)
            section.rows.append(courseCellViewModel)
        }
        */
        
        dataStore.courses.forEach { section.rows.append(CourseCellViewModel(course: $0)) }
        
        view.reloadData(for: section)
        
    }
}
