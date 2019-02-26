//
//  SearchFilm.swift
//  FilmList
//
//  Created by Axel Imberdis on 26/02/2019.
//  Copyright © 2019 Kukana. All rights reserved.
//

import Foundation

class Found : Decodable
{
    var vote_average: Float
    var title: String
    var overview: String
}

class Search : Decodable
{
    var total_results: Int
    var results: [Found]
}
