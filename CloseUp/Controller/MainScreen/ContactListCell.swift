//
//  TableCell.swift
//  CloseUp
//
//  Created by Maksim Torburg on 18.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class ContactListCell: UITableViewCell {
    
    static let reuseIdentifier = "ContactListCell"
    
    let avatar = UIImageView()
    let name = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(with contact: Contact) {
        print(#function)
        self.clipsToBounds = true
        self.autoresizesSubviews = true

        avatar.image = UIImage(named: "face")
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true

        // FIXME: Delete magic multiplier in size and corering
        avatar.layer.cornerRadius = self.frame.height * 0.8 / 2
        self.addSubview(avatar)

        name.text = contact.name
        name.font = .systemFont(ofSize: 18, weight: .bold)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)

        let constraints = [
            avatar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            avatar.widthAnchor.constraint(equalTo: avatar.heightAnchor),
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            name.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 50),
            name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 30),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
}
