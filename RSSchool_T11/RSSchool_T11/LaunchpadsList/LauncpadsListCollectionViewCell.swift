//
//  LauncpadsCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 29.09.2021.
//

import UIKit

class LauncpadsListCollectionViewCell: UICollectionViewCell {

    static let reusedId = "LaunchpadsListCollectionViewCell"
    
    var container = UIView(frame: .zero)
    var name = UILabel(frame: .zero)
    var region = UILabel(frame: .zero)
    var retired = UILabel(frame: .zero)
    var subretired = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUILaunchpadsListCell()
    }
    
    func setupUILaunchpadsListCell() {
        setupContainer()
        setupNameLaunchpads()
        setupRegion()
        setupRetired()
        setupSubretired()
        setupLayoutLaunchpadsCell()
    }
    
    func setupContainer() {
        container.backgroundColor = UIColor(named: "White")
        container.layer.cornerRadius = 15;
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
    }
    
    func setupNameLaunchpads() {
        name.text = "Name"
        name.font = UIFont(name: "roboto-bold", size: 24)
        name.tintColor = UIColor(named: "Smoky Black")
        name.numberOfLines = 1
        name.minimumScaleFactor = 0.5
        name.adjustsFontSizeToFitWidth = true
        name.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(name)
    }
    
    func setupRegion() {
        region.text = "Region"
        region.font = UIFont(name: "roboto-medium", size: 17)
        region.tintColor = UIColor(named: "Smoky Black")
        region.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(region)
    }
    
    func setupSubretired() {
        subretired.layer.shadowColor = UIColor(named: "Smoky Black")?.cgColor
        subretired.layer.shadowRadius = 3
        subretired.layer.shadowOpacity = 0.5
        subretired.layer.shadowOffset = CGSize(width: 2, height: 2)
        subretired.backgroundColor = UIColor(named: "White")
        subretired.layer.cornerRadius = 10
        subretired.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(subretired)
    }

    func setupRetired() {
        retired.text = "Retired"
        retired.font = UIFont(name: "roboto-medium", size: 17)
        retired.textColor = UIColor(named: "Cyan Process")
        retired.layer.cornerRadius = 16
        retired.clipsToBounds = true
        retired.textAlignment = .center
        retired.backgroundColor = UIColor(named: "White")
        retired.translatesAutoresizingMaskIntoConstraints = false
        subretired.addSubview(retired)
    }
    
    func setupLayoutLaunchpadsCell() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            name.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            region.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            region.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            subretired.topAnchor.constraint(equalTo: region.bottomAnchor, constant: 21),
            subretired.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subretired.widthAnchor.constraint(equalToConstant: 70),

            retired.widthAnchor.constraint(equalToConstant: 69),
            retired.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
