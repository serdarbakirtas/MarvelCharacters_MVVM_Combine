//
//  CharactersItemViewModel.swift
//  MarvelCharacters
//
//  Created by Hasan on 08.04.21.
//

import Foundation
import UIKit

struct CharactersItemViewModel {
    
    var name: String?
    
    init(from items: CharacterList) {
        name = getCharacterName(items: items)
    }
        
    func getCharacterName(items: CharacterList) -> String {
        return items.name
    }
}
