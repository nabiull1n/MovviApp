//
//  MoviesCollectionViewCell.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 01.03.2023.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {
    static let identifier = "MoviesCollectionViewCell"
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        setConstraints()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    public func configureMoviesCell(poster: String, name: String, date: String) {
        nameLabel.text = name
        dateLabel.text = date
        guard let url = URL(string: "\(poster)") else { return }
        posterImageView.sd_setImage(with: url)
    }
}

extension MoviesCollectionViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            nameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 36),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)])
    }
}
