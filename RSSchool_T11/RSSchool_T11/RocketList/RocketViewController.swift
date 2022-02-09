////
////  RocketVC.swift
////  RSSchool_T11
////
////  Created by Татьяна Лузанова on 15.09.2021.
////
//
//import UIKit
//
//class RocketViewController: UIViewController {
//    
//    let backButton = UIButton(frame: .zero)
//    var index = Int()
//    var searcRocket: [SearchResponse]? = nil
//    let rocketService = NetworkService()
//    var mainImage = UIImage()
//    var imageView = UIImageView()
//    var imageString = [String]()
//    var name = UILabel(frame: .zero)
//    var descriptionLabel = UILabel(frame: .zero)
//    var textDescription = UILabel(frame: .zero)
//    var overView = UILabel(frame: .zero)
//    var overViewStackName = UIStackView(frame: .zero)
//    var horizontalStackForOverView = UIStackView()
//    
//    let overviewNames = ["First Launch", "Launch Cost", "Success", "Mass", "Height", "Diameter"]
//    var overviewValueFirstLaunch = UILabel(frame: .zero)
//    var overviewValueLaunchCost = UILabel(frame: .zero)
//    var overviewValueSuccess = UILabel(frame: .zero)
//    var overviewValueMass = UILabel(frame: .zero)
//    var overviewValueHeight = UILabel(frame: .zero)
//    var overviewValueDiameter = UILabel(frame: .zero)
////    var overviewValue: [String] = []
////    var overviewValue = OverviewModel()
//    var overViewStackValue = UIStackView(frame: .zero)
//    
//    var imagesLabel = UILabel(frame: .zero)
//    var imagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
//    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
//    
//    var engines = UILabel(frame: .zero)
//    var enginesStackName = UIStackView(frame: .zero)
//    var horizontalStackForEngines = UIStackView()
//    let enginesNames = ["Type", "Layout", "Version", "Amount", "Propellant 1", "Propellant 2"]
//    var enginesValue = [String]()
//    var enginesStackValue = UIStackView(frame: .zero)
//    
//    var firstStage = UILabel(frame: .zero)
//    var firstStageStackName = UIStackView(frame: .zero)
//    var horizontalStackForFirstStage = UIStackView()
//    let firstStageNames = ["Reusable", "Engines Amount", "Fuel Emount", "Burning Time", "Thrust (sea level)", "Thrust (vacuum)"]
//    var firstStageValue = [String]()
//    var firstStageStackValue = UIStackView(frame: .zero)
//    
//    var secondStage = UILabel(frame: .zero)
//    var secondStageStackName = UIStackView(frame: .zero)
//    var horizontalStackForSecondStage = UIStackView()
//    let secondStageNames = ["Reusable", "Engines Amount", "Fuel Emount", "Burning Time", "Thrust"]
//    var secondStageValue = [String]()
//    var secondStageStackValue = UIStackView(frame: .zero)
//
//    var landingLegs = UILabel(frame: .zero)
//    var landingLegsStackName = UIStackView(frame: .zero)
//    var horizontalStackForlandingLegs = UIStackView()
//    var landingLegsNames = ["Amount", "Material"]
//    var landingLegsValue = [String]()
//    var landingLegsStackValue = UIStackView(frame: .zero)
//
//    var materials = UILabel(frame: .zero)
//    
//    var wikipediaButton = UIButton(frame: .zero)
//    var wikipediaURLString = String()
//    
//    lazy var scrollView: UIScrollView = {
//            let scroll = UIScrollView()
//            scroll.translatesAutoresizingMaskIntoConstraints = false
//            scroll.delegate = self
//            return scroll
//        }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        updateRocketDataFromServer()
//    }
//    
//    func updateRocketDataFromServer() {
//        let urlString = "https://api.spacexdata.com/v4/rockets"
//        rocketService.request(urlString: urlString) { [weak self] (result) in
//            switch result {
//            case .success(let searchResponse):
//                self?.searcRocket = searchResponse
//                self?.imagesCollectionView.reloadData()
//                self?.name.text = searchResponse[self!.index].name
//                self?.imageString = searchResponse[self!.index].flickrImages
//                self?.textDescription.text = searchResponse[self!.index].description
////                это я пыталасб сделать новый массив как в предыдущем контроллере
////                self?.overviewValue = searchResponse.map{
////                    OverviewModel(firstLaunch: $0.firstFlight, launchCost: "\($0.costPerLaunch)", success: "\($0.successRatePct)", mass: "\($0.mass.kg)", height: "\($0.height.meters)", diameter: "\($0.diameter.meters)")
////                }
////                вот еще попытка
////                self?.overviewValue = OverviewModel(firstLaunch: searchResponse[self!.index].firstFlight, launchCost: "\(searchResponse[self!.index].costPerLaunch)", success: "\(searchResponse[self!.index].successRatePct)", mass: "\(searchResponse[self!.index].mass.kg)", height: "\(searchResponse[self!.index].height.meters)", diameter: "\(searchResponse[self!.index].diameter.meters)")
//                
//                self?.overviewValueFirstLaunch.text = searchResponse[self!.index].firstFlight
//                self?.overviewValueLaunchCost.text = String(searchResponse[self!.index].costPerLaunch) + " $"
//                self?.overviewValueSuccess.text = String(searchResponse[self!.index].successRatePct) + "%"
//                self?.overviewValueMass.text = String(searchResponse[self!.index].mass.kg) + " kg"
//                self?.overviewValueHeight.text = String(searchResponse[self!.index].height.meters) + " meters"
//                self?.overviewValueDiameter.text = String(searchResponse[self!.index].diameter.meters) + " meters"
//                
//                
////                вот так было
////                self?.overviewValue.append(searchResponse[self!.index].firstFlight)
////                self?.overviewValue.append(String(searchResponse[self!.index].costPerLaunch) + "$")
////                self?.overviewValue.append(String(searchResponse[self!.index].successRatePct) + "%")
////                self?.overviewValue.append(String(searchResponse[self!.index].mass.kg) + " kg")
////                self?.overviewValue.append(String(searchResponse[self!.index].height.meters) + " meters")
////                self?.overviewValue.append(String(searchResponse[self!.index].diameter.meters) + " meters")
//                self?.wikipediaURLString = searchResponse[self!.index].wikipedia
//                self?.updateUI()
//            case .failure(let error):
//                print(error)
//            }
//        }
//        print(index)
//
//    }
//    
//    func setupUI() {
//        setupNavigationBar()
//        setupScrollView()
//        setupImageView()
//        setupName()
//        setupLabels()
//        setupTextDescription()
//        setupHorizontalStack()
//        setupOverViewStack()
//        setupOverViewStackValue()
//        setupImagesCollectionView()
//        setupEnginesStack()
//        setupEnginesStackValue()
//        setupFirstStageStack()
//        setupSecondStageStack()
//        setupLandingLegsStack()
//        setupButtons()
//        setupBackButton()
//        setupLayoutRocket()
//    }
//    
//    func setupNavigationBar() {
//        navigationController?.isNavigationBarHidden = true
//        tabBarController?.tabBar.isHidden = true
//        
//    }
//    
//    func setupBackButton() {
//        backButton.setImage(UIImage(named: "keyboardLeft"), for: .normal)
//        backButton.tintColor = UIColor(named: "Coral")
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
//        view.addSubview(backButton)
//        
//    }
//    
//    func setupScrollView() {
//        scrollView.backgroundColor = UIColor(named: "White")
//        scrollView.bringSubviewToFront(backButton)
//        view.addSubview(scrollView)
//    }
//    
//    func setupImageView() {
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.isUserInteractionEnabled = true
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = imageView.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.alpha = 0.3
//        imageView.addSubview(blurEffectView)
//        scrollView.addSubview(imageView)
//    }
//    
//    func setupName() {
//        name.font = UIFont(name: "roboto-bold", size: 48)
//        name.translatesAutoresizingMaskIntoConstraints = false
//        name.textColor = UIColor(named: "White")
//        imageView.addSubview(name)
//    }
//    
//    func setupLabels() {
//        descriptionLabel = labelStyle(title: "Description")
//        overView = labelStyle(title: "OverView")
//        imagesLabel = labelStyle(title: "Images")
//        engines = labelStyle(title: "Engines")
//        firstStage = labelStyle(title: "First Stage")
//        secondStage = labelStyle(title: "Second Stage")
//        landingLegs = labelStyle(title: "Landing legs")
//        materials = labelStyle(title: "Materials")
//    }
//    
//    func setupTextDescription() {
//        textDescription.font = UIFont(name: "roboto-medium", size: 14)
//        textDescription.textColor = UIColor(named: "Smoky Black")
//        textDescription.translatesAutoresizingMaskIntoConstraints = false
//        textDescription.numberOfLines = 0
//        scrollView.addSubview(textDescription)
//    }
//    
//    func setupHorizontalStack() {
//        horizontalStackForOverView = horStackViewStyle()
//        scrollView.addSubview(horizontalStackForOverView)
//        horizontalStackForEngines = horStackViewStyle()
//        scrollView.addSubview(horizontalStackForEngines)
//        horizontalStackForFirstStage = horStackViewStyle()
//        scrollView.addSubview(horizontalStackForFirstStage)
//        horizontalStackForSecondStage = horStackViewStyle()
//        scrollView.addSubview(horizontalStackForSecondStage)
//        horizontalStackForlandingLegs = horStackViewStyle()
//        scrollView.addSubview(horizontalStackForlandingLegs)
//    }
//    
//    func setupOverViewStack() {
//        overViewStackName = vertStackViewStyle()
//      
//        overviewNames.forEach({let label = labelStyle(title: $0)
//        label.textColor = UIColor(named: "Smoky Black")
//        label.font = UIFont(name: "roboto-medium", size: 14)
//        overViewStackName.addArrangedSubview(label)
//        })
//
//        horizontalStackForOverView.addArrangedSubview(overViewStackName)
//    }
//    
//    func setupOverViewStackValue() {
//        overViewStackValue = vertStackViewStyle()
//        overviewValueFirstLaunch = labelValueStyle()
//        overViewStackValue.addArrangedSubview(overviewValueFirstLaunch)
//        overviewValueLaunchCost = labelValueStyle()
//        overViewStackValue.addArrangedSubview(overviewValueLaunchCost)
//        overviewValueSuccess = labelValueStyle()
//        overViewStackValue.addArrangedSubview(overviewValueSuccess)
//        overviewValueMass = labelValueStyle()
//        overViewStackValue.addArrangedSubview(overviewValueMass)
//        overviewValueHeight = labelValueStyle()
//        overViewStackValue.addArrangedSubview(overviewValueHeight)
//        overviewValueDiameter = labelValueStyle()
//        overViewStackValue.addArrangedSubview(overviewValueDiameter)
//        horizontalStackForOverView.addArrangedSubview(overViewStackValue)
//        
//    }
//    
//    func setupImagesCollectionView() {
//        imagesCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reusedId)
//        layout.scrollDirection = .horizontal
//        imagesCollectionView.setCollectionViewLayout(layout, animated: true)
//        imagesCollectionView.delegate = self
//        imagesCollectionView.dataSource = self
//        imagesCollectionView.backgroundColor = UIColor(named: "White")
//        layout.minimumLineSpacing = 30
//        imagesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        scrollView.addSubview(imagesCollectionView)
//        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
//    }
//    
//    func setupEnginesStack() {
//        enginesStackName = vertStackViewStyle()
//        enginesNames.forEach({
//            let label = labelStyle(title: $0)
//            label.textColor = UIColor(named: "Smoky Black")
//            label.font = UIFont(name: "roboto-medium", size: 14)
//            enginesStackName.addArrangedSubview(label)
//        })
//
//        horizontalStackForEngines.addArrangedSubview(enginesStackName)
//    }
//    
//    func setupEnginesStackValue() {
//        enginesStackValue = vertStackViewStyle()
//
//        enginesValue.forEach({
//            let value = labelStyle(title: $0)
//            value.textColor = UIColor(named: "Slate Gray")
//            value.font = UIFont(name: "roboto-medium", size: 14)
//            enginesStackValue.addArrangedSubview(value)
//        })
//     
//        horizontalStackForEngines.addArrangedSubview(enginesStackValue)
//    }
//    
//    func setupFirstStageStack() {
//        firstStageStackName = vertStackViewStyle()
//      
//        firstStageNames.forEach({
//            let label = labelStyle(title: $0)
//            label.textColor = UIColor(named: "Smoky Black")
//            label.font = UIFont(name: "roboto-medium", size: 14)
//            firstStageStackName.addArrangedSubview(label)
//        })
//
//        horizontalStackForFirstStage.addArrangedSubview(firstStageStackName)
//    }
//    
//    func setupSecondStageStack() {
//        secondStageStackName = vertStackViewStyle()
//      
//        secondStageNames.forEach({
//            let label = labelStyle(title: $0)
//            label.textColor = UIColor(named: "Smoky Black")
//            label.font = UIFont(name: "roboto-medium", size: 14)
//            secondStageStackName.addArrangedSubview(label)
//        })
//
//        horizontalStackForSecondStage.addArrangedSubview(secondStageStackName)
//    }
//    
//    func setupLandingLegsStack() {
//        landingLegsStackName = vertStackViewStyle()
//      
//        landingLegsNames.forEach({
//            let label = labelStyle(title: $0)
//            label.textColor = UIColor(named: "Smoky Black")
//            label.font = UIFont(name: "roboto-medium", size: 14)
//            landingLegsStackName.addArrangedSubview(label)
//        })
//
//        horizontalStackForlandingLegs.addArrangedSubview(landingLegsStackName)
//    }
//    
//    func setupButtons() {
//        wikipediaButton = buttonStyle(title: "Wikipedia")
//        wikipediaButton.addTarget(self, action: #selector(wikipediaButtonTapped(_:)), for: .touchUpInside)
//        scrollView.addSubview(wikipediaButton)
//    }
//
//    func setupLayoutRocket() {
//        NSLayoutConstraint.activate([
//
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -48),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 44),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            
//            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
//            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//
//            name.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 297),
//            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            imageView.heightAnchor.constraint(equalToConstant: 383),
//            
//            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
//            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            textDescription.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
//            textDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            textDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
//
//            overView.topAnchor.constraint(equalTo: textDescription.bottomAnchor, constant: 30),
//            overView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            horizontalStackForOverView.topAnchor.constraint(equalTo: overView.bottomAnchor, constant: 20),
//            horizontalStackForOverView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            imagesLabel.topAnchor.constraint(equalTo: horizontalStackForOverView.bottomAnchor, constant: 30),
//            imagesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            imagesCollectionView.topAnchor.constraint(equalTo: imagesLabel.bottomAnchor,constant: 20),
//            imagesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            imagesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            imagesCollectionView.heightAnchor.constraint(equalToConstant: 190),
//            
//            engines.topAnchor.constraint(equalTo: imagesCollectionView.bottomAnchor, constant: 30),
//            engines.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            horizontalStackForEngines.topAnchor.constraint(equalTo: engines.bottomAnchor, constant: 20),
//            horizontalStackForEngines.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            firstStage.topAnchor.constraint(equalTo: horizontalStackForEngines.bottomAnchor, constant: 30),
//            firstStage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            horizontalStackForFirstStage.topAnchor.constraint(equalTo: firstStage.bottomAnchor, constant: 20),
//            horizontalStackForFirstStage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            secondStage.topAnchor.constraint(equalTo: horizontalStackForFirstStage.bottomAnchor, constant: 30),
//            secondStage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            horizontalStackForSecondStage.topAnchor.constraint(equalTo: secondStage.bottomAnchor, constant: 20),
//            horizontalStackForSecondStage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            landingLegs.topAnchor.constraint(equalTo: horizontalStackForSecondStage.bottomAnchor, constant: 30),
//            landingLegs.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            horizontalStackForlandingLegs.topAnchor.constraint(equalTo: landingLegs.bottomAnchor, constant: 20),
//            horizontalStackForlandingLegs.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            materials.topAnchor.constraint(equalTo: horizontalStackForlandingLegs.bottomAnchor, constant: 30),
//            materials.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            
//            wikipediaButton.topAnchor.constraint(equalTo: materials.bottomAnchor, constant: 20),
//            wikipediaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            wikipediaButton.heightAnchor.constraint(equalToConstant: 32),
//            wikipediaButton.widthAnchor.constraint(equalToConstant: 117),
//            wikipediaButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
//        ])
//    }
//    
//    func labelStyle(title: String) -> UILabel {
//        let labelStyle = UILabel()
//        labelStyle.text = title
//        labelStyle.font = UIFont(name: "roboto-bold", size: 24)
//        labelStyle.textColor = UIColor(named: "Smoky Black")
//        labelStyle.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(labelStyle)
//        return labelStyle
//    }
//    
//    func labelValueStyle() -> UILabel {
//        let labelStyle = UILabel()
//        labelStyle.font = UIFont(name: "roboto-bold", size: 14)
//        labelStyle.textColor = UIColor(named: "Slate Gray")
//        labelStyle.translatesAutoresizingMaskIntoConstraints = false
//        return labelStyle
//    }
//    
//    func vertStackViewStyle() -> UIStackView {
//        let stackViewStyle = UIStackView()
//        stackViewStyle.axis = .vertical
//        stackViewStyle.distribution = .fillEqually
//        stackViewStyle.spacing = 15
//        stackViewStyle.translatesAutoresizingMaskIntoConstraints = false
//        return stackViewStyle
//    }
//    
//    func horStackViewStyle() -> UIStackView {
//        let stackViewStyle = UIStackView()
//        stackViewStyle.axis = .horizontal
//        stackViewStyle.distribution = .fillEqually
//        stackViewStyle.spacing = 48
//        stackViewStyle.translatesAutoresizingMaskIntoConstraints = false
//        return stackViewStyle
//    }
//    
//    func buttonStyle(title: String) -> UIButton {
//        let buttonStyle = UIButton()
//        buttonStyle.setTitle(title, for: .normal)
//        buttonStyle.setImage(UIImage(named: "link"), for: .normal)
//        buttonStyle.tintColor = UIColor(named: "Coral")
//        buttonStyle.titleLabel?.font = UIFont(name: "roboto-medium", size: 17)!
//        buttonStyle.setTitleColor(UIColor(named: "Coral"), for: .normal)
//        buttonStyle.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
//        buttonStyle.semanticContentAttribute = .forceRightToLeft
//        buttonStyle.backgroundColor = UIColor(named: "White")
//        buttonStyle.layer.cornerRadius = 16
//        buttonStyle.layer.shadowRadius = 3
//        buttonStyle.layer.shadowOpacity = 0.5
//        buttonStyle.layer.shadowOffset = CGSize(width: 2, height: 2)
//        buttonStyle.translatesAutoresizingMaskIntoConstraints = false
//        return buttonStyle
//    }
//    
//    func getImage(from string: String) -> UIImage? {
//        guard let url = URL(string: string)
//            else {
//                print("Unable to create URL")
//                return nil
//        }
//        var image: UIImage? = nil
//        do {
//            let data = try Data(contentsOf: url, options: [])
//            image = UIImage(data: data)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//        return image
//    }
//    
//    func updateUI() {
//        if let image = getImage(from: imageString.first!) {
//            mainImage = image
//            imageView.image = mainImage
//            
//        }
//    }
//    
//    @objc func backButtonTapped(_ sender: UIButton) {
//        navigationController?.popToRootViewController(animated: true)
//        tabBarController?.tabBar.isHidden = false
//        navigationController?.isNavigationBarHidden = false
//    }
//    
//    @objc func wikipediaButtonTapped(_ sender: UIButton) {
//        let webKitViewController = WebKitViewController()
//        webKitViewController.urlString = wikipediaURLString
//        navigationController?.pushViewController(webKitViewController, animated: true)
//        print("button tapped")
//    }
//}
//
////MARK: - UIScrollViewDelegate
//extension RocketViewController: UIScrollViewDelegate {
//    
//}
//
//// MARK: - UICollectionViewDelegate
//extension RocketViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let test = DetailRocketViewController()
////        test.index = indexPath.row
////                self.navigationController?.pushViewController(rocketVC, animated: true)
//    }
//}
//
//// MARK: - UICollectionViewDataSource
//extension RocketViewController: UICollectionViewDataSource {
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return searcRocket?[self.index].flickrImages.count ?? 0
//        }
//
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reusedId, for: indexPath) as! ImageCollectionViewCell
//            let string = imageString[indexPath.row]
//            if let image = getImage(from: string) {
//            cell.rocketImage.image = image
//        }
//            return cell
//        }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension RocketViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 139, height: imagesCollectionView.frame.height)
//        }
//}
