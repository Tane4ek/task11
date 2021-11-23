//
//  TitleImageCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 05.10.2021.
//

import UIKit

class TitleImageCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "TitleImageCollectionViewCell"
    
    var containerView = UIView(frame: .zero)
    var rocketImage = UIImageView(frame: .zero)
    var nameRocket = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupUIElements()
    }
    
    func setupUIElements() {
        setupContainerView()
        setupRocketImage()
        setupNameRocket()
        setupLayout()
    }
    
    func setupContainerView() {
        containerView.backgroundColor = UIColor(named: "Coral")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }
    
    func setupRocketImage() {
        rocketImage.image = UIImage(named: "Placeholder")
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = rocketImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.3
        rocketImage.addSubview(blurEffectView)
        rocketImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(rocketImage)
    }
    
    func setupNameRocket() {
        nameRocket.font = UIFont(name: "roboto-bold", size: 48)
//        nameRocket.tintColor = UIColor(named: "White")
        nameRocket.textColor = UIColor(named: "White")
        nameRocket.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameRocket)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rocketImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            rocketImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            rocketImage.heightAnchor.constraint(equalToConstant: 383),
            
            nameRocket.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 297),
            nameRocket.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
