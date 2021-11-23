//
//  LaunchesViewController.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 27.09.2021.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    var launchesindex = Int()
    var mainName = String()
    
    let launchNetworkService = LaunchNetworkingService()
    var launchSearcResponce: [LaunchSearchResponse]? = nil
    
    var image = UIImageView(frame: .zero)
    var imageString = String()
    var name = UILabel(frame: .zero)
    var date = UILabel(frame: .zero)
    var check = UIImageView(frame: .zero)
    var number = UILabel(frame: .zero)
    var subnumber = UIView(frame: .zero)
    
    var descriptionLabel = UILabel(frame: .zero)
    var descriptionText = UILabel(frame: .zero)
    
    var overviewLabel = UILabel(frame: .zero)
    var overViewStackName = UIStackView(frame: .zero)
    var overViewStackValue = UIStackView(frame: .zero)
    var horizontalStackForOverView = UIStackView()
    let overviewNames = ["Static fire date", "Launch date", "Success"]
    var overviewValueStaticFireDate = UILabel(frame: .zero)
    var overviewValueLaunchDate = UILabel(frame: .zero)
    var overviewValueSuccess = UILabel(frame: .zero)
    
    var imagesLabel = UILabel(frame: .zero)
    
    var launcesImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    var launchImageString = [String]()
    
    var rocketLabel = UILabel(frame: .zero)
    var materialsLabel = UILabel(frame: .zero)
    var wikipediaButton = UIButton(frame: .zero)
    var youtubeButton = UIButton(frame: .zero)
    
    var redditLabel = UILabel(frame: .zero)
    var recoveryButton = UIButton(frame: .zero)
    var mediaButton = UIButton(frame: .zero)
    var campaignButton = UIButton(frame: .zero)
    var launchButton = UIButton(frame: .zero)
    
    lazy var scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.translatesAutoresizingMaskIntoConstraints = false
            scroll.delegate = self
            return scroll
        }()
    
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
        launchNetworkService.request(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let launchSearchResponse):
                self?.launchSearcResponce = launchSearchResponse
                self?.launcesImageCollectionView.reloadData()
                self?.name.text = launchSearchResponse[self!.launchesindex].name
                self?.date.text = launchSearchResponse[self!.launchesindex].dateUtc
                self?.number.text = "#" + String(launchSearchResponse[self!.launchesindex].flightNumber)
                self?.imageString = launchSearchResponse[self!.launchesindex].links.patch.small ?? "Placeholder"
                self?.descriptionText.text = launchSearchResponse[self!.launchesindex].details
                self?.overviewValueStaticFireDate.text = launchSearchResponse[self!.launchesindex].staticFireDateUtc
                self?.overviewValueLaunchDate.text = launchSearchResponse[self!.launchesindex].dateUtc
                if launchSearchResponse[self!.launchesindex].success == false {
                    self?.overviewValueSuccess.text = "No"
                } else {
                    self?.overviewValueSuccess.text = "Yes"
                }
                self?.launchImageString = launchSearchResponse[self!.launchesindex].links.flickr.original!
                self?.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "White")
        setupNavigationBar()
        setupScrollView()
        setupName()
        setupDate()
        setupCheck()
        setupNumber()
        setupSubnumber()
        setupImage()
        setupLabels()
        setupTextDescription()
        setupHorizontalStack()
        setupOverViewStack()
        setupOverViewStackValue()
        setupLaunchImageCollectionView()
        setupButtons()
        setupLayoutLaunches()
    }
    
    func setupNavigationBar() {
        navigationItem.title = mainName
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "roboto-bold", size: 24)!, .foregroundColor: UIColor(named: "White") ?? UIColor.white]
        navigationController!.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor(named: "Coral")
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
 
    func setupDate() {
        date.font = UIFont(name: "roboto-medium", size: 17)
        date.tintColor = UIColor(named: "Smoky Black")
        date.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(date)
    }
    
    func setupCheck() {
        check.image = UIImage(named: "checkmark")
        check.tintColor = UIColor(named: "Cyan Process")
        check.layer.shadowRadius = 3
        check.layer.shadowOpacity = 0.5
        check.layer.shadowOffset = CGSize(width: 2, height: 2)
        check.backgroundColor = UIColor(named: "White")
        check.layer.cornerRadius = 16
        check.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(check)
    }
    
    func setupSubnumber() {
        subnumber.layer.shadowColor = UIColor(named: "Smoky Black")?.cgColor
        subnumber.layer.shadowRadius = 3
        subnumber.layer.shadowOpacity = 0.5
        subnumber.layer.shadowOffset = CGSize(width: 2, height: 2)
        subnumber.backgroundColor = UIColor(named: "White")
        subnumber.layer.cornerRadius = 10
        subnumber.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(subnumber)
    }
    
    func setupNumber() {
        number.font = UIFont(name: "roboto-medium", size: 17)
        number.textColor = UIColor(named: "Cyan Process")
        number.layer.cornerRadius = 16
        number.clipsToBounds = true
        number.textAlignment = .center
        number.backgroundColor = UIColor(named: "White")
        number.translatesAutoresizingMaskIntoConstraints = false
        subnumber.addSubview(number)
    }
    
    func setupImage() {
        image.clipsToBounds = true
        image.backgroundColor = UIColor(named: "White")
        image.layer.cornerRadius = 16
        image.layer.shadowRadius = 3
        image.layer.shadowOpacity = 0.5
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(image)
    }
    
    func setupLabels() {
        descriptionLabel = labelStyle(title: "Description")
        overviewLabel = labelStyle(title: "Overview")
        imagesLabel = labelStyle(title: "Images")
        rocketLabel = labelStyle(title: "Rocket")
        materialsLabel = labelStyle(title: "Materials")
        redditLabel = labelStyle(title: "Reddit")
    }
    
    func setupTextDescription() {
        descriptionText.font = UIFont(name: "roboto-medium", size: 14)
        descriptionText.textColor = UIColor(named: "Smoky Black")
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.numberOfLines = 0
        scrollView.addSubview(descriptionText)
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
        overviewValueStaticFireDate = labelValueStyle()
        overViewStackValue.addArrangedSubview(overviewValueStaticFireDate)
        overviewValueLaunchDate = labelValueStyle()
        overViewStackValue.addArrangedSubview(overviewValueLaunchDate)
        overviewValueSuccess = labelValueStyle()
        overViewStackValue.addArrangedSubview(overviewValueSuccess)
        horizontalStackForOverView.addArrangedSubview(overViewStackValue)
    }
    
    func setupLaunchImageCollectionView() {
        launcesImageCollectionView.register(LaunchesImageCollectionViewCell.self, forCellWithReuseIdentifier: LaunchesImageCollectionViewCell.reusedId)
        layout.scrollDirection = .horizontal
        launcesImageCollectionView.setCollectionViewLayout(layout, animated: true)
        launcesImageCollectionView.delegate = self
        launcesImageCollectionView.dataSource = self
        launcesImageCollectionView.backgroundColor = UIColor(named: "White")
        layout.minimumLineSpacing = 30
        launcesImageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        scrollView.addSubview(launcesImageCollectionView)
        launcesImageCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupButtons() {
        wikipediaButton = buttonStyle(title: "Wikipedia")
        youtubeButton = buttonStyle(title: "Youtube")
        recoveryButton = buttonStyle(title: "Recovery")
        mediaButton = buttonStyle(title: "Media")
        campaignButton = buttonStyle(title: "Campaign")
        launchButton = buttonStyle(title: "Launch")
    }
    
    func setupLayoutLaunches() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            name.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15),
            date.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            check.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 21),
            check.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            check.heightAnchor.constraint(equalToConstant: 30),
            check.widthAnchor.constraint(equalToConstant: 30),
            
            subnumber.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 21),
            subnumber.leadingAnchor.constraint(equalTo: check.trailingAnchor, constant: 10),
            subnumber.widthAnchor.constraint(equalToConstant: 70),
            
            number.widthAnchor.constraint(equalToConstant: 59),
            number.heightAnchor.constraint(equalToConstant: 32),
            
            image.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.topAnchor.constraint(equalTo: check.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            overviewLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 30),
            overviewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            horizontalStackForOverView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            horizontalStackForOverView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            imagesLabel.topAnchor.constraint(equalTo: horizontalStackForOverView.bottomAnchor, constant: 30),
            imagesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            launcesImageCollectionView.topAnchor.constraint(equalTo: imagesLabel.bottomAnchor,constant: 20),
            launcesImageCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            launcesImageCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            launcesImageCollectionView.heightAnchor.constraint(equalToConstant: 190),
            
            rocketLabel.topAnchor.constraint(equalTo: launcesImageCollectionView.bottomAnchor, constant: 30),
            rocketLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            materialsLabel.topAnchor.constraint(equalTo: rocketLabel.bottomAnchor, constant: 30),
            materialsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            wikipediaButton.topAnchor.constraint(equalTo: materialsLabel.bottomAnchor, constant: 20),
            wikipediaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            wikipediaButton.heightAnchor.constraint(equalToConstant: 32),
            wikipediaButton.widthAnchor.constraint(equalToConstant: 117),
            
            youtubeButton.topAnchor.constraint(equalTo: materialsLabel.bottomAnchor, constant: 20),
            youtubeButton.leadingAnchor.constraint(equalTo: wikipediaButton.trailingAnchor, constant: 15),
            youtubeButton.heightAnchor.constraint(equalToConstant: 32),
            youtubeButton.widthAnchor.constraint(equalToConstant: 106),
            
            redditLabel.topAnchor.constraint(equalTo: wikipediaButton.bottomAnchor, constant: 30),
            redditLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            recoveryButton.topAnchor.constraint(equalTo: redditLabel.bottomAnchor, constant: 20),
            recoveryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recoveryButton.heightAnchor.constraint(equalToConstant: 32),
            recoveryButton.widthAnchor.constraint(equalToConstant: 113),
            
            mediaButton.topAnchor.constraint(equalTo: redditLabel.bottomAnchor, constant: 20),
            mediaButton.leadingAnchor.constraint(equalTo: recoveryButton.trailingAnchor, constant: 15),
            mediaButton.heightAnchor.constraint(equalToConstant: 32),
            mediaButton.widthAnchor.constraint(equalToConstant: 91),
            
            campaignButton.topAnchor.constraint(equalTo: redditLabel.bottomAnchor, constant: 20),
            campaignButton.leadingAnchor.constraint(equalTo: mediaButton.trailingAnchor, constant: 15),
            campaignButton.heightAnchor.constraint(equalToConstant: 32),
            campaignButton.widthAnchor.constraint(equalToConstant: 120),
            
            launchButton.topAnchor.constraint(equalTo: redditLabel.bottomAnchor, constant: 20),
            launchButton.leadingAnchor.constraint(equalTo: campaignButton.trailingAnchor, constant: 15),
            launchButton.heightAnchor.constraint(equalToConstant: 32),
            launchButton.widthAnchor.constraint(equalToConstant: 120),
            launchButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
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
        stackViewStyle.spacing = 48
        stackViewStyle.translatesAutoresizingMaskIntoConstraints = false
        return stackViewStyle
    }
    
    func buttonStyle(title: String) -> UIButton {
        let buttonStyle = UIButton()
        buttonStyle.setTitle(title, for: .normal)
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
        scrollView.addSubview(buttonStyle)
        return buttonStyle
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
    
    func updateUI() {
        if let image = getImage(from: imageString) {
            self.image.image = image
        }
    }
}

//MARK: - UIScrollViewDelegate
extension LaunchesViewController: UIScrollViewDelegate {
    
}

// MARK: - UICollectionViewDelegate
extension LaunchesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - UICollectionViewDataSource
extension LaunchesViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return launchSearcResponce?[self.launchesindex].links.flickr.original?.count ?? 0
//            return launchSearcResponce?[self.index].flickrImages.count ?? 0
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = launcesImageCollectionView.dequeueReusableCell(withReuseIdentifier: LaunchesImageCollectionViewCell.reusedId, for: indexPath) as! LaunchesImageCollectionViewCell
            let string = launchImageString[indexPath.row]
            if let image = getImage(from: string) {
                cell.launchImage.image = image
        }
            return cell
        }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LaunchesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 139, height: launcesImageCollectionView.frame.height)
        }
}

