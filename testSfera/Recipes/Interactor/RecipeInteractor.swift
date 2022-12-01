//
//  RecipeInteractor.swift
//  testSfera
//
//  Created by Artour Ilyasov on 28.11.2022.
//

import Foundation

protocol RecipeInteractorProtocol: AnyObject {
    func loadMeal()
    func loadCocktail()
}

class RecipeInteractor: RecipeInteractorProtocol {
    weak var presenter: RecipePresenterProtocol?
    var mealService = Meal()
    var drinkService = Drink()
    
    func loadMeal() {
        var request = URLRequest(url: URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")! as URL,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if (error != nil) {
                print("error")
            } else {
                guard let data = data else { return }
                guard let model = try? JSONDecoder().decode(Meal.self, from: data) else { return }
                self.mealService = model
                print(self.mealService)
            }
        }.resume()
    }
    
    func loadCocktail() {
        var request = URLRequest(url: URL(string: "https://www.thecocktaildb.com/api/json/v1/1/random.php")! as URL,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if (error != nil) {
                print("error")
            } else {
                guard let data = data else { return }
                guard let model = try? JSONDecoder().decode(Drink.self, from: data) else { return }
                self.drinkService = model
                print(self.drinkService)
            }
        }.resume()
    }
    
}
