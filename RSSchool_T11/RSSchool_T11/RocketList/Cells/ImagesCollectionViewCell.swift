//
//  ImagesCollectionViewCell.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 06.10.2021.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    static let reusedId = "ImagesCollectionViewCell"
    
    var containerView = UIView(frame: .zero)
    var imagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var imageString = [String]()
    weak var delegate: CustomCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIImageCell()
    }
    
    func setupUIImageCell() {
        setupContainerImageView()
        setupImagesCollectionView()
        setupLayoutImageCell()
    }
    
    func setupContainerImageView() {
        containerView.backgroundColor = UIColor(named: "White")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }
    
    func setupImagesCollectionView() {
        imagesCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reusedId)
        layout.scrollDirection = .horizontal
        imagesCollectionView.setCollectionViewLayout(layout, animated: true)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.backgroundColor = UIColor(named: "White")
        layout.minimumLineSpacing = 30
        imagesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imagesCollectionView)
    }
    
    func setupLayoutImageCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imagesCollectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imagesCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imagesCollectionView.heightAnchor.constraint(equalToConstant: 190),
        ])
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate
extension ImagesCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showDetailRocket(for: self)
        imagesCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ImagesCollectionViewCell: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imageString.count

        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reusedId, for: indexPath) as! ImageCollectionViewCell
            let string = imageString[indexPath.row]
            if let image = getImage(from: string) {
            cell.rocketImage.image = image
        }
            return cell
        }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImagesCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 139, height: imagesCollectionView.frame.height)
        }
}
