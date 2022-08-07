//
//  CourseListRouter.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/6/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

protocol CourseListRouterInputProtocol {
    init(viewController: CourseListViewController)
    func openCourseDetailsViewController(with course: Course)
}

class CourseListRouter: CourseListRouterInputProtocol {
    unowned let viewController: CourseListViewController
    
    required init(viewController: CourseListViewController) {
        self.viewController = viewController
    }
    
    func openCourseDetailsViewController(with course: Course) {
        viewController.performSegue(withIdentifier: "ShowDetails", sender: course)
    }
}
