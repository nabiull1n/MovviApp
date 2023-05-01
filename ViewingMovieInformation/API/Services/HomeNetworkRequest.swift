//
//  HomeNetworkRequest.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 14.02.2023.
//

import Foundation

struct Constants {
    static let baseURL = "https://imdb-api.com/en/API/"
    static let kay = "/k_5h8mc6xp"
}
class HomeNetworkRequest {
    static let shared = HomeNetworkRequest()
// MARK: - Popular Movies request
    func popularMoviesRequest (completion: @escaping (Result<[Item], Error>) -> Void) {
        let url = URL(string: "\(Constants.baseURL)MostPopularMovies\(Constants.kay)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            if let popularData = try? JSONDecoder().decode(HomeScreenStructuret.self, from: data) {
                completion(.success(popularData.items!))
            }
        }
        task.resume()
    }
// MARK: - Popular TV Series request
    func popularTVSeriesRequest (completion: @escaping (Result<[Item], Error>) -> Void) {
        let url = URL(string: "\(Constants.baseURL)MostPopularTVs\(Constants.kay)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            if let top10Data = try? JSONDecoder().decode(HomeScreenStructuret.self, from: data) {
                completion(.success(top10Data.items!))
            }
        }
        task.resume()
    }
// MARK: - Top 250 Movies request
    func top250Request (completion: @escaping (Result<[Item], Error>) -> Void) {
        let url = URL(string: "\(Constants.baseURL)Top250Movies\(Constants.kay)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            if let top10Data = try? JSONDecoder().decode(HomeScreenStructuret.self, from: data) {
                completion(.success(top10Data.items!))
            }
        }
        task.resume()
    }
}
