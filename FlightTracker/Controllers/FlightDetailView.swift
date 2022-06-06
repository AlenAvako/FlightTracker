//
//  FlightDetailView.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//


import UIKit

class FlightDetailView: UIViewController {
    
    private let flight: FlightInfo
    
    private let detailView = DetailView()
    
    var searchToken = String() {
            didSet {
                if FavoriteManager.shared.checkFlightStatus(token: self.searchToken) {
                    detailView.likeFlight()
                } else {
                    detailView.dislikeFlight()
                }
            }
        }
    
    init(flight: FlightInfo) {
        self.flight = flight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = detailView
        detailView.setUpFlight(flight: flight)
        searchToken = flight.searchToken
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.delegate = self
    }
}

extension FlightDetailView: DetailViewDelegate {
    func closeView() {
        self.dismiss(animated: true)
    }
    
    func likeView() {
        FavoriteManager.shared.addToFavorites(token: self.searchToken)
        if FavoriteManager.shared.checkFlightStatus(token: self.searchToken) {
            detailView.likeFlight()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        } else {
            detailView.dislikeFlight()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
}
