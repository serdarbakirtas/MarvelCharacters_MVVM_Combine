//
//  CharacterListVC.swift
//  MarvelCharacters
//
//  Created by Hasan on 08.04.21.
//

import UIKit

protocol MarvelCharactersViewModelOutput: class {}

class CharacterListVC: UIViewController {
    
    // MARK: UI
    private lazy var contentView = CharacterListView()
    
    private var viewModel: CharacterListViewModel<CharacterListVC>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CharacterListViewModel(view: self)
        viewModel.apply(.onAppear)
        
        view = contentView
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        viewModel.$charactersItemViewModel.receive(on: RunLoop.main).sink { [weak self] response in
            guard let self = self else { return }
            self.contentView.tableView.reloadData()
        }.store(in: &viewModel.cancellables)
    }
}

// MARK: View
extension CharacterListVC: MarvelCharactersViewModelOutput {}

// MARK: Tableview Delegate and DataSource
extension CharacterListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CharacterListVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.populateCell(with: viewModel.charactersItemViewModel[indexPath.row])
        return cell
    }
}
