//
//  launchesImageCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 29.09.2021.
//

import UIKit

class LaunchesImageCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "LaunchesImageCollectionViewCell"
    
    var containerView = UIView(frame: .zero)
    var launchImage = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIImageCell()
    }
    
    func setupUIImageCell() {
        setupContainerImageView()
        setupLaunchImage()
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
    
    func setupLaunchImage() {
        launchImage.image = UIImage(named: "Placeholder")
        launchImage.layer.cornerRadius = 5
        launchImage.clipsToBounds = true
//        self.rocketImage.image = SearchResponse.image ? user.image : UIImage(named: "Placeholder")
        launchImage.backgroundColor = UIColor.blue
        launchImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(launchImage)
    }
    
    func setupLayoutImageCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            launchImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 3),
            launchImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 3),
            launchImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -3),
            launchImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -3)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
