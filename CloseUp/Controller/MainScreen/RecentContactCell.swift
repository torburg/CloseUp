//
//  ContactCell.swift
//  CloseUp
//
//  Created by Maksim Torburg on 03.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class RecentContactCell: UICollectionViewCell {

    var avatar = UIImageView()

    var name = UILabel()

    static let reuseIdentifier = "RecentContactCell"

    func fillData(with contact: Contact) {

        self.clipsToBounds = true
        self.autoresizesSubviews = true

        avatar.image = UIImage(named: "face")
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true
        // FIXME: Fix to computed size of parent view to make corenrRadius round
        avatar.layer.cornerRadius = 25
        self.addSubview(avatar)

        name.text = contact.name
        name.font = .systemFont(ofSize: 12.5)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)

        let constraints = [
            avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatar.topAnchor.constraint(equalTo: self.topAnchor),
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            avatar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            avatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),

            name.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            name.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 5),
        ]

        NSLayoutConstraint.activate(constraints)

//        self.contentView.backgroundColor = UIColor(red: getColor(), green: getColor(), blue: getColor(), alpha: 1)
    }
}
