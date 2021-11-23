//
//  GalleryCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 09.09.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "CollectionViewCell"
    
    var containerView = UIView(frame: .zero)
    var rocketImage = UIImageView(frame: .zero)
    var nameRocket = UILabel(frame: .zero)
    var stackView = UIStackView(frame: .zero)
    var stackViewHorizontalName = UIStackView(frame: .zero)
    var stackViewHorizontalValue = UIStackView(frame: .zero)
    let labelNames = ["First Launch", "Launch Cost", "Success"]
    let labelValue: [String] = []
    var date = UILabel()
    var cost = UILabel()
    var success = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupUIElements()
    }
    
    func setupUIElements() {
        setupContainerView()
        setupRocketImage()
        setupNameRocket()
        setupVerticalStack()
        setupStackViewHorizontalName()
        setupStackViewHorizontalValue()
        setupLayoutRocketCell()
    }
    
    func setupContainerView() {
        containerView.backgroundColor = UIColor(named: "White")
        containerView.layer.cornerRadius = 20;
        containerView.clipsToBounds = true;
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }
    
    func setupRocketImage() {
        rocketImage.image = UIImage(named: "Placeholder")
        //        rocketImage.image = SearchResponse.image ? user.image : UIImage(named: "Placeholder")
        rocketImage.backgroundColor = UIColor.blue
        rocketImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(rocketImage)
    }
    
    func setupNameRocket() {
        nameRocket.font = UIFont(name: "roboto-bold", size: 24)
        nameRocket.tintColor = UIColor(named: "Smoky Black")
        nameRocket.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameRocket)
    }
    
    func setupVerticalStack() {
        stackView = verticalStackViewStyle()
        containerView.addSubview(stackView)
    }
    
    func setupStackViewHorizontalName() {
        stackViewHorizontalName = horizontalStackViewStyle()
        stackView.addArrangedSubview(stackViewHorizontalName)
        labelNames.forEach({
            let label = labelStyle(title: $0)
            stackViewHorizontalName.addArrangedSubview(label)
        })

    }
    
    func setupStackViewHorizontalValue() {
        stackViewHorizontalValue = horizontalStackViewStyle()
        stackView.addArrangedSubview(stackViewHorizontalValue)
        
        date = valuelabelStyle()
        stackViewHorizontalValue.addArrangedSubview(date)
        
        cost = valuelabelStyle()
        stackViewHorizontalValue.addArrangedSubview(cost)
        
        success = valuelabelStyle()
        stackViewHorizontalValue.addArrangedSubview(success)
    }
    
    func setupLayoutRocketCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rocketImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            rocketImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            rocketImage.heightAnchor.constraint(equalToConstant: 240),
            
            nameRocket.topAnchor.constraint(equalTo: rocketImage.bottomAnchor, constant: 10),
            nameRocket.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: nameRocket.bottomAnchor, constant: 27),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    func horizontalStackViewStyle() -> UIStackView {
        let horizontalStackViewStyle = UIStackView()
        horizontalStackViewStyle.axis = .horizontal
        horizontalStackViewStyle.distribution = .equalCentering
        horizontalStackViewStyle.spacing = 10
        horizontalStackViewStyle.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackViewStyle
    }
    
    func verticalStackViewStyle() -> UIStackView {
        let verticalStackViewStyle = UIStackView()
        verticalStackViewStyle.axis = .vertical
        verticalStackViewStyle.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackViewStyle
    }
    
    func labelStyle(title: String) -> UILabel {
        let labelStyle = UILabel()
        labelStyle.text = title
        labelStyle.textColor = UIColor(named: "Smoky Black")
        labelStyle.font = UIFont(name: "roboto-bold", size: 14)
        labelStyle.textAlignment = .left
        return labelStyle
    }
    
    func valuelabelStyle() -> UILabel {
        let valuelabelStyle = UILabel()
        valuelabelStyle.font = UIFont(name: "roboto-bold", size: 14)
        valuelabelStyle.textColor = UIColor(named: "Slate Gray")
        valuelabelStyle.textAlignment = .left
        return valuelabelStyle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

