//
//  Launchpads_ListVC.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 09.09.2021.
//

import UIKit

struct LaunchpadsModel {
    let name: String
    let region: String
}

class LaunchpadsListViewController: UIViewController {
    
    var launchpadsListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    let launchpadsListNetworkService = LaunchpadsNetworkingService()
    var launchpadsListSearcResponce: [LaunchpadsSearchResponse]? = nil
    
    var arrayLaunchpadsList: [LaunchpadsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUILaunchpadsList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDataFromServer()
    }
    
    func updateDataFromServer() {
        let urlString = "https://api.spacexdata.com/v4/launchpads"
        launchpadsListNetworkService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let launchpadsSearchResponse):
                self?.launchpadsListSearcResponce = launchpadsSearchResponse
                self?.launchpadsListCollectionView.reloadData()
                self?.arrayLaunchpadsList = launchpadsSearchResponse.map({
                    LaunchpadsModel(name: $0.name, region: $0.region)
                })
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func setupUILaunchpadsList() {
        view.backgroundColor = UIColor(named: "Queen Blue")
        setupNavigationBar()
        setupLaunchpadsCollectionView()
        setupLayoutLaunchpads()
    }
    
    func setupNavigationBar() {
        navigationController!.navigationBar.barTintColor = UIColor(named: "Queen Blue")
        navigationController!.navigationBar.isTranslucent = false
        let arrows = UIBarButtonItem(image: UIImage(named: "upAndDownArrows"), style: .done, target: self, action: #selector(arrowTapped))
        navigationItem.rightBarButtonItem  = arrows
        navigationController?.navigationBar.tintColor = UIColor(named: "Coral")
    }
    
    func setupLaunchpadsCollectionView() {
        launchpadsListCollectionView.register(LauncpadsListCollectionViewCell.self, forCellWithReuseIdentifier: LauncpadsListCollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        launchpadsListCollectionView.setCollectionViewLayout(layout, animated: true)
        launchpadsListCollectionView.delegate = self
        launchpadsListCollectionView.dataSource = self
        launchpadsListCollectionView.backgroundColor = UIColor.clear
        layout.minimumLineSpacing = 30
        launchpadsListCollectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        view.addSubview(launchpadsListCollectionView)
        launchpadsListCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayoutLaunchpads() {
        NSLayoutConstraint.activate([
            launchpadsListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            launchpadsListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            launchpadsListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            launchpadsListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func arrowTapped(){
         print("arrow tapped")
    }
}

// MARK: - UICollectionViewDelegate
extension LaunchpadsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let launchpadsViewController = LaunchpadsViewController()
        launchpadsViewController.launchpadsindex = indexPath.row
        launchpadsViewController.mainLauncpadsName = arrayLaunchpadsList[indexPath.row].name
        navigationController?.pushViewController(launchpadsViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension LaunchpadsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launchpadsListSearcResponce?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.launchpadsListCollectionView.dequeueReusableCell(withReuseIdentifier: LauncpadsListCollectionViewCell.reusedId, for: indexPath) as! LauncpadsListCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.name.text = arrayLaunchpadsList[indexPath.row].name
        cell.region.text = arrayLaunchpadsList[indexPath.row].region
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LaunchpadsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 30, height: 140)
    }
}




