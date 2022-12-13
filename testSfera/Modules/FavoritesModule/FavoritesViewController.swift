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
    var presenter: FavoritesPresenterProtocol?
    let tableViewController = UITableViewController()
    let myVC = UITableViewController()
    var savedRecipes = [AnyObject]()
    let refresh = UIRefreshControl()
    var welcomeLabel = UILabel()
    let identifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        configureWelcomeLabel()
        title = Resources.Titles.NavBar.favorites
        navigationController?.tabBarItem.title = Resources.Titles.TabBar.favorites
    }
    
    func configureWelcomeLabel() {
        welcomeLabel = {
            let label = UILabel()
            label.text = "You haven't saved any recipes yet,\n when you do drag up to refresh this page"
            label.numberOfLines = 0
            label.textAlignment = .center
            label.sizeToFit()
            label.textColor = .gray
            
            return label
        }()
        view.addSubview(welcomeLabel)
        welcomeLabel.pin(to: view)
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
        welcomeLabel.removeFromSuperview()
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard !savedRecipes.isEmpty else { return cell }
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            if let meal = savedRecipes[indexPath.row] as? ParcedMeal {
                content.text = meal.strMeal
            } else if let drink = savedRecipes[indexPath.row] as? ParcedDrink {
                content.text = drink.strDrink
            }
            cell.contentConfiguration = content
        } else {
            if let meal = savedRecipes[indexPath.row] as? ParcedMeal {
                cell.textLabel?.text = meal.strMeal
            } else if let drink = savedRecipes[indexPath.row] as? ParcedDrink {
                cell.textLabel?.text = drink.strDrink
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            savedRecipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.detailView(recipeEntity: savedRecipes[indexPath.row])
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
    
    func getEntity(drink: ParcedDrink) {
        savedRecipes.append(drink)
    }
    
    func getEntity(meal: ParcedMeal) {
        savedRecipes.append(meal)
    }
}
