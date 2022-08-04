//
//  ViewController.swift
//  ArchitectureApp
//
//  Created by Felix Titov on 8/4/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class CourseListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var activityIndicator: UIActivityIndicatorView?
    private var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        activityIndicator = showActivityIndicator(in: view)
        
        setupNavigationBar()
        getCourses()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? CourseDetailViewController else { return }
        detailVC.course = sender as? Course
    }
    
    private func getCourses() {
        NetworkManager.shared.fetchData { courses in
            self.courses = courses
            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating()
                self.tableView.reloadData()
            }
        }
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
        courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
                as? CourseTableViewCell
        else { return UITableViewCell() }
        
        let course = courses[indexPath.row]
        cell.configure(with: course)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let course = courses[indexPath.row]
        performSegue(withIdentifier: "ShowDetail", sender: course)
    }
}


