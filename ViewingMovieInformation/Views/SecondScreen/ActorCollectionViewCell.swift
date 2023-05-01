//
//  CollectionViewCell.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 07.03.2023.
//

import SDWebImage
import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    static let identifier = "ActorCollectionViewCell"
    private let labelName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 33
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        contentView.addSubview(labelName)
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configureActorsCell(name: String, image: String) {
        labelName.text = name
        guard let url = URL(string: "\(image)") else { return }
        posterImageView.sd_setImage(with: url)
    }
}

extension ActorCollectionViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            labelName.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 0),
            labelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelName.heightAnchor.constraint(equalToConstant: 30)])
    }
}
