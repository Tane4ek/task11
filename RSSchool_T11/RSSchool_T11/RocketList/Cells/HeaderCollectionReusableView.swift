//
//  HeaderCollectionReusableView.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 06.10.2021.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    var headerName = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        
        func setupUI() {
            headerName.font = UIFont(name: "roboto-bold", size: 24)
            headerName.translatesAutoresizingMaskIntoConstraints = false
            addSubview(headerName)
        }
        
        func setupLayout() {
            NSLayoutConstraint.activate([
                headerName.topAnchor.constraint(equalTo: topAnchor, constant: 30),
                headerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//                headerName.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 20)
            ])
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
