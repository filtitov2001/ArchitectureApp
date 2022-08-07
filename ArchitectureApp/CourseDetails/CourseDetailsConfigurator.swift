//
//  CourseDetailsConfigurator.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/6/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

protocol CourseDetailsConfiguratorInputProtocol {
    func configure(with view: CourseDetailViewController, and course: Course)
}

class CourseDetailsConfigurator: CourseDetailsConfiguratorInputProtocol {
    func configure(with view: CourseDetailViewController, and course: Course) {
        let presenter = CourseDetailsPresenter(view: view)
        let interactor = CourseDetailsInteractor(presenter: presenter, course: course)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
