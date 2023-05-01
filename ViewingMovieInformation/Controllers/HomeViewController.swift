//
//  ViewController.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 11.02.2023.
//

import UIKit

enum Sections: Int {
    case popularMovies = 0
    case popularTVSeries = 1
    case top250Movies = 2
}

class HomeViewController: UIViewController {

    private let sectionTitlesArray: [String] = ["Popular Movies", "Popular TV Series", "Top 250 Movies"]
    private var isTransitionInProgress = false

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movve"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next Bold", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifer)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
// MARK: - setupViews HomeViewController
    private func setupViews() {
        view.backgroundColor = Resources.Colors.basicBackgroundColor
        view.addSubview(titleLabel)
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        setupNavigationController()
        setConstraints()
    }
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = UIColor.lightGray
        navigationItem.backButtonTitle = ""
    }
}
// MARK: - extension HomeViewController: UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitlesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifer,
                                                       for: indexPath) as? CollectionViewTableViewCell
                                                                    else { return UITableViewCell()}
        cell.delegate = self
        switch indexPath.section {
        case Sections.popularMovies.rawValue:
            HomeNetworkRequest.shared.popularMoviesRequest { result in
                switch result {
                case .success(let result):
                    let array = result
                    let shortArray = Array(array.prefix(10))
                    cell.confiqureTop(image: shortArray)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.popularTVSeries.rawValue:
            HomeNetworkRequest.shared.popularTVSeriesRequest { result in
                switch result {
                case .success(let result):
                    let array = result
                    let shortArray = Array(array.prefix(10))
                    cell.confiqureTop(image: shortArray)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.top250Movies.rawValue:
            HomeNetworkRequest.shared.top250Request { result in
                switch result {
                case .success(let result):
                    let array = result
                    let shortArray = Array(array.prefix(10))
                    cell.confiqureTop(image: shortArray)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        header.textLabel?.textColor = .white
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitlesArray[section]
    }
}
// MARK: - Constraints HomeViewController
private extension HomeViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            homeTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTap(_ cell: CollectionViewTableViewCell, viewModel: TitileViewModel) {
        guard !isTransitionInProgress else { return }
        isTransitionInProgress = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isTransitionInProgress = false
        }
        DispatchQueue.main.async { [weak self] in
            let secondVC = SecondViewController()
            secondVC.assignment(with: viewModel)
            self?.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}
