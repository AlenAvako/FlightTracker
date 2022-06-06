//
//  DetailView.swift
//  FlightTracker
//
//  Created by Ален Авако on 05.06.2022.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func closeView()
    
    func likeView()
}

final class DetailView: UIView {
    
    weak var delegate: DetailViewDelegate?
    
    var searchTokenFlights = String() {
            didSet {
                if FavoriteManager.shared.checkFlightStatus(token: self.searchTokenFlights) {
                    likeFlight()
                } else {
                    dislikeFlight()
                }
            }
        }
    
    private enum ViewSetUps {
        static let cityFonts = UIFont.systemFont(ofSize: 23, weight: .heavy)
        static let cityCodeFonts = UIFont.systemFont(ofSize: 17)
        static let fontForDates = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let citysFontsColor = UIColor.black
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.addSubviews(departureStackView, arrivalStackView, priceView, likeView)
        return view
    }()
    
    private lazy var departureCityLabel: UILabel = {
        let label = UILabel()
        label.font = ViewSetUps.cityFonts
        label.textColor = ViewSetUps.citysFontsColor
        return label
    }()
    
    private lazy var departureCodeLabel: UILabel = {
        let label = UILabel()
        label.font = ViewSetUps.cityCodeFonts
        label.textColor = ViewSetUps.citysFontsColor
        return label
    }()
    
    private lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 0
        label.font = ViewSetUps.fontForDates
        label.textColor = ViewSetUps.citysFontsColor
        return label
    }()
    
    private lazy var departureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 1
        stackView.addArrangedSubview(departureCityLabel)
        stackView.addArrangedSubview(departureCodeLabel)
        stackView.addArrangedSubview(departureDateLabel)
        return stackView
    }()
    
    private lazy var arrivalCityLabel: UILabel = {
        let label = UILabel()
        label.font = ViewSetUps.cityFonts
        label.textColor = ViewSetUps.citysFontsColor
        return label
    }()
    
    private lazy var arrivalCodeLabel: UILabel = {
        let label = UILabel()
        label.font = ViewSetUps.cityCodeFonts
        label.textColor = ViewSetUps.citysFontsColor
        return label
    }()
    
    private lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 0
        label.font = ViewSetUps.fontForDates
        label.textColor = ViewSetUps.citysFontsColor
        return label
    }()
    
    private lazy var arrivalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 1
        stackView.addArrangedSubview(arrivalCityLabel)
        stackView.addArrangedSubview(arrivalCodeLabel)
        stackView.addArrangedSubview(arrivalDateLabel)
        return stackView
    }()
    
    private lazy var dissmissButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    private lazy var priceView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view .backgroundColor = .systemBlue
        view.layer.cornerRadius = 15
        view.addSubview(priceLabel)
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = ViewSetUps.fontForDates
        label.textColor = .white
        return label
    }()
    
    private lazy var likeView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.systemRed.cgColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 30
        view.addSubview(likeImage)
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(changeState))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTapGesture)
        return view
    }()
    
    private lazy var likeImage: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
        image.image = UIImage(systemName: "heart.fill", withConfiguration: largeConfig)
        image.tintColor = .systemRed
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        addSubviews(containerView, dissmissButton)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func likeFlight() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
            self.likeImage.image = UIImage(systemName: "heart.fill", withConfiguration: largeConfig)
            self.likeImage.tintColor = .white
            
            self.likeView.backgroundColor = .systemRed
        }, completion: nil)
    }
    
    func dislikeFlight() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
            self.likeImage.image = UIImage(systemName: "heart.fill", withConfiguration: largeConfig)
            self.likeImage.tintColor = .systemRed
            
            self.likeView.backgroundColor = .white
        }, completion: nil)
    }
    
    func setUpFlight(flight: FlightInfo) {
        departureCityLabel.text = flight.startCity
        arrivalCityLabel.text = flight.endCity
        
        departureCodeLabel.text = (flight.startCityCode).uppercased()
        arrivalCodeLabel.text = (flight.endCityCode).uppercased()
        
        let departureString = DateManager.shared.getStringFromDate(dateString: flight.startDate, dateFormat: "Дата: dd.MM.yyyy \nВремя: hh:mm")
        departureDateLabel.text = departureString
        let arrivalString = DateManager.shared.getStringFromDate(dateString: flight.endDate, dateFormat: "Дата: dd.MM.yyyy \nВремя: HH:mm")
        arrivalDateLabel.text = arrivalString
        
        priceLabel.text = "\(flight.price) ₽"
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            dissmissButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            dissmissButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 48),
            dissmissButton.heightAnchor.constraint(equalToConstant: 30),
            dissmissButton.widthAnchor.constraint(equalTo: dissmissButton.heightAnchor),

            departureStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            departureStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),

            arrivalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            arrivalStackView.topAnchor.constraint(equalTo: departureStackView.bottomAnchor, constant: 20),
            arrivalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            priceView.centerYAnchor.constraint(equalTo: containerView.bottomAnchor),
            priceView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            priceView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.33),
            priceView.heightAnchor.constraint(equalToConstant: 30),
            
            priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: priceView.centerYAnchor),
            
            likeView.centerYAnchor.constraint(equalTo: containerView.topAnchor),
            likeView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -48),
            likeView.heightAnchor.constraint(equalToConstant: 60),
            likeView.widthAnchor.constraint(equalTo: likeView.heightAnchor),
            
            likeImage.centerXAnchor.constraint(equalTo: likeView.centerXAnchor),
            likeImage.centerYAnchor.constraint(equalTo: likeView.centerYAnchor)
        ])
    }
    
    @objc private func changeState(_ tapGesture: UITapGestureRecognizer) {
        self.delegate?.likeView()
    }
    
    @objc private func close() {
        self.delegate?.closeView()
    }
}

