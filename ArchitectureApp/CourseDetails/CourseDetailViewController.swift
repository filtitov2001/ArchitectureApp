//
//  CourseDetailViewController.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/4/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class CourseDetailViewController: UIViewController {
    
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var numberOfLessonsLabel: UILabel!
    @IBOutlet weak var numberOfLessonsTests: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var viewModel: CourseDetailsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    //    viewModel = CourseDetailsViewModel(course: course)
        
        setupUI()
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        viewModel.favoriteButtonPressed()
    }
    
    private func setupUI() {
        setStatusForFavoriteButton(viewModel.isFavorite.value)
        
        viewModel.isFavorite.bind { [weak self] isFavorite in
            self?.setStatusForFavoriteButton(isFavorite)
        }
        
        courseNameLabel.text = viewModel.courseName
        numberOfLessonsLabel.text = viewModel.numberOfLessons
        numberOfLessonsTests.text = viewModel.numberOfTests
        
        guard let imageData = viewModel.imageData else { return }
        courseImage.image = UIImage(data: imageData)
    }
    
    private func setStatusForFavoriteButton(_ status: Bool) {
        favoriteButton.tintColor = status ? .red : .gray
    }
    
}
