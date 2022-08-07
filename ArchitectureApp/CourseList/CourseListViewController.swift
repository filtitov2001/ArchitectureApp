//
//  CourseListViewController.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/4/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

protocol CourseListViewInputProtocol: AnyObject {
    func reloadData(for section: CourseSectionViewModel)
}

protocol CourseListViewOutputProtocol {
    init(view: CourseListViewInputProtocol)
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

class CourseListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CourseListViewOutputProtocol!
    
    private var activityIndicator: UIActivityIndicatorView?
    private var sectionViewModel: CourseSectionViewModel = CourseSectionViewModel()
    
    private let configurator: CourseListConfiguratorInputProtocol = CourseListConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.viewDidLoad()

        activityIndicator = showActivityIndicator(in: view)
        setupNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? CourseDetailViewController else { return }
        let configurator: CourseDetailsConfiguratorInputProtocol = CourseDetailsConfigurator()
        
        configurator.configure(with: detailVC, and: sender as! Course)
    }
    
    private func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navBarAppearance.backgroundColor = #colorLiteral(red: 0.2800109982, green: 0.4496016502, blue: 1, alpha: 1)
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}

// MARK: - UITableViewDataSource
extension CourseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionViewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath)
                as? CourseTableViewCell
        else { return UITableViewCell() }
        
        cell.viewModel = cellViewModel
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sectionViewModel.rows[indexPath.row].cellHeight
    }
}


extension CourseListViewController: CourseListViewInputProtocol {
    func reloadData(for section: CourseSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
        activityIndicator?.stopAnimating()
    }
}
