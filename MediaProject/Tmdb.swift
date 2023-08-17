//
//  Tmdb.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/17.
//

import Foundation


class TmdbListData{
    
    static let shared = TmdbListData()
    
    struct MovieListData: Codable {
        let page: Int
        let results: [Result]
        let totalPages, totalResults: Int
        
        enum CodingKeys: String, CodingKey {
            case page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
    }
    
    struct Result: Codable {
        
        let backdropPath: String
        let id: Int
        let title: String
        let overview, posterPath: String
        let genreIDS: [Int]
        let releaseDate: String
        
        enum CodingKeys: String, CodingKey {
            
            case backdropPath = "backdrop_path"
            case id, title
            case overview
            case posterPath = "poster_path"
            case genreIDS = "genre_ids"
            case releaseDate = "release_date"
        }
    }
}


class TmdbDetailData{
    
    static let shared = TmdbDetailData()
    
    struct MovieDetail: Codable {
        let id: Int
        let cast, crew: [Profile]
    }

    struct Profile: Codable {
       
        let name: String
        let profilePath: String?
        let character: String?
        let job: String?

        enum CodingKeys: String, CodingKey {
            case name
            case profilePath = "profile_path"
            case character, job
        }
    }
}
