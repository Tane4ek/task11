//
//  ImageCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 14.09.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "ImageCollectionViewCell"
    
    var containerView = UIView(frame: .zero)
    var rocketImage = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIImageCell()
    }
    
    func setupUIImageCell() {
        setupContainerImageView()
        setupRocketImage()
        setupLayoutImageCell()
    }
    
    func setupContainerImageView() {
        containerView.backgroundColor = UIColor(named: "White")
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor(named: "Slate Gray")?.cgColor
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize.zero
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }
    
    func setupRocketImage() {
        rocketImage.image = UIImage(named: "Placeholder")
        rocketImage.layer.cornerRadius = 5
        rocketImage.clipsToBounds = true
//        self.rocketImage.image = SearchResponse.image ? user.image : UIImage(named: "Placeholder")
        rocketImage.backgroundColor = UIColor.blue
        rocketImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(rocketImage)
    }
    
    func setupLayoutImageCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rocketImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 3),
            rocketImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 3),
            rocketImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -3),
            rocketImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -3)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
