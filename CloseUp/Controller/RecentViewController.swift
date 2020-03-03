//
//  RecentViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 03.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class RecentViewController: UIView {

    var contacts = [String]()
    
    func setData() {
        
        var contacts = [String]()
        for i in 1...10 {
            contacts.append("Contact \(i)")
        }
        self.contacts = contacts
    }
}
extension RecentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell", for: indexPath)
        guard let cell = dequedCell as? ContactCell else {
            print("Can't create reusable Cell")
            return dequedCell
        }
        cell.label.text = contacts[indexPath.row]
        cell.label.textColor = .white
//        cell.contentView.backgroundColor = .white
        cell.contentView.backgroundColor = UIColor(red: getColor(), green: getColor(), blue: getColor(), alpha: 1)
        return cell
    }
    
    
}

extension RecentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70.0, height: 70.0)
    }
}

func getColor() -> CGFloat{
    return CGFloat(arc4random_uniform(256)) / 255.0
}
