//
//  SecondViewController.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 04.03.2023.
//

import UIKit
import Cosmos

class SecondViewController: UIViewController {
    private var imageSetArray: [ActorList] = [ActorList]()
    private var idMovie = ""
    private var isActive = false
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .darkGray
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        cosmosView.settings.totalStars = 5
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.updateOnTouch = false
        return cosmosView
    }()
    private let saveButton: CustomButton = {
        let button = CustomButton(systemName: "bookmark")
        return button
    }()
    private let notSaveButton: CustomButton = {
        let button = CustomButton(systemName: "bookmark.fill")
        return button
    }()
     private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir Next Bold", size: 45)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let actorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 105)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.sectionInset.left = 15
        layout.sectionInset.right = 15
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentMode = .scaleAspectFill
        collection.register(ActorCollectionViewCell.self,
                             forCellWithReuseIdentifier: ActorCollectionViewCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    private lazy var watchNowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Watch Now", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Resources.Colors.watchNouButtonColor
        button.setTitleColor(.lightGray, for: .selected)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(watchNowClick), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        installationButton()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGradient(startColor: UIColor.clear, endColor: Resources.Colors.basicBackgroundColor)
    }
    @objc func watchNowClick() {
        if let url = URL(string: "https://www.imdb.com/title/\(idMovie)/") {
                UIApplication.shared.open(url)
        }
    }

    @objc func saveButtonTappet() {
        if UserDefaults.standard.string(forKey: idMovie) == idMovie || isActive != false {
        let userDefault = UserDefaults.standard
            userDefault.removeObject(forKey: "\(idMovie)")
            let setButton = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
            let largeBoldDoc = UIImage(systemName: "bookmark", withConfiguration: setButton)
            notSaveButton.setImage(largeBoldDoc, for: .normal)
            saveButton.setImage(largeBoldDoc, for: .normal)
            isActive = false
        } else {
            let userDefault = UserDefaults.standard
            userDefault.set(idMovie, forKey: "\(idMovie)")
            let setButton = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
            let largeBoldDoc = UIImage(systemName: "bookmark.fill", withConfiguration: setButton)
            saveButton.setImage(largeBoldDoc, for: .normal)
            isActive = true
        }
    }
    private func installationButton() {
        if UserDefaults.standard.string(forKey: idMovie) == idMovie {
            let addButton = UIBarButtonItem(customView: notSaveButton)
            navigationItem.rightBarButtonItem = addButton
            notSaveButton.addTarget(self, action: #selector(saveButtonTappet), for: .touchUpInside)
        } else {
            let addButton = UIBarButtonItem(customView: saveButton)
            navigationItem.rightBarButtonItem = addButton
            saveButton.addTarget(self, action: #selector(saveButtonTappet), for: .touchUpInside)
        }
    }
// MARK: - setupViews HomeViewController
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1568627451, blue: 0.2078431373, alpha: 1)
        view.addSubview(posterImageView)
        posterImageView.addSubview(titleLabel)
        posterImageView.addSubview(dataLabel)
        view.addSubview(cosmosView)
        view.addSubview(descriptionLabel)
        view.addSubview(castLabel)
        view.addSubview(actorsCollectionView)
        view.addSubview(watchNowButton)
        setConstraints()
        actorsCollectionView.delegate = self
        actorsCollectionView.dataSource = self
    }
    private func setGradient(startColor: UIColor, endColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = posterImageView.bounds
        posterImageView.layer.insertSublayer(gradient, at: 0)
    }
    func assignment (with model: TitileViewModel) {
        titleLabel.text = model.title
        idMovie = model.id
        let array = model.actorList
        imageSetArray = Array(array.prefix(10))
        let duration = model.runtimeStr
        dataLabel.text = "\(model.year) • \(model.genres) • \(duration)"
        let cosmosRating = Double(model.ratings.imDB ?? "") ?? 0.0
        cosmosView.rating = cosmosRating * 0.5
        cosmosView.text = model.ratings.imDB ?? ""
        descriptionLabel.text = model.plotLocal
        guard let url = URL(string: model.image) else { return }
        posterImageView.sd_setImage(with: url, placeholderImage: nil, options: [.highPriority])
    }
}
// MARK: - extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource
extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageSetArray.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.identifier,
                                                            for: indexPath) as? ActorCollectionViewCell
                                                            else { return UICollectionViewCell() }
        guard let modelPhotos = imageSetArray[indexPath.item].image  else { return UICollectionViewCell() }
        guard let modelNames = imageSetArray[indexPath.item].name else { return UICollectionViewCell() }
        cell.configureActorsCell( name: modelNames, image: modelPhotos)
        return cell
    }
}
// MARK: - Constraints SecondViewController
private extension SecondViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            posterImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 300),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -20),
            dataLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            dataLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 10),
            dataLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -10),
            dataLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 0),
            cosmosView.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 6),
            cosmosView.bottomAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 22),
            cosmosView.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: cosmosView.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            castLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 0),
            castLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            castLabel.heightAnchor.constraint(equalToConstant: 24),
            actorsCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 2),
            actorsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actorsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actorsCollectionView.heightAnchor.constraint(equalToConstant: 110),
            watchNowButton.topAnchor.constraint(equalTo: actorsCollectionView.bottomAnchor, constant: 10),
            watchNowButton.heightAnchor.constraint(equalToConstant: 35),
            watchNowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
            watchNowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -130)])
    }
}
