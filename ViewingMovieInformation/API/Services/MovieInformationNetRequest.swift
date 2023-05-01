//
//  MovieInformationNetRequest.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 07.03.2023.
//

import Foundation

class MovieInformationNetRequest {
    static let shared = MovieInformationNetRequest()
// MARK: - request for the second screen
    func actorsRequest (id: String, completion: @escaping (Result<SecondScreenStructure, Error>) -> Void) {
        let url = URL(string: "https://imdb-api.com/ru/API/Title/k_5h8mc6xp/\(id)/FullActor,Ratings," )!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            if let popularData = try? JSONDecoder().decode(SecondScreenStructure.self, from: data) {
                completion(.success(popularData))
            }
        }
        task.resume()
    }
}
