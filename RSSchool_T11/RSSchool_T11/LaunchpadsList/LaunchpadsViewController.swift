//
//  LaunchpadsViewController.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 30.09.2021.
//

import UIKit
import MapKit
import CoreLocation

class LaunchpadsViewController: UIViewController {

    var launchpadsindex = Int()
    var mainLauncpadsName = String()
    
    let launchpadsNetworkService = LaunchpadsNetworkingService()
    var launchpadsSearcResponce: [LaunchpadsSearchResponse]? = nil
    
    var name = UILabel(frame: .zero)
    var fullName = UILabel(frame: .zero)
    var retired = UILabel(frame: .zero)
    var subretired = UIView(frame: .zero)
    
    var descriptionLaunchpadsLabel = UILabel(frame: .zero)
    var descriptionLaunchpadsText = UILabel(frame: .zero)
    
    var overviewLaunchpads = UILabel(frame: .zero)
    var overViewStackName = UIStackView(frame: .zero)
    var overViewStackValue = UIStackView(frame: .zero)
    var horizontalStackForOverView = UIStackView()
    let overviewNames = ["Region", "Location", "Launch attempts", "Launch success"]
    var overviewValueRegion = UILabel(frame: .zero)
    var overviewValueLocation = UILabel(frame: .zero)
    var overviewValuelaunchAttempts = UILabel(frame: .zero)
    var overviewValuelaunchSuccess = UILabel(frame: .zero)
    
    var imagesLaunchpads = UILabel(frame: .zero)
    
    var launchpadsImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var locationLabel = UILabel(frame: .zero)
    var locationMap = MKMapView()
    let locationManadger = CLLocationManager()
    let annotation = MKPointAnnotation()
    
    var materialsLaunchpads = UILabel(frame: .zero)
    var materialsButton = UIButton(frame: .zero)
    
    lazy var scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.translatesAutoresizingMaskIntoConstraints = false
            scroll.delegate = self
            scroll.contentSize = CGSize(width: view.frame.size.width, height: 1550)
            return scroll
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLaunchpadsUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDataFromServer()
        setupManager()
    }
    
    func updateDataFromServer() {
        let urlString = "https://api.spacexdata.com/v4/launchpads"
        launchpadsNetworkService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let launchpadsSearchResponse):
                self?.launchpadsSearcResponce = launchpadsSearchResponse
                
                self?.name.text = launchpadsSearchResponse[self!.launchpadsindex].name
                self?.fullName.text = launchpadsSearchResponse[self!.launchpadsindex].fullName
                self?.descriptionLaunchpadsText.text = launchpadsSearchResponse[self!.launchpadsindex].details
                self?.overviewValueRegion.text = launchpadsSearchResponse[self!.launchpadsindex].region
                self?.overviewValueLocation.text = launchpadsSearchResponse[self!.launchpadsindex].locality
                self?.overviewValuelaunchAttempts.text = String( launchpadsSearchResponse[self!.launchpadsindex].launchAttempts)
                self?.overviewValuelaunchSuccess.text = String( launchpadsSearchResponse[self!.launchpadsindex].launchSuccesses)
                self?.annotation.coordinate = CLLocationCoordinate2D(latitude: launchpadsSearchResponse[self!.launchpadsindex].latitude, longitude: launchpadsSearchResponse[self!.launchpadsindex].longitude)
                self?.annotation.title = launchpadsSearchResponse[self!.launchpadsindex].locality
                self?.locationMap.setRegion(MKCoordinateRegion(center: (self?.annotation.coordinate)!, latitudinalMeters: 500000, longitudinalMeters: 500000), animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupLaunchpadsUI() {
        view.backgroundColor = UIColor(named: "White")
        setupNavigationBar()
        setupScrollView()
        setupName()
        setupFullname()
        setupSubretired()
        setupLaunchpadsLabels()
        setupdescriptionLaunchpadsText()
        setupHorizontalStack()
        setupOverViewStack()
        setupOverViewStackValue()
        setupLaunchpadsImageCollectionView()
        setupLocationMap()
        setupButton()
        setupLayoutLauncpads()
    }
    
    func setupNavigationBar() {
        navigationItem.title = mainLauncpadsName
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "roboto-bold", size: 24)!, .foregroundColor: UIColor(named: "White") ?? UIColor.white]
        navigationController!.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
    }
    
    func setupName() {
        name.font = UIFont(name: "roboto-bold", size: 24)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = UIColor(named: "Smoky Black")
        scrollView.addSubview(name)
    }
    
    func setupFullname() {
        fullName.font = UIFont(name: "roboto-medium", size: 17)
        fullName.translatesAutoresizingMaskIntoConstraints = false
        fullName.textColor = UIColor(named: "Smoky Black")
        fullName.numberOfLines = 0
        scrollView.addSubview(fullName)
    }
    
    func setupLaunchpadsLabels() {
        descriptionLaunchpadsLabel = labelStyle(title: "Description")
        overviewLaunchpads = labelStyle(title: "Overview")
        imagesLaunchpads = labelStyle(title: "Images")
        locationLabel = labelStyle(title: "Location")
        materialsLaunchpads = labelStyle(title: "Materials")
    }
    
    func setupSubretired() {
        subretired.layer.shadowColor = UIColor(named: "Smoky Black")?.cgColor
        subretired.layer.shadowRadius = 3
        subretired.layer.shadowOpacity = 0.5
        subretired.layer.shadowOffset = CGSize(width: 2, height: 2)
        subretired.backgroundColor = UIColor(named: "White")
        subretired.layer.cornerRadius = 10
        subretired.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(subretired)
        setupRetired()
    }

    func setupRetired() {
        retired.text = "Retired"
        retired.font = UIFont(name: "roboto-medium", size: 17)
        retired.textColor = UIColor(named: "Cyan Process")
        retired.layer.cornerRadius = 16
        retired.clipsToBounds = true
        retired.textAlignment = .center
        retired.backgroundColor = UIColor(named: "White")
        retired.translatesAutoresizingMaskIntoConstraints = false
        subretired.addSubview(retired)
    }
    
    func setupdescriptionLaunchpadsText() {
        descriptionLaunchpadsText.font = UIFont(name: "roboto-medium", size: 14)
        descriptionLaunchpadsText.textColor = UIColor(named: "Smoky Black")
        descriptionLaunchpadsText.translatesAutoresizingMaskIntoConstraints = false
        descriptionLaunchpadsText.numberOfLines = 0
        scrollView.addSubview(descriptionLaunchpadsText)
    }
    
    func setupHorizontalStack() {
        horizontalStackForOverView = horStackViewStyle()
        scrollView.addSubview(horizontalStackForOverView)
    }
    
    func setupOverViewStack() {
        overViewStackName = vertStackViewStyle()
      
        overviewNames.forEach({let label = labelStyle(title: $0)
        label.textColor = UIColor(named: "Smoky Black")
        label.font = UIFont(name: "roboto-medium", size: 14)
        overViewStackName.addArrangedSubview(label)
        })

        horizontalStackForOverView.addArrangedSubview(overViewStackName)
    }
    
    func setupOverViewStackValue() {
        overViewStackValue = vertStackViewStyle()
        overviewValueRegion = labelValueStyle()
        overViewStackValue.addArrangedSubview(overviewValueRegion)
        overviewValueLocation = labelValueStyle()
        overViewStackValue.addArrangedSubview(overviewValueLocation)
        overviewValuelaunchAttempts = labelValueStyle()
        overViewStackValue.addArrangedSubview(overviewValuelaunchAttempts)
        overviewValuelaunchSuccess = labelValueStyle()
        overViewStackValue.addArrangedSubview(overviewValuelaunchSuccess)
        horizontalStackForOverView.addArrangedSubview(overViewStackValue)
    }
    
    func setupLaunchpadsImageCollectionView() {
        launchpadsImageCollectionView.register(LaunchpadsCollectionViewCell.self, forCellWithReuseIdentifier: LaunchpadsCollectionViewCell.reusedId)
        layout.scrollDirection = .horizontal
        launchpadsImageCollectionView.setCollectionViewLayout(layout, animated: true)
        launchpadsImageCollectionView.delegate = self
        launchpadsImageCollectionView.dataSource = self
        launchpadsImageCollectionView.backgroundColor = UIColor(named: "White")
        layout.minimumLineSpacing = 30
        launchpadsImageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        scrollView.addSubview(launchpadsImageCollectionView)
        launchpadsImageCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupManager() {
        locationManadger.delegate = self
        locationManadger.desiredAccuracy = kCLLocationAccuracyBest
    }
    func setupLocationMap() {
        locationMap.translatesAutoresizingMaskIntoConstraints = false
        locationMap.addAnnotation(annotation)
        locationMap.backgroundColor = UIColor.gray
        locationMap.layer.cornerRadius = 16
        locationMap.layer.borderColor = UIColor.white.cgColor
        locationMap.layer.borderWidth = 5
        locationMap.clipsToBounds = true
        scrollView.addSubview(locationMap)
    }
    
    func setupButton() {
        materialsButton.setTitle("Rockets", for: .normal)
        materialsButton.setImage(UIImage(named: "keyboardRight"), for: .normal)
        materialsButton.tintColor = UIColor(named: "Coral")
        materialsButton.titleLabel?.font = UIFont(name: "roboto-medium", size: 17)!
        materialsButton.setTitleColor(UIColor(named: "Coral"), for: .normal)
        materialsButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        materialsButton.semanticContentAttribute = .forceRightToLeft
        materialsButton.backgroundColor = UIColor(named: "White")
        materialsButton.layer.cornerRadius = 16
        materialsButton.layer.shadowRadius = 3
        materialsButton.layer.shadowOpacity = 0.5
        materialsButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        materialsButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(materialsButton)
    }
    
    func setupLayoutLauncpads() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            name.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            fullName.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            fullName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            fullName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            subretired.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 20),
            subretired.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            subretired.widthAnchor.constraint(equalToConstant: 70),

            retired.widthAnchor.constraint(equalToConstant: 69),
            retired.heightAnchor.constraint(equalToConstant: 32),
            
            descriptionLaunchpadsLabel.topAnchor.constraint(equalTo: retired.bottomAnchor, constant: 40),
            descriptionLaunchpadsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            descriptionLaunchpadsText.topAnchor.constraint(equalTo: descriptionLaunchpadsLabel.bottomAnchor, constant: 20),
            descriptionLaunchpadsText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLaunchpadsText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            overviewLaunchpads.topAnchor.constraint(equalTo: descriptionLaunchpadsText.bottomAnchor, constant: 20),
            overviewLaunchpads.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            horizontalStackForOverView.topAnchor.constraint(equalTo: overviewLaunchpads.bottomAnchor, constant: 20),
            horizontalStackForOverView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            imagesLaunchpads.topAnchor.constraint(equalTo: horizontalStackForOverView.bottomAnchor, constant: 30),
            imagesLaunchpads.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            launchpadsImageCollectionView.topAnchor.constraint(equalTo: imagesLaunchpads.bottomAnchor,constant: 20),
            launchpadsImageCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            launchpadsImageCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            launchpadsImageCollectionView.heightAnchor.constraint(equalToConstant: 190),
            
            locationLabel.topAnchor.constraint(equalTo: launchpadsImageCollectionView.bottomAnchor, constant: 30),
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            locationMap.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            locationMap.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            locationMap.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            locationMap.heightAnchor.constraint(equalToConstant: 384),
            
            materialsLaunchpads.topAnchor.constraint(equalTo: locationMap.bottomAnchor, constant: 30),
            materialsLaunchpads.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            materialsButton.topAnchor.constraint(equalTo: materialsLaunchpads.bottomAnchor, constant: 20),
            materialsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            materialsButton.heightAnchor.constraint(equalToConstant: 32),
            materialsButton.widthAnchor.constraint(equalToConstant: 105),
//            materialsButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
])
    }
    
    func labelStyle(title: String) -> UILabel {
        let labelStyle = UILabel()
        labelStyle.text = title
        labelStyle.font = UIFont(name: "roboto-bold", size: 24)
        labelStyle.textColor = UIColor(named: "Smoky Black")
        labelStyle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelStyle)
        return labelStyle
    }
    
    func labelValueStyle() -> UILabel {
        let labelStyle = UILabel()
        labelStyle.font = UIFont(name: "roboto-bold", size: 14)
        labelStyle.textColor = UIColor(named: "Slate Gray")
        labelStyle.translatesAutoresizingMaskIntoConstraints = false
        return labelStyle
    }
    
    func vertStackViewStyle() -> UIStackView {
        let stackViewStyle = UIStackView()
        stackViewStyle.axis = .vertical
        stackViewStyle.distribution = .fillEqually
        stackViewStyle.spacing = 15
        stackViewStyle.translatesAutoresizingMaskIntoConstraints = false
        return stackViewStyle
    }
    
    func horStackViewStyle() -> UIStackView {
        let stackViewStyle = UIStackView()
        stackViewStyle.axis = .horizontal
        stackViewStyle.spacing = 19
        stackViewStyle.translatesAutoresizingMaskIntoConstraints = false
        return stackViewStyle
    }
}

//MARK: - UIScrollViewDelegate
extension LaunchpadsViewController: UIScrollViewDelegate {
    
}

// MARK: - UICollectionViewDelegate
extension LaunchpadsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - UICollectionViewDataSource
extension LaunchpadsViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = launchpadsImageCollectionView.dequeueReusableCell(withReuseIdentifier: LaunchpadsCollectionViewCell.reusedId, for: indexPath) as! LaunchpadsCollectionViewCell
            return cell
        }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LaunchpadsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 139, height: launchpadsImageCollectionView.frame.height)
        }
}

// MARK: - UILocationManagerDelegate
extension LaunchpadsViewController: CLLocationManagerDelegate {
    
}

extension LaunchpadsViewController: MKMapViewDelegate {
    
}

