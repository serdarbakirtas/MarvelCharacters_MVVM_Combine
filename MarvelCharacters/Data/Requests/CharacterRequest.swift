//
//  CharacterRequest.swift
//  MarvelCharacters
//
//  Created by Hasan on 08.04.21.
//

import Foundation

public enum CharacterRequestType {
    case characters
}

struct CharacterRequest: APIRequestType {
    
    typealias Response = Marvel
    
    var apiRepo: CharacterRequestType
    
    init(apiRepo: CharacterRequestType) {
        self.apiRepo = apiRepo
    }
    
    func path() -> String {
        switch apiRepo {
        case .characters:
            return "characters"
        }
    }
    
    func method() -> HTTPMethod {
        switch apiRepo {
        case .characters:
            return .get
        }
    }
    
    func query() -> [URLQueryItem]? {
        switch apiRepo {
        case .characters:
            let queryItems = [URLQueryItem(name: "apikey", value: "86fffd66696e825988a8507a4eeba7bf"),
                              URLQueryItem(name: "ts", value: "1"),
                              URLQueryItem(name: "hash", value: "eab17e843356c02bde6992456692b586")]
            return queryItems
        }
    }
}
