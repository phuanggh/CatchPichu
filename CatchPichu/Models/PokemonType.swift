//
//  PokemonType.swift
//  CatchPichu
//
//  Created by Penny Huang on 2020/3/24.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import Foundation

struct PokemonType: Equatable {
    let name: String
    let score: Int
    let appearTime: Float
}

struct Pokemon: Equatable {
    static let pichu = PokemonType(name: "pichu", score: 1, appearTime: Float.random(in: 2...4))
    static let pikachu = PokemonType(name: "pikachu", score: 3,  appearTime: Float.random(in: 1.5 ... 2.5))
    static let raichu = PokemonType(name: "raichu", score: 5,  appearTime: 1)
}


