//
//  File.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 13.09.2021.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {
    static let reusedId = "LaunchCollectionViewCell"
    
    var container = UIView(frame: .zero)
    var image = UIImageView(frame: .zero)
    var name = UILabel(frame: .zero)
    var date = UILabel(frame: .zero)
    var check = UIImageView(frame: .zero)
    var number = UILabel(frame: .zero)
    var subnumber = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUILaunchCell()
    }
    
    func setupUILaunchCell() {
        setupContainer()
        setupNameLaunch()
        setupDate()
        setupCheck()
        setupSubnumber()
        setupNumber()
        setupImageLaunch()
        setupLayoutLaunchCell()
    }
    
    func setupContainer() {
        container.backgroundColor = UIColor(named: "White")
        container.layer.cornerRadius = 15;
        //        self.container.clipsToBounds = true;
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
    }
    
    func setupNameLaunch() {
        name.text = "CRS-23"
        name.font = UIFont(name: "roboto-bold", size: 24)
        name.tintColor = UIColor(named: "Smoky Black")
        name.numberOfLines = 1
        name.minimumScaleFactor = 0.5
        name.adjustsFontSizeToFitWidth = true
        name.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(name)
    }
    
    func setupDate() {
        date.text = "August 29, 2021"
        date.font = UIFont(name: "roboto-medium", size: 17)
        date.tintColor = UIColor(named: "Smoky Black")
        date.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(date)
    }
    
    func setupCheck() {
        check.image = UIImage(named: "checkmark")
        check.tintColor = UIColor(named: "Cyan Process")
        check.layer.shadowRadius = 3
        check.layer.shadowOpacity = 0.5
        check.layer.shadowOffset = CGSize(width: 2, height: 2)
        check.backgroundColor = UIColor(named: "White")
        check.layer.cornerRadius = 16
        check.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(check)
    }
    
    func setupSubnumber() {
        subnumber.layer.shadowColor = UIColor(named: "Smoky Black")?.cgColor
        subnumber.layer.shadowRadius = 3
        subnumber.layer.shadowOpacity = 0.5
        subnumber.layer.shadowOffset = CGSize(width: 2, height: 2)
        subnumber.backgroundColor = UIColor(named: "White")
        subnumber.layer.cornerRadius = 10
        subnumber.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(subnumber)
    }
    
    func setupNumber() {
        number.text = "#133"
        number.font = UIFont(name: "roboto-medium", size: 17)
        number.textColor = UIColor(named: "Cyan Process")
        number.layer.cornerRadius = 16
        number.clipsToBounds = true
        number.textAlignment = .center
        number.backgroundColor = UIColor(named: "White")
        number.translatesAutoresizingMaskIntoConstraints = false
        subnumber.addSubview(number)
    }
    
    func setupImageLaunch() {
        image.image = UIImage(named: "Placeholder")
        image.clipsToBounds = true
        image.backgroundColor = UIColor(named: "White")
        image.layer.cornerRadius = 16
        image.layer.shadowRadius = 3
        image.layer.shadowOpacity = 0.5
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(image)
    }
    
    func setupLayoutLaunchCell() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            name.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -5),
            
            date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            date.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            check.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 21),
            check.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            check.heightAnchor.constraint(equalToConstant: 30),
            check.widthAnchor.constraint(equalToConstant: 30),
            
            subnumber.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 21),
            subnumber.leadingAnchor.constraint(equalTo: check.trailingAnchor, constant: 10),
            subnumber.widthAnchor.constraint(equalToConstant: 70),
            
            number.widthAnchor.constraint(equalToConstant: 59),
            number.heightAnchor.constraint(equalToConstant: 32),
            
            image.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
