//
//  ContactListCell.swift
//  CloseUp
//
//  Created by Maksim Torburg on 18.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class ContactListCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ContactListCell"
    
    let avatar = UIImageView()
    let name = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillData(with contact: Contact) {
        self.clipsToBounds = true
        self.autoresizesSubviews = true
        self.backgroundColor = .white
        self.layer.cornerRadius = 20

        avatar.image = UIImage(named: "face")
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = self.frame.height * 0.8 / 2

        self.addSubview(avatar)

        name.text = contact.name
        name.font = .systemFont(ofSize: 18, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)

        let constraints = [
            avatar.widthAnchor.constraint(equalTo: avatar.heightAnchor),
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            avatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),

            name.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 50),
            name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 30),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
}
