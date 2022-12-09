//
//  FavoritesViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func getEntity(meal: ParcedMeal)
    func getEntity(drink: ParcedDrink)
}

class FavoritesViewController: UIViewController {
    // MARK: - Public
    var presenter: FavoritesPresenterProtocol?
    var tableView = UITableView()
    var recipesTuple: ()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        title = Resources.Titles.NavBar.favorites
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.favorites
    }
}

// MARK: - Private functions
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    //устанавливаем количество строчек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "123123123"
        guard let cell else { return UITableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("asd")
    }
    
    func initialize() {
        view.addSubview(tableView)
        setTableViewDelegates()
        //tableView.rowHeight = 100
        tableView.pin(to: view)
    }
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - FavoritesViewProtocol
extension FavoritesViewController: FavoritesViewProtocol {
    func getEntity(meal: ParcedMeal) {
        
    }
    
    func getEntity(drink: ParcedDrink) {
        //recipesTuple.
    }
    
}
