//
//  DateManager.swift
//  FlightTracker
//
//  Created by Ален Авако on 06.06.2022.
//

import Foundation

class DateManager {
    static let shared = DateManager()
    
    private func getDateFromString(dateString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        guard let dateString = formatter.date(from: dateString) else {
            return nil
        }
        return dateString
    }
    
    func getStringFromDate(dateString: String, dateFormat: String?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        guard let dateToFormat = getDateFromString(dateString: dateString) else { return "" }
        let date = formatter.string(from: dateToFormat)
        return date
    }
    
    private init() {}
}
