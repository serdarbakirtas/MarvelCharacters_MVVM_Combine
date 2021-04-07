//
//  CharacterCell.swift
//  MarvelCharacters
//
//  Created by Hasan on 08.04.21.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    // MARK: - UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - PROPERTIES
    let CONSTANT: CGFloat = 8
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryType = .disclosureIndicator
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(line)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CONSTANT),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: CONSTANT),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            line.leftAnchor.constraint(equalTo: self.leftAnchor, constant: CONSTANT),
            line.rightAnchor.constraint(equalTo: self.rightAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            line.heightAnchor.constraint(equalToConstant: 1)
          ])
    }

    func populateCell(with characterListViewModel: CharactersItemViewModel) {
        titleLabel.text = characterListViewModel.name
    }
}
