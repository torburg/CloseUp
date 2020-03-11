//
//  RecentViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 03.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit
import CoreData

class RecentViewController: UIView {

    var contacts = [Contact]()

    var fetchResultsController = CoreDataManager.instance.fetchResultsController(entityName: "Contact", keySort: "updatedDate")
    
    func setData() {
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            print(error)
        }
    }
}
extension RecentViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = fetchResultsController.sections,
            sections[section].numberOfObjects != 0 {
            return sections[section].numberOfObjects
        }

        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell", for: indexPath)
        guard let cell = dequedCell as? ContactCell else {
            print("Can't create reusable Cell")
            return dequedCell
        }
        cell.label.textColor = .black
        if validateIndexPath(indexPath) {
            guard let contact = fetchResultsController.object(at: indexPath) as? Contact else {
                print("Can't fetch object from FetchResultController by indexPath = \(indexPath)")
                return cell
            }
            cell.label.text = contact.name
            cell.contentView.backgroundColor = UIColor(red: getColor(), green: getColor(), blue: getColor(), alpha: 1)
            return cell
        }
        cell.label.text = "Create"
        return cell
    }
    
    func validateIndexPath(_ indexPath: IndexPath) -> Bool {
        if let sections = fetchResultsController.sections,
        indexPath.section < sections.count {
           if indexPath.row < sections[indexPath.section].numberOfObjects {
              return true
           }
        }
        return false
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
