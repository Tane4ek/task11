//
//  Rocket2ViewController.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 05.10.2021.
//

import UIKit

protocol CustomCollectionViewCellDelegate: AnyObject {
    func showDetailRocket(for cell: ImagesCollectionViewCell)
}

struct MainImageModel {
    var name: String = ""
    var image: String = ""
}

struct DescriptionModel {
    var descriptionLabel: String = ""
    var descriptionText: String = ""
}

struct OverviewModel {
    var firstLaunch: String = ""
    var launchCost: String = ""
    var success: String = ""
    var mass: String = ""
    var height: String = ""
    var diameter: String = ""
}

struct ImageModel {
    var imageString : [String] = []
}

struct EnginesModel {
    var type: String = ""
    var layout: String = ""
    var version: String = ""
    var amount: String = ""
    var propellant1: String = ""
    var propellant2: String = ""
}

struct FirstStageModel {
    var reusable: String = ""
    var enginesAmount: String = ""
    var fuelAmount: String = ""
    var burningTime: String = ""
    var thrustSeaLevel: String = ""
    var thrustVacuum: String = ""
}

struct SecondStageModel {
    var reusable: String = ""
    var enginesAmount: String = ""
    var fuelEmount: String = ""
    var burningTime: String = ""
    var thrust: String = ""
}

struct LandingLegsModel {
    var amount: String = ""
    var material: String = ""
}

class Rocket2ViewController: UIViewController {
    
    
    enum RocketSection: Int {
        case titleImage = 0
        case description
        case overview
        case images
        case engines
        case firstStage
        case secondStage
        case landingLegs
        case materials
    }
    
    enum OverviewSection: Int {
        case firstLaunch = 0, launchCost, success, mass, height, diameter
    }
    
    enum EnginesSection: Int {
        case type = 0, layout, version, amount, propellant1, propellant2
    }
    
    enum FirstStageSection: Int {
        case reusable = 0, enginesAmount, fuelAmount, burningTime, thrustSeaLevel, thrustVacuum
    }
    
    enum SecondStageSection: Int {
        case reusable = 0, enginesAmount, fuelEmount, burningTime, thrust
    }
    
    enum LandingLegsSection: Int {
        case amount = 0, material
    }
    
    let backButton = UIButton(frame: .zero)
    var index = Int()
    
    let activityIndicator = UIActivityIndicatorView()
    
    var searcRocket: [SearchResponse]? = nil
    let rocketService = NetworkService()
    
    var rocketCollectionView = UICollectionView(frame: .zero, collectionViewLayout:       UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var mainImageCell = MainImageModel()
    var descriptionCell = DescriptionModel()
    var imageCell = ImageModel()
    var overValueCell = OverviewModel()
    var enginesValueCell = EnginesModel()
    var firstStageValueCell = FirstStageModel()
    var secondStageValueCell = SecondStageModel()
    var landingLegsCell = LandingLegsModel()
    
    let overviewName = ["First Launch", "Launch Cost", "Success", "Mass", "Height", "Diameter"]
    
    let enginesNames = ["Type", "Layout", "Version", "Amount", "Propellant 1", "Propellant 2"]
    let firstStageNames = ["Reusable", "Engines Amount", "Fuel Emount", "Burning Time", "Thrust (sea level)", "Thrust (vacuum)"]
    let secondStageNames = ["Reusable", "Engines Amount", "Fuel Emount", "Burning Time", "Thrust"]
    var landingLegsNames = ["Amount", "Material"]
    
    var wikipediaURLString = String()
    
    let collectionViewHeaderReuseIdentifier = "HeaderCollectionReusableView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateRocketDataFromServer()
    }
    
    func updateRocketDataFromServer() {
        let urlString = "https://api.spacexdata.com/v4/rockets"
        rocketService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let searchResponse):
                self?.searcRocket = searchResponse
                self?.mainImageCell = MainImageModel(name: searchResponse[self!.index].name, image: searchResponse[self!.index].flickrImages.first ?? "Placeholder")
                self?.descriptionCell = DescriptionModel(descriptionLabel: "Description", descriptionText: searchResponse[self!.index].description)
                self?.imageCell = ImageModel(imageString: searchResponse[self!.index].flickrImages)
                self?.overValueCell = OverviewModel(firstLaunch: searchResponse[self!.index].firstFlight, launchCost: "\(searchResponse[self!.index].costPerLaunch)$", success: "\(searchResponse[self!.index].successRatePct)%", mass: "\(searchResponse[self!.index].mass.kg) kg", height: "\(searchResponse[self!.index].height.meters) meters", diameter: "\(searchResponse[self!.index].diameter.meters) meters")
                self?.enginesValueCell = EnginesModel(type: searchResponse[self!.index].engines.type, layout: searchResponse[self!.index].engines.layout ?? "", version: searchResponse[self!.index].engines.version ?? "", amount: "\(searchResponse[self!.index].engines.number)", propellant1: searchResponse[self!.index].engines.propellantOne, propellant2: searchResponse[self!.index].engines.propellantTwo)
                self?.firstStageValueCell = FirstStageModel(reusable: "\(searchResponse[self!.index].firstStage.reusable)", enginesAmount: "\(searchResponse[self!.index].firstStage.engines)", fuelAmount: "\(searchResponse[self!.index].firstStage.fuelAmountTons) tons", burningTime: "\(searchResponse[self!.index].firstStage.burnTimeSec ?? 0) seconds", thrustSeaLevel: "\(searchResponse[self!.index].firstStage.thrustSeaLevel.kN) kN", thrustVacuum: "\(searchResponse[self!.index].firstStage.thrustVacuum.kN) kN")
                self?.secondStageValueCell = SecondStageModel(reusable: "\(searchResponse[self!.index].secondStage.reusable)", enginesAmount: "\(searchResponse[self!.index].secondStage.engines)", fuelEmount: "\(searchResponse[self!.index].secondStage.fuelAmountTons) tons", burningTime: "\(searchResponse[self!.index].secondStage.burnTimeSec ?? 0) seconds", thrust: "\(searchResponse[self!.index].secondStage.thrust.kN)kN")
                self?.landingLegsCell = LandingLegsModel(amount: "\(searchResponse[self!.index].landingLegs.number)", material: searchResponse[self!.index].landingLegs.material ?? "")
                self?.wikipediaURLString = searchResponse[self!.index].wikipedia
                self?.rocketCollectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "White")
        setupNavigationBar()
        setupActivityIndicator()
        setupCollectionView()
        setupBackButton()
        setupLayoutRocket()
    }
    
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
    }
    
    func setupBackButton() {
        backButton.setImage(UIImage(named: "keyboardLeft"), for: .normal)
        backButton.tintColor = UIColor(named: "Coral")
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
    }
    
    func setupCollectionView() {
        rocketCollectionView.register(TitleImageCollectionViewCell.self, forCellWithReuseIdentifier: TitleImageCollectionViewCell.reusedId)
        rocketCollectionView.register(DescriptionCollectionViewCell.self, forCellWithReuseIdentifier: DescriptionCollectionViewCell.reusedId)
        rocketCollectionView.register(NameValueCollectionViewCell.self, forCellWithReuseIdentifier: NameValueCollectionViewCell.reusedId)
        rocketCollectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reusedId)
        rocketCollectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.reusedId)
        rocketCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderReuseIdentifier)
        layout.scrollDirection = .vertical
        rocketCollectionView.setCollectionViewLayout(layout, animated: true)
        rocketCollectionView.delegate = self
        rocketCollectionView.dataSource = self
        rocketCollectionView.backgroundColor = UIColor.clear
        layout.minimumLineSpacing = 15
        view.addSubview(rocketCollectionView)
        rocketCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayoutRocket() {
        NSLayoutConstraint.activate([
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            rocketCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            rocketCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rocketCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rocketCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - UICollectionViewDelegate
extension Rocket2ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - UICollectionViewDataSource
extension Rocket2ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var items = 0
        if let currentNumberOfSection = RocketSection(rawValue: section) {
            switch currentNumberOfSection {
                
            case .titleImage:
                items = 1
            case .description:
                items = 1
            case .overview:
                items = OverviewSection.diameter.rawValue + 1
            case .images:
                items = 1
            case .engines:
                items = EnginesSection.propellant2.rawValue + 1
            case .firstStage:
                items = FirstStageSection.thrustVacuum.rawValue + 1
            case .secondStage:
                items =  SecondStageSection.thrust.rawValue + 1
            case .landingLegs:
                items = LandingLegsSection.material.rawValue + 1
            case .materials:
                items = 1
            }
        }
        return items
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return RocketSection.materials.rawValue + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = rocketCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderReuseIdentifier, for: indexPath) as! HeaderCollectionReusableView
        if let currentNameOfSection = RocketSection(rawValue: indexPath.section) {
            switch currentNameOfSection {
            case .titleImage:
                headerView.headerName.text = ""
            case .description:
                headerView.headerName.text = "Description"
            case .overview:
                headerView.headerName.text = "Overview"
            case .images:
                headerView.headerName.text = "Images"
            case .engines:
                headerView.headerName.text = "Engines"
            case .firstStage:
                headerView.headerName.text = "First stage"
            case .secondStage:
                headerView.headerName.text = "Second stage"
            case .landingLegs:
                headerView.headerName.text = "Landing legs"
            case .materials:
                headerView.headerName.text = "Materials"
            }
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: view.frame.width, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == RocketSection.titleImage.rawValue {
            let cell = rocketCollectionView.dequeueReusableCell(withReuseIdentifier: TitleImageCollectionViewCell.reusedId, for: indexPath) as! TitleImageCollectionViewCell
            cell.nameRocket.text = mainImageCell.name
            let string = mainImageCell.image
            if let image = rocketService.getImage(from: string) {
                cell.rocketImage.image = image
            }
            return cell
        } else if indexPath.section == RocketSection.description.rawValue {
            let cell = rocketCollectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCollectionViewCell.reusedId, for: indexPath) as! DescriptionCollectionViewCell
            cell.descriptionText.text = descriptionCell.descriptionText
            return cell
        } else if indexPath.section == RocketSection.overview.rawValue {
            let cell = rocketCollectionView.dequeueReusableCell(withReuseIdentifier: NameValueCollectionViewCell.reusedId, for: indexPath) as! NameValueCollectionViewCell
            cell.name.text = overviewName[indexPath.row]
            if let currentOverviewCell = OverviewSection(rawValue: indexPath.row) {
                
                switch currentOverviewCell {
                case .firstLaunch:
                    cell.value.text = overValueCell.firstLaunch
                case .launchCost:
                    cell.value.text = overValueCell.launchCost
                case .success:
                    cell.value.text = overValueCell.success
                case .mass:
                    cell.value.text = overValueCell.mass
                case .height:
                    cell.value.text = overValueCell.height
                case .diameter:
                    cell.value.text = overValueCell.diameter
                }
            }
            return cell
        } else if indexPath.section == RocketSection.images.rawValue {
            let cell = rocketCollectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reusedId, for: indexPath) as! ImagesCollectionViewCell
            cell.imageString = imageCell.imageString
            cell.imagesCollectionView.reloadData()
            guard let customCell = cell as? ImagesCollectionViewCell else { fatalError("Unable to dequeue expected type: CustomTableViewCell") }
                customCell.delegate = self
                return customCell
        } else if indexPath.section == RocketSection.engines.rawValue {
            let cell = rocketCollectionView.dequeueReusableCell(withReuseIdentifier: NameValueCollectionViewCell.reusedId, for: indexPath) as! NameValueCollectionViewCell
            cell.name.text = enginesNames[indexPath.row]
            if let currentEnginesCell = EnginesSection(rawValue: indexPath.row) {
                switch currentEnginesCell {
                case .type:
                    cell.value.text = enginesValueCell.type
                case .layout:
                    cell.value.text = enginesValueCell.layout
                case .version:
                    cell.value.text = enginesValueCell.version
                case .amount:
                    cell.value.text = enginesValueCell.amount
                case .propellant1:
                    cell.value.text = enginesValueCell.propellant1
                case .propellant2:
                    cell.value.text = enginesValueCell.propellant2
                }
            }
            return cell
        } else if indexPath.section == RocketSection.firstStage.rawValue {
            let cell = rocketCollectionView.dequeueReusableCell(withReuseIdentifier: NameValueCollectionViewCell.reusedId, for: indexPath) as! NameValueCollectionViewCell
            cell.name.text = firstStageNames[indexPath.row]
            if let currentFirstStageCell = FirstStageSection(rawValue: indexPath.row) {
                switch currentFirstStageCell {
                    
                case .reusable:
                    cell.value.text = firstStageValueCell.reusable
                case .enginesAmount:
                    cell.value.text = firstStageValueCell.enginesAmount
                case .fuelAmount:
                    cell.value.text = firstStageValueCell.fuelAmount
                case .burningTime:
                    cell.value.text = firstStageValueCell.burningTime
                case .thrustSeaLevel:
                    cell.value.text = firstStageValueCell.thrustSeaLevel
                case .thrustVacuum:
                    cell.value.text = firstStageValueCell.thrustVacuum
                }
            }
            return cell
        } else if indexPath.section == RocketSection.secondStage.rawValue {
            let cell = rocketCollectionView.dequeueReusableCell(withReuseIdentifier: NameValueCollectionViewCell.reusedId, for: indexPath) as! NameValueCollectionViewCell
            cell.name.text = secondStageNames[indexPath.row]
            if let currentSecondStageCell = SecondStageSection(rawValue: indexPath.row) {
                switch currentSecondStageCell {
                    
                case .reusable:
                    cell.value.text = secondStageValueCell.reusable
                case .enginesAmount:
                    cell.value.text = secondStageValueCell.enginesAmount
                case .fuelEmount:
                    cell.value.text = secondStageValueCell.fuelEmount
                case .burningTime:
                    cell.value.text = secondStageValueCell.burningTime
                case .thrust:
                    cell.value.text = secondStageValueCell.thrust
                }
            }
            return cell
        } else if indexPath.section == RocketSection.landingLegs.rawValue {
            let cell = rocketCollectionView.dequeueReusableCell(withReuseIdentifier: NameValueCollectionViewCell.reusedId, for: indexPath) as! NameValueCollectionViewCell
            cell.name.text = landingLegsNames[indexPath.row]
            if let currentLandingLegsCell = LandingLegsSection(rawValue: indexPath.row) {
                switch currentLandingLegsCell {
                    
                case .amount:
                    cell.value.text = landingLegsCell.amount
                case .material:
                    cell.value.text = landingLegsCell.material
                }
            }
            return cell
        } else {
            let cell = rocketCollectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.reusedId, for: indexPath) as! ButtonCollectionViewCell
            cell.linkButton.setTitle("Wikipedia", for: .normal)
            cell.linkButton.addTarget(self, action: #selector(wikipediaButtonTapped(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func wikipediaButtonTapped(_ sender: UIButton) {
        let webKitViewController = WebKitViewController()
        webKitViewController.urlString = wikipediaURLString
        webKitViewController.mainName = mainImageCell.name
        navigationController?.pushViewController(webKitViewController, animated: true)
        navigationController?.isNavigationBarHidden = false
        print("button tapped")
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension Rocket2ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var heightOfRow = CGSize(width: 0, height: 0)
        if let currentNumberOfSection = RocketSection(rawValue: indexPath.section) {
            switch currentNumberOfSection {
                
            case .titleImage:
                heightOfRow = CGSize(width: view.frame.width, height: 383)
            case .description:
                heightOfRow = CGSize(width: view.frame.width, height: 120)
            case .images:
                heightOfRow = CGSize(width: view.frame.width, height: 190)
            case .materials:
                heightOfRow = CGSize(width: view.frame.width, height: 40)
            default:
                heightOfRow = CGSize(width: view.frame.width, height: 20)
            }
        }
        return heightOfRow
    }
}

extension Rocket2ViewController: CustomCollectionViewCellDelegate {
    func showDetailRocket(for cell: ImagesCollectionViewCell) {
        guard let indexPath = rocketCollectionView.indexPath(for: cell) else { return }
        let detailRocketViewController = DetailRocketViewController()
        detailRocketViewController.detailRocketString = imageCell.imageString[indexPath.row]
        navigationController?.pushViewController(detailRocketViewController, animated: true)
    }
}


