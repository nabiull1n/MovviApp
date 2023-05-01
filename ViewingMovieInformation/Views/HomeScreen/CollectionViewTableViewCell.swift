//
//  CollectionViewTableViewCell.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 15.02.2023.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTap(_ cell: CollectionViewTableViewCell, viewModel: TitileViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    weak var delegate: CollectionViewTableViewCellDelegate?
    static let identifer = "CollectionViewTableViewCell"
    private var imageTopArray: [Item?] = [Item]()
    private let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 280)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.sectionInset.left = 15
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentMode = .scaleAspectFill
        collection.register(MoviesCollectionViewCell.self,
                            forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(moviesCollectionView)
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        moviesCollectionView.frame = contentView.bounds
    }

    public func confiqureTop(image: [Item]) {
        self.imageTopArray = image
        DispatchQueue.main.async { [weak self] in
            self?.moviesCollectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier,
                                                            for: indexPath) as? MoviesCollectionViewCell
                                                            else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        cell.clipsToBounds = true
        guard let poster = imageTopArray[indexPath.item]?.image,
              let date = imageTopArray[indexPath.item]?.year,
              let title = imageTopArray[indexPath.item]?.title else { return UICollectionViewCell() }
        cell.configureMoviesCell(poster: poster, name: title, date: date)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageTopArray.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let section = imageTopArray[indexPath.row]?.id else { return }
        MovieInformationNetRequest.shared.actorsRequest(id: section, completion: { [weak self] result in
            switch result {
            case .success(let movie):
                let array = [ActorList]()
                let countries = movie.countries ?? ""
                let viewModel = TitileViewModel(id: movie.id!, title: movie.title ?? "", year: movie.year ?? "",
                                                image: movie.image ?? "", releaseDate: movie.releaseDate ?? "",
                                                runtimeStr: movie.runtimeStr ?? countries,
                                                plot: movie.plot ?? "", plotLocal: movie.plotLocal ?? "",
                                                actorList: movie.actorList ?? array,
                                                genres: movie.genres ?? "", countries: movie.countries ?? "",
                                                ratings: movie.ratings!)
                guard let strongSelf = self else { return }
                self!.delegate?.collectionViewTableViewCellDidTap(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
