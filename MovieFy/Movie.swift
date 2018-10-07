//
//  Movie.swift
//  MovieFy
//
//  Created by Tommy Tran on 07/10/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import Foundation

class Movie{
    var title: String
    var overview: String
    var posterUrl: URL?
    var releaseDate: String
    var backDropUrl: URL?
    
    
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as! String
        releaseDate = dictionary["release_date"] as! String
        let posterPath = dictionary["poster_path"] as? String
        if let posterPath = posterPath {
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            let fullPosterPath = baseUrlString + posterPath
            let posterUrl = URL(string: fullPosterPath)
            if posterUrl != nil {
                self.posterUrl = posterUrl
            }
        }
        let backDropPath = dictionary["backdrop_path"] as? String
        if let backDropPath = backDropPath{
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            let fullPosterPath = baseUrlString + backDropPath
            let posterUrl = URL(string: fullPosterPath)
            if posterUrl != nil {
                self.backDropUrl = posterUrl
            }
        }
        
    }
    
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
