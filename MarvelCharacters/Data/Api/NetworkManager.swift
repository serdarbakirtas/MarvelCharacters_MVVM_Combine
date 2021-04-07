//
//  NetworkManager.swift
//  MarvelCharacters
//
//  Created by Hasan on 08.04.21.
//

import Combine
import Foundation

protocol APIRequestType {
    associatedtype Response: Decodable

    func path() -> String
    func method() -> HTTPMethod
    func query() -> [URLQueryItem]?
}

protocol APIServiceType {
    func response<Request>(from request: Request) ->
    AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
}

final class APIService: APIServiceType {

    private let baseURL: URL
    
    init(baseURL: URL = URL(string: "https://gateway.marvel.com/v1/public/")!) {
        self.baseURL = baseURL
    }

    func response<Request>(from request: Request) ->
    AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType {
        let pathURL = URL(string: request.path(), relativeTo: baseURL)!
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.query()
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method().rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        let decorder = JSONDecoder()
        decorder.dateDecodingStrategy = .iso8601
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { data, _ in data }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: Request.Response.self, decoder: decorder)
            .mapError(APIServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
