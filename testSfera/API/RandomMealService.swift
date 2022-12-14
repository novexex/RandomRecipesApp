//
//  RandomMealService.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022.
//

import Foundation

class RandomMealService {
    func getDate(completion: @escaping (Meal) -> Void) {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")
        guard let url else { return }
        var request = URLRequest(url: url, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data else { return }
            do {
                let model = try JSONDecoder().decode(Meal.self, from: data)
                completion(model)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
