//
//  File.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//

import UIKit

final class ControllerFactory: FactoryProtocol {
    func getViewController(for enumOfVC: ViewControllers) -> UIViewController {
        return enumOfVC.produceViewController()
    }
}
