//
//  Film.swift
//  FilmList
//
//  Created by Axel Imberdis on 21/02/2019.
//  Copyright © 2019 Kukana. All rights reserved.
//

import Foundation

class Film : Decodable
{
    var vote_average: Float
    var title: String
    var overview: String
}

class Films : Decodable
{
    var items: [Film]
}
