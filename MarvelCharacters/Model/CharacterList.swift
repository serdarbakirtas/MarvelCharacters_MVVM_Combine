//
//  CharacterList.swift
//  MarvelCharacters
//
//  Created by Hasan on 08.04.21.
//

import Foundation

struct Marvel: Decodable {
    var code: Int
    var data: MarvelData
}

struct MarvelData: Decodable {
    var results: [CharacterList]
}

struct CharacterList: Decodable {
    var name: String
    var id: Int
}
