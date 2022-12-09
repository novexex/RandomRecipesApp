//
//  FavoritesViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func getEntity(meal: ParcedMeal)
    func getEntity(drink: ParcedDrinkClass)
}

class FavoritesViewController: UIViewController {
    var presenter: FavoritesPresenterProtocol?
    let tableViewController = UITableViewController()
    var savedRecipe = [AnyObject]()
    let identifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        title = Resources.Titles.NavBar.favorites
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.favorites
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource, FavoritesViewProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedRecipe.isEmpty ? 0 : savedRecipe.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard !savedRecipe.isEmpty else { return cell }
        if let drink = savedRecipe[indexPath.row] as? ParcedDrinkClass {
            if #available(iOS 14.0, *) {
                var content = cell.defaultContentConfiguration()
                content.text = drink.strDrink
                cell.contentConfiguration = content
            } else {
                cell.textLabel?.text = drink.strDrink
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func initialize() {
        view.addSubview(tableViewController.tableView)
        //tableView.rowHeight = 100
        tableViewController.tableView.pin(to: view)
        tableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
    }

    func getEntity(drink: ParcedDrinkClass) {
        savedRecipe.append(drink)
    }
    
    func getEntity(meal: ParcedMeal) {
        
    }
}
