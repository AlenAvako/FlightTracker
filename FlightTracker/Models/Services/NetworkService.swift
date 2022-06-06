//
//  NetworkService.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//

import Foundation

struct NetworkService {
    static let shared = NetworkService()
        private let url = URL(string: "https://travel.wildberries.ru/statistics/v1/cheap")
            
        func fetchData(completion: @escaping ([FlightInfo]) -> Void) {
            guard let url = url else { return }
            let session = URLSession(configuration: .default)
            session.dataTask(with: url) { data, responce, error in
                guard let data = data else { return }
                do {
                    let responce = try JSONDecoder().decode(FetchResult.self, from: data)
                    let flights = responce.data
                    
                    DispatchQueue.main.async {
                        completion(flights)
                    }
                } catch let error {
                    print("Сервер не отвечает: \(error.localizedDescription)")
                }
            }.resume()
        }
}
