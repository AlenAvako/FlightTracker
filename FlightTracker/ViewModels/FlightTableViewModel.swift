//
//  FlightTableViewModel.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//

import Foundation

final class FlightTableViewModel {
    var onStateChanged: ((State) -> Void)?
    
    private(set) var flightDetails: [FlightInfo] = []
    
    private(set) var state: State = .initializing {
        didSet {
            onStateChanged?(state)
        }
    }
    
    func send(_ action: FlightTableViewModel.Action) {
        switch action {
        case .viewWillAppear:
            state = .loading
            makeRequest()
        }
    }
    
    private func makeRequest() {
        NetworkService.shared.fetchData { [weak self] flightInfo in
            self?.flightDetails = flightInfo
            self?.state = .loaded
        }

        
    }
}

extension FlightTableViewModel {
    enum State {
        case initializing
        case loading
        case loaded
    }
    
    enum Action {
        case viewWillAppear
    }
}
