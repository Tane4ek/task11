//
//  DescriptionCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 05.10.2021.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
   
    static let reusedId = "DescriptionCollectionViewCell"
    
    var containerView = UIView(frame: .zero)
    var descriptionLabel = UILabel(frame: .zero)
    var descriptionText = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupUIElements()
    }
    
    func setupUIElements() {
        setupContainerView()
        setupdescriptionText()
        setupLayout()
    }
    
    func setupContainerView() {
        containerView.backgroundColor = UIColor(named: "White")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }
    
    func setupdescriptionText() {
        descriptionText.font = UIFont(name: "roboto-medium", size: 14)
        descriptionText.textColor = UIColor(named: "Smoky Black")
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.numberOfLines = 0
        containerView.addSubview(descriptionText)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            descriptionText.topAnchor.constraint(equalTo: containerView.topAnchor),
            descriptionText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            descriptionText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
