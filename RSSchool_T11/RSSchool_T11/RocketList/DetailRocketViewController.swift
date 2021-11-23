//
//  DetailImageViewController.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 06.10.2021.
//

import UIKit

class DetailRocketViewController: UIViewController {

    let closeButton = UIButton(frame: .zero)
    var detailRocketView = UIImageView(frame: .zero)
    var detailRocketString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
print(detailRocketString)
        setupUI()
    }
    func setupUI() {
        view.backgroundColor = UIColor(named: "White")
        setupDetailRocketView()
        setupCloseButton()
        setupLayout()
    }
        
    func setupDetailRocketView() {
        if let image = getImage(from: detailRocketString) {
            detailRocketView.image = image
        }
        detailRocketView.translatesAutoresizingMaskIntoConstraints = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(detailRocketViewTapped(tapGestureRecognizer:)))
        detailRocketView.isUserInteractionEnabled = true
        detailRocketView.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(detailRocketView)
    }
    
    func setupCloseButton() {
        closeButton.setImage(UIImage(named: "crossCircularButton"), for: .normal)
        closeButton.tintColor = UIColor(named: "Coral")
        closeButton.backgroundColor = UIColor(named: "White")
        closeButton.layer.cornerRadius = 16
        closeButton.layer.shadowRadius = 3
        closeButton.layer.shadowOpacity = 0.5
        closeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(closeButton)
    }
        
    func setupLayout() {
        NSLayoutConstraint.activate([
            detailRocketView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailRocketView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            detailRocketView.heightAnchor.constraint(equalToConstant: 566),
                
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32)
        ])
            
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func detailRocketViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if view.backgroundColor == UIColor.black {
            view.backgroundColor = UIColor(named: "White")
            closeButton.isHidden = false
        } else {
            view.backgroundColor = UIColor.black
            closeButton.isHidden = true
        }
    }
    
    func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }
}
