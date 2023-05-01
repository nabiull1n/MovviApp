//
//  HomeScreenStructuret.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 07.03.2023.
//

import Foundation

struct HomeScreenStructuret: Decodable {
    let items: [Item]?
    let errorMessage: String?
}

struct Item: Decodable {
    let id, rank, title, fullTitle: String?
    let year: String?
    let image: String?
    let crew, imDBRating, imDBRatingCount: String?

    enum CodingKeys: String, CodingKey {
        case id, rank, title, fullTitle, year, image, crew
        case imDBRating = "imDbRating"
        case imDBRatingCount = "imDbRatingCount"
    }
}
