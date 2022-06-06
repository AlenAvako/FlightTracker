//
//  FactoryProtocol.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//

import UIKit

enum ViewControllers {
    case flightList(viewModel: FlightTableViewModel)
    
    func produceViewController() -> UIViewController {
        switch self {
        case .flightList(let viewModel):
            return FlightTableViewController(viewModel: viewModel)
        }
    }
}

protocol FactoryProtocol: AnyObject {
    func getViewController(for viewController: ViewControllers) -> UIViewController
}
