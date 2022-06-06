//
//  AppCoordinator.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private var window: UIWindow?
    private let factory: FactoryProtocol
    
    init(window: UIWindow?, factory: FactoryProtocol) {
        self.window = window
        self.factory = factory
    }
    
    func start() {
        initWindow()
    }
    
    private func initWindow() {
        let flightNC = UINavigationController(rootViewController: setViewController())
        self.window?.rootViewController = flightNC
        self.window?.makeKeyAndVisible()
    }
    
    private func setViewController() -> UIViewController {
        return factory.getViewController(for: .flightList(viewModel: FlightTableViewModel()))
    }
}
