//
//  OverviewCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 05.10.2021.
//

import UIKit

class NameValueCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "NameValueCollectionViewCell"
    
    var containerView = UIView(frame: .zero)
    var name = UILabel(frame: .zero)
    var value = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupUIElements()
    }
    
    func setupUIElements() {
        setupContainerView()
        setupOverviewName()
        setupOverviewValue()
        setupLayout()
    }
    
    func setupContainerView() {
        containerView.backgroundColor = UIColor(named: "White")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }
    
    func setupOverviewName() {
        name = labelStyle()
        name.textColor = UIColor(named: "Smoky Black")
    }
    
    func setupOverviewValue() {
        value = labelStyle()
        value.textColor = UIColor(named: "Slate Gray")
    }
    
    func labelStyle() -> UILabel {
        let labelStyle = UILabel()
        labelStyle.font = UIFont(name: "roboto-bold", size: 14)
        labelStyle.text = "Description"
        labelStyle.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelStyle)
        return labelStyle
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            name.topAnchor.constraint(equalTo: containerView.topAnchor),
            name.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            name.widthAnchor.constraint(equalToConstant: 120),
            name.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            value.topAnchor.constraint(equalTo: containerView.topAnchor),
            value.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 20),
            value.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
