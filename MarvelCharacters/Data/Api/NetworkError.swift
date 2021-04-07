//
//  NetworkError.swift
//  MarvelCharacters
//
//  Created by Hasan on 08.04.21.
//

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}
