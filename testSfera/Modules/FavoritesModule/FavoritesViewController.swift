//
//  FavoritesViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func presenterOutput(vc: DetailCellViewController)
    func configureWelcomeLabel()
    func removeWelcomeLabel()
    func tableView() -> UITableView
    func hideTableView()
}

class FavoritesViewController: BaseViewController {
    var presenter: FavoritesPresenterProtocol?
    private let tableViewController = UITableViewController()
    private let myVC = UITableViewController()
    private var welcomeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        configureWelcomeLabel()
        title = Resources.Titles.NavBar.favorites
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.favorites
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        presenter?.viewDidDisappear()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource, FavoritesViewProtocol {
    func hideTableView() {
        tableViewController.tableView.isHidden = true
    }
    
    func tableView() -> UITableView {
        tableViewController.tableView
    }
    
    func configureWelcomeLabel() {
        welcomeLabel = {
            let label = UILabel()
            label.text = Resources.Titles.welcomeLabel
            label.numberOfLines = 0
            label.textAlignment = .center
            label.sizeToFit()
            label.textColor = .gray
            
            return label
        }()
        view.addSubview(welcomeLabel)
        welcomeLabel.pin(to: view)
    }
    
    func presenterOutput(vc: DetailCellViewController) {
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { return 0 }
        return presenter.countRows(in: section)
    }
    
    func removeWelcomeLabel() {
        welcomeLabel.removeFromSuperview()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let presenter else { return 0 }
        return presenter.countSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.recipesAddCell(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter?.recipesActionCell(tableView, commit: editingStyle, forRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.detailView(didSelectRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter?.getSectionName(section: section)
    }
    
    func initialize() {
        view.addSubview(tableViewController.tableView)
        
        tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableViewController.tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableViewController.tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableViewController.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableViewController.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
        
        tableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Resources.CellIdentifiers.meal)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
    }
}
