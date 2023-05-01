//
//  SecondScreenStructure.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 12.03.2023.
//

import Foundation

struct SecondScreenStructure: Decodable {
    let id, title: String?
    let year: String?
    let image: String?
    let releaseDate: String?
    let runtimeStr: String?
    let plot: String?
    let plotLocal: String?
    let actorList: [ActorList]?
    let genres: String?
    let countries: String?
    let ratings: Ratings?
}

struct ActorList: Decodable {
    let id: String?
    let image: String?
    let name, asCharacter: String?
}

struct CountryListElement: Decodable {
    let key, value: String?
}

struct Ratings: Decodable {
    let imDBID, title, fullTitle, type: String?
    let year, imDB, metacritic, theMovieDB: String?
    let rottenTomatoes, filmAffinity, errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case imDBID = "imDbId"
        case title, fullTitle, type, year
        case imDB = "imDb"
        case metacritic
        case theMovieDB = "theMovieDb"
        case rottenTomatoes, filmAffinity, errorMessage
    }
}
