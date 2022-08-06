//
//  CourseTableViewCell.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/4/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class CourseTableViewCell: UITableViewCell {
    var viewModel: CourseCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.courseName
            guard let imageData = viewModel.imageData else { return }
            content.image = UIImage(data: imageData)
            contentConfiguration = content
        }
    }
}
