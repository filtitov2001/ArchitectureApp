//
//  CourseDetailViewController.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/4/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

protocol CourseDetailsViewInputProtocol: AnyObject {
    func displayCourseName(with title: String)
    func displayNumberOfLessons(with title: String)
    func displayNumberOfTests(with title: String)
    func displayCourseImage(with data: Data)
    func displayColorForFavoriteButton(with status: Bool)
}

protocol CourseDetailsViewOutputProtocol {
    init(view: CourseDetailsViewInputProtocol)
    func showDetails()
    func favoriteButtonPressed()
}

class CourseDetailViewController: UIViewController {
    
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var numberOfLessonsLabel: UILabel!
    @IBOutlet weak var numberOfLessonsTests: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var presenter: CourseDetailsViewOutputProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showDetails()
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        presenter.favoriteButtonPressed()
    }
}

// MARK: - CourseDetailsViewInputProtocol
extension CourseDetailViewController: CourseDetailsViewInputProtocol {
    
    func displayCourseName(with title: String) {
        courseNameLabel.text = title
    }
    
    func displayNumberOfLessons(with title: String) {
        numberOfLessonsLabel.text = title
    }
    
    func displayNumberOfTests(with title: String) {
        numberOfLessonsTests.text = title
    }
    
    func displayCourseImage(with data: Data) {
        courseImage.image = UIImage(data: data)
    }
    
    func displayColorForFavoriteButton(with status: Bool) {
        favoriteButton.tintColor = status ? .red : .gray
    }
}
