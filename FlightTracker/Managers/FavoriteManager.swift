//
//  FavoriteManager.swift
//  FlightTracker
//
//  Created by Ален Авако on 07.06.2022.
//

import Foundation

final class FavoriteManager {
    static let shared = FavoriteManager()
    private var searchTokenFlights = [String]()
    
    func addToFavorites(token: String) {
        if searchTokenFlights.firstIndex(of: token) != nil {
            self.removeFromFavorites(token: token)
        } else {
            searchTokenFlights.append(token)
        }
        print(searchTokenFlights)
    }
    
    private func removeFromFavorites(token: String) {
        if let index = searchTokenFlights.firstIndex(of: token) {
            searchTokenFlights.remove(at: index)
        }
    }
    
    func checkFlightStatus(token: String) -> Bool {
        if searchTokenFlights.firstIndex(of: token) != nil {
            return true
        } else {
            return false
        }
    }
}
