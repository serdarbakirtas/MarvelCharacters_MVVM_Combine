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
        contentView.addSubview(titleLabel)
        contentView.addSubview(line)
        
        layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CONSTANT),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CONSTANT),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CONSTANT),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CONSTANT),
            
            line.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CONSTANT),
            line.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            line.heightAnchor.constraint(equalToConstant: 1)
          ])
    }

    func populateCell(with characterListViewModel: CharactersItemViewModel) {
        titleLabel.text = characterListViewModel.name
    }
}
