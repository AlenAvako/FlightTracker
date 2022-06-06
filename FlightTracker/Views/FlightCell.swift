//
//  FlightCell.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//

import UIKit

class FlightCell: UITableViewCell {
    
    private enum ViewSetUps {
        static let fontForLabels = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let fontForDates = UIFont.systemFont(ofSize: 13)
        static let fontColor = UIColor.black
        static let cityImage = UIImage(named: "Волгоград")
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.addSubviews(departureStackView, arrivalStackView, priceView, likeView, arrowsImage)
        return view
    }()
    
    private lazy var departLabel: UILabel = {
        let label = UILabel()
        label.font = ViewSetUps.fontForLabels
        label.textColor = ViewSetUps.fontColor
        return label
    }()
    
    private lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.font = ViewSetUps.fontForDates
        label.textColor = ViewSetUps.fontColor
        return label
    }()
    
    private lazy var departureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(departLabel)
        stackView.addArrangedSubview(departureDateLabel)
        return stackView
    }()
    
    private lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = ViewSetUps.fontForLabels
        label.textColor = ViewSetUps.fontColor
        return label
    }()
    
    private lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.font = ViewSetUps.fontForDates
        label.textColor = ViewSetUps.fontColor
        return label
    }()
    
    private lazy var arrivalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(arrivalLabel)
        stackView.addArrangedSubview(arrivalDateLabel)
        return stackView
    }()
    
    private lazy var priceView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view .backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
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
        view.tintColor = .white
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 10
        view.addSubview(likeImage)
        return view
    }()
    
    private lazy var likeImage: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = UIImage(systemName: "heart.fill")
        image.tintColor = .white
        return image
    }()
    
    private lazy var arrowsImage: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = UIImage(named: "arrows")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemGray5
        selectionStyle = .none
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        departLabel.text = ""
        arrivalLabel.text = ""
        departureDateLabel.text = ""
        arrivalDateLabel.text = ""
        priceLabel.text = ""
    }
    
    func showLike() {
        likeView.isHidden = false
    }
    
    func setUpFlight(flight: FlightInfo) {
        likeView.isHidden = true
        
        departLabel.text = flight.startCity
        arrivalLabel.text = flight.endCity
        
        let departureString = DateManager.shared.getStringFromDate(dateString: flight.startDate, dateFormat: "dd.MM.yyyy")
        departureDateLabel.text = departureString
        
        let arrivalString = DateManager.shared.getStringFromDate(dateString: flight.endDate, dateFormat: "dd.MM.yyyy")
        arrivalDateLabel.text = arrivalString
        
        priceLabel.text = "Цена \(flight.price) ₽"
    }
    
    private func setUpConstraints() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            departureStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            departureStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            departureStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            
            arrivalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            arrivalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            
            priceView.centerYAnchor.constraint(equalTo: containerView.bottomAnchor),
            priceView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            priceView.heightAnchor.constraint(equalToConstant: 20),
            priceView.widthAnchor.constraint(equalToConstant: 120),
            
            priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: priceView.centerYAnchor),
            
            likeView.centerYAnchor.constraint(equalTo: containerView.topAnchor),
            likeView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            likeView.heightAnchor.constraint(equalToConstant: 20),
            likeView.widthAnchor.constraint(equalToConstant: 20),
            
            likeImage.centerYAnchor.constraint(equalTo: likeView.centerYAnchor),
            likeImage.centerXAnchor.constraint(equalTo: likeView.centerXAnchor),
            likeImage.heightAnchor.constraint(equalToConstant: 15),
            likeImage.widthAnchor.constraint(equalTo: likeImage.heightAnchor),
            
            arrowsImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            arrowsImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            arrowsImage.heightAnchor.constraint(equalToConstant: 18),
            arrowsImage.widthAnchor.constraint(equalTo: arrowsImage.heightAnchor)
        ])
    }
}

