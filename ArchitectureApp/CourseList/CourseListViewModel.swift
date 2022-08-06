//
//  CourseListViewModel.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/5/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

protocol CourseListViewModelProtocol {
    var numberOfRows: Int { get }
    func fetchCourses(completion: @escaping() -> Void)
    func cellViewModel(at indexPath: IndexPath) -> CourseCellViewModelProtocol
    func detailsViewModel(at indexPath: IndexPath) -> CourseDetailsViewModelProtocol
}

class CourseListViewModel: CourseListViewModelProtocol {
        
    private var courses: [Course] = []
    
    var numberOfRows: Int {
        courses.count
    }
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [unowned self] courses in
            self.courses = courses
            completion()
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CourseCellViewModelProtocol {
        let course = courses[indexPath.row]
        return CourseCellViewModel(course: course)
    }
    
    func detailsViewModel(at indexPath: IndexPath) -> CourseDetailsViewModelProtocol {
        let course = courses[indexPath.row]
        return CourseDetailsViewModel(course: course)
    }
    
}
