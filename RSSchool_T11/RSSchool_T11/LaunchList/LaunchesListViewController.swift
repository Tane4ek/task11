//
//  Launches_ListVC.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 09.09.2021.
//

import UIKit

struct LaunchesModel {
    let name: String
    let date: String
    let check: String
    let number: String
    let image: String?
}

class LaunchesListViewController: UIViewController {
    
    var launchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    let launchListNetworkService = LaunchNetworkingService()
    var launchListSearcResponce: [LaunchSearchResponse]? = nil
    
    var arrayLaunches: [LaunchesModel] = []
    
    let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDataFromServer()
    }
    
    func updateDataFromServer() {
        let urlString = "https://api.spacexdata.com/v5/launches"
        indicator.color = UIColor.red
        indicator.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        launchListNetworkService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let launchListSearchResponse):
                self?.launchListSearcResponce = launchListSearchResponse
                self?.launchCollectionView.reloadData()
                self?.arrayLaunches = launchListSearchResponse.map({
                    LaunchesModel(name: $0.name, date: $0.dateUtc, check: "\($0.success)", number: "#\($0.flightNumber)", image: $0.links.patch.small)
                })
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "Queen Blue")
        setupNavigationBar()
        setupLaunchCollectionView()
        setupLayoutLaunches()
    }
    
    func setupNavigationBar() {
        navigationController!.navigationBar.barTintColor = UIColor(named: "Queen Blue")
        navigationController!.navigationBar.isTranslucent = false
        let arrows = UIBarButtonItem(image: UIImage(named: "upAndDownArrows"), style: .done, target: self, action: #selector(arrowTapped))
        navigationItem.rightBarButtonItem  = arrows
        navigationController?.navigationBar.tintColor = UIColor(named: "Coral")
    }
    
    func setupLaunchCollectionView() {
        launchCollectionView.register(LaunchCollectionViewCell.self, forCellWithReuseIdentifier: LaunchCollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        launchCollectionView.setCollectionViewLayout(layout, animated: true)
        launchCollectionView.delegate = self
        launchCollectionView.dataSource = self
        launchCollectionView.backgroundColor = UIColor.clear
        layout.minimumLineSpacing = 30
        launchCollectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        view.addSubview(launchCollectionView)
        launchCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayoutLaunches() {
        NSLayoutConstraint.activate([
            launchCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            launchCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            launchCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            launchCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func getImage(from string: String, completion:@escaping ((UIImage?) -> Void)) {
            guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                completion(nil)
                return
            }

            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url, options: [])
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        completion(image)
                    }
                }
                catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
    
    @objc func arrowTapped(){
         print("arrow tapped")
    }
}

// MARK: - UICollectionViewDelegate
extension LaunchesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let launchesViewController = LaunchesViewController()
        launchesViewController.launchesindex = indexPath.row
        launchesViewController.mainName = arrayLaunches[indexPath.row].name
        navigationController?.pushViewController(launchesViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension LaunchesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launchListSearcResponce?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.launchCollectionView.dequeueReusableCell(withReuseIdentifier: LaunchCollectionViewCell.reusedId, for: indexPath) as! LaunchCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.name.text = arrayLaunches[indexPath.row].name
        cell.date.text = arrayLaunches[indexPath.row].date
        cell.number.text = arrayLaunches[indexPath.row].number
        let string = arrayLaunches[indexPath.row].image ?? "Placeholder"
        let image = getImage(from: string, completion: { (image: UIImage?) in
                    cell.image.image = image
                })
//        if let image = getImage(from: string) {
//            cell.image.image = image
//    }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LaunchesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 30, height: 145)
    }
}



