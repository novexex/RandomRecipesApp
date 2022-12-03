//
//  RandomMealService.swift
//  testSfera
//
//  Created by Artour Ilyasov on 01.12.2022.
//

import Foundation

class RandomMealService {
    func getDate(completion: @escaping (Meal) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            var request = URLRequest(url: URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")! as URL, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let model = try JSONDecoder().decode(Meal.self, from: data)
                    completion(model)
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
}
