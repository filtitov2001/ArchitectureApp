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
    
    var course: Course!
    
    private var isFavorite = false

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavoriteStatus()
        setupUI()
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        isFavorite.toggle()
        setStatusForFavoriteButton()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite)
    }
    
    private func setupUI() {
        courseNameLabel.text = course.name
        numberOfLessonsLabel.text = "Number of lessons: \(course.numberOfLessons)"
        numberOfLessonsTests.text = "Number of tests: \(course.numberOfTests)"
        
        if let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl) {
            courseImage.image = UIImage(data: imageData)
        }
        
        setStatusForFavoriteButton()
    }
    
    private func setStatusForFavoriteButton() {
        favoriteButton.tintColor = isFavorite ? .red : .gray
    }
    
    private func loadFavoriteStatus() {
        isFavorite = DataManager.shared.getFavoriteStatus(for: course.name)
    }
}
