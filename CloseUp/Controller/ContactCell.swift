//
//  ContactCell.swift
//  CloseUp
//
//  Created by Maksim Torburg on 03.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class ContactCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
        label.text = nil
    }
}
