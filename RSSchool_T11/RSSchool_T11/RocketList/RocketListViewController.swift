//
//  ViewController.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 09.09.2021.
//

import UIKit

struct RocketModel {
    let name: String
    let date: String
    let cost: String
    let success: String
    let image: String
}

class RocketListViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout:       UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    let networkService = NetworkService()
    var searcResponce: [SearchResponse]? = nil
    var array: [RocketModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDataFromServer()
    }
    
    func updateDataFromServer() {
        let urlString = "https://api.spacexdata.com/v4/rockets"
        networkService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let searchResponse):
                self?.searcResponce = searchResponse
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
                self?.array = searchResponse.map{
                    RocketModel(name: $0.name, date: $0.firstFlight, cost: "\($0.costPerLaunch)$", success: "\($0.successRatePct)%", image: $0.flickrImages.first!)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "Queen Blue")
        setupNavigationBar()
        setupActivityIndicator()
        setupCollectionView()
        setupLayout()
    }
    
    func setupNavigationBar() {
        navigationController!.navigationBar.barTintColor = UIColor(named: "Queen Blue")
        let arrows = UIBarButtonItem(image: UIImage(named: "upAndDownArrows"), style: .done, target: self, action: #selector(arrowTapped))
        navigationItem.rightBarButtonItem  = arrows
        navigationController?.navigationBar.tintColor = UIColor(named: "Coral")
    }
    
    func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
    }
    
    func setupCollectionView() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        layout.minimumLineSpacing = 30
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayout() {
    NSLayoutConstraint.activate([
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
    
    @objc func arrowTapped(){
        print("arrow tapped")
    }
}

// MARK: - UICollectionViewDelegate
extension RocketListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rocketVC = Rocket2ViewController()
        rocketVC.index = indexPath.row
        
        navigationController?.pushViewController(rocketVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension RocketListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searcResponce?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reusedId, for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 20
        cell.nameRocket.text = array[indexPath.row].name
        cell.date.text = array[indexPath.row].date
        cell.cost.text = array[indexPath.row].cost
        cell.success.text = array[indexPath.row].success
        let string = array[indexPath.row].image
        if let image = getImage(from: string) {
        cell.rocketImage.image = image
    }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RocketListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: 377)
    }
}


