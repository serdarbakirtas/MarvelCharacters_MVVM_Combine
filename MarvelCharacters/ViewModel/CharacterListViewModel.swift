//
//  CharacterListViewModel.swift
//  MarvelCharacters
//
//  Created by Hasan on 08.04.21.
//

import UIKit
import Combine

class CharacterListViewModel: CharacterListViewModelOutput {
    
    // MARK: Input
    enum Input {
        case onAppear
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            onAppearSubject.send()
        }
    }
    
    var cancellables: [AnyCancellable] = []
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let responseSubject = PassthroughSubject<Marvel, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let apiService: APIServiceType = APIService()
    
    // MARK: Output
    @Published var charactersItemViewModel: [CharactersItemViewModel] = []
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init() {
        bindInputs()
        bindOutputs()
    }
    
    // MARK: Input - ApiCalls
    private func bindInputs() {
        let responsePublisher = onAppearSubject.flatMap { [apiService] query in
            apiService.response(from: CharacterRequest(apiRepo: .characters))
                .catch { [weak self] error -> Empty<Marvel, Never> in
                    self?.errorSubject.send(error)
                    return .init()
                }
            }
        
        let responseStream = responsePublisher.share().subscribe(responseSubject)
        cancellables += [ responseStream ]
    }
    
    // MARK: Output
    private func bindOutputs() {
        let characterListStream = responseSubject.map { $0 }.sink { _ in }
            receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.charactersItemViewModel = response.data.results.map { CharactersItemViewModel(from: $0) }
            }

        let errorMessageStream = errorSubject.map { error -> String in
            print("parse error", error)
            switch error {
            case .responseError:
                return "network error"
            case .parseError:
                return "parse error"
            }
            }.assign(to: \.errorMessage, on: self)

        let errorStream = errorSubject.map { _ in true }.assign(to: \.isErrorShown, on: self)
        cancellables += [ characterListStream, errorStream, errorMessageStream ]
    }
    
    // MARK: Functions
    func getListCount() -> Int {
        return charactersItemViewModel.count
    }
}
