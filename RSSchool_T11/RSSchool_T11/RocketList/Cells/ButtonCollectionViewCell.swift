//
//  ButtonCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 06.10.2021.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "ButtonCollectionViewCell"
    
    var containerView = UIView(frame: .zero)
    var linkButton = UIButton(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIImageCell()
    }
    
    func setupUIImageCell() {
        setupContainerImageView()
        setupLinkButton()
        setupLayoutImageCell()
    }
    
    func setupContainerImageView() {
        containerView.backgroundColor = UIColor(named: "White")
//        containerView.layer.cornerRadius = 10
//        containerView.layer.shadowColor = UIColor(named: "Slate Gray")?.cgColor
//        containerView.layer.shadowRadius = 3
//        containerView.layer.shadowOpacity = 0.5
//        containerView.layer.shadowOffset = CGSize.zero
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }
    
    func setupLinkButton() {
        linkButton = buttonStyle()
        containerView.addSubview(linkButton)
    }
    
    func setupLayoutImageCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            linkButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            linkButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            linkButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            linkButton.heightAnchor.constraint(equalToConstant: 32),
            linkButton.widthAnchor.constraint(equalToConstant: 117),
        ])
    }
    
    func buttonStyle() -> UIButton {
        let buttonStyle = UIButton()
        buttonStyle.setImage(UIImage(named: "link"), for: .normal)
        buttonStyle.tintColor = UIColor(named: "Coral")
        buttonStyle.titleLabel?.font = UIFont(name: "roboto-medium", size: 17)!
        buttonStyle.setTitleColor(UIColor(named: "Coral"), for: .normal)
        buttonStyle.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        buttonStyle.semanticContentAttribute = .forceRightToLeft
        buttonStyle.backgroundColor = UIColor(named: "White")
        buttonStyle.layer.cornerRadius = 16
        buttonStyle.layer.shadowRadius = 3
        buttonStyle.layer.shadowOpacity = 0.5
        buttonStyle.layer.shadowOffset = CGSize(width: 2, height: 2)
        buttonStyle.translatesAutoresizingMaskIntoConstraints = false
        return buttonStyle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

