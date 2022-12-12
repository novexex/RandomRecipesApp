//
//  FavoritesViewController.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func getEntity(meal: ParcedMealClass)
    func getEntity(drink: ParcedDrinkClass)
}

class FavoritesViewController: UIViewController {
    var presenter: FavoritesPresenterProtocol?
    let tableViewController = UITableViewController()
    let myVC = UITableViewController()
    var savedRecipes = [AnyObject]()
    let identifier = "cell"
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        title = Resources.Titles.NavBar.favorites
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.favorites
    }
    
    @objc func handleRefresh() {
        
        refresh.endRefreshing()
        guard !savedRecipes.isEmpty else { return }
        let indexPathRow = IndexPath(row: savedRecipes.count - 1, section: 0)
        guard tableViewController.tableView.numberOfRows(inSection: 0) == indexPathRow.row else { return }
        tableViewController.tableView.insertRows(at: [indexPathRow], with: .automatic)
        
    }
}


extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource, FavoritesViewProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedRecipes.isEmpty ? 0 : savedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard !savedRecipes.isEmpty else { return cell }
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            if let meal = savedRecipes[indexPath.row] as? ParcedMealClass {
                content.text = meal.strMeal
            } else if let drink = savedRecipes[indexPath.row] as? ParcedDrinkClass {
                content.text = drink.strDrink
            }
            cell.contentConfiguration = content
        } else {
            if let meal = savedRecipes[indexPath.row] as? ParcedMealClass {
                cell.textLabel?.text = meal.strMeal
            } else if let drink = savedRecipes[indexPath.row] as? ParcedDrinkClass {
                cell.textLabel?.text = drink.strDrink
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        let label = UILabel()
        
        if let meal = savedRecipes[indexPath.row] as? ParcedMealClass {
            label.text = meal.strMeal
        } else if let drink = savedRecipes[indexPath.row] as? ParcedDrinkClass {
            label.text = drink.strDrink
        }
        
        vc.view.addSubview(label)
        myVC.present(vc, animated: false)
    }
    
    func initialize() {
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        view.addSubview(tableViewController.tableView)
        tableViewController.tableView.addSubview(refresh)
        tableViewController.tableView.pin(to: view)
        tableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
    }
    
    func getEntity(drink: ParcedDrinkClass) {
        savedRecipes.append(drink)
    }
    
    func getEntity(meal: ParcedMealClass) {
        savedRecipes.append(meal)
    }
}
