//
//  FlightTableViewController.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//

import UIKit

class FlightTableViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.registerCell(FlightCell.self)
        tableView.toAutoLayout()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        spinnerView = UIActivityIndicatorView(style: .large)
        return spinnerView
    }()
    
    private let viewModel: FlightTableViewModel
    
    init(viewModel: FlightTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        setUpNavigationBar()
        setUpSpinnerView()
        setUpCollectionView()
        setupViewModel()
        reloadTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.send(.viewWillAppear)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func reloadTableView() {
        self.tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    private func setUpNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Пора в путешествие"
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setUpSpinnerView() {
        view.addSubview(spinnerView)
        
        spinnerView.center = view.center
    }
    
    private func setUpCollectionView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initializing:
                self.hideContent()
                self.spinnerView.startAnimating()
            case .loading:
                self.hideContent()
                self.spinnerView.startAnimating()
            case .loaded:
                self.spinnerView.stopAnimating()
                self.showContent()
                self.tableView.reloadData()
            }
        }
    }
    
    private func showContent() {
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = 1
        }
    }
    
    private func hideContent() {
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = 0
        }
    }
    
    @objc func loadList(notification: NSNotification){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FlightTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.flightDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(forIndexPath: indexPath) as FlightCell
        let flight = viewModel.flightDetails[indexPath.row]
        cell.setUpFlight(flight: flight)
        
        if FavoriteManager.shared.checkFlightStatus(token: flight.searchToken) {
            cell.showLike()
        }
        
        return cell
    }
}

extension FlightTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flight = viewModel.flightDetails[indexPath.row]
        let detailView = FlightDetailView(flight: flight)
        detailView.modalPresentationStyle = .overCurrentContext
        present(detailView, animated: true)
    }
}
