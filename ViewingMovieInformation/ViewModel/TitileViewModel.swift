//
//  TitileViewModel.swift
//  ViewingMovieInformation
//
//  Created by Денис Набиуллин on 09.03.2023.
//

struct TitileViewModel {
    let id, title: String
    let year: String
    let image: String
    let releaseDate: String
    let runtimeStr: String
    let plot: String
    let plotLocal: String
    var actorList: [ActorList]
    let genres: String
    let countries: String
    let ratings: Ratings
}
