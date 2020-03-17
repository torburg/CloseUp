//
//  RecentViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 03.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit
import CoreData

class RecentViewController: UICollectionViewController {

    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Contact",
                                                                                 sortBy: "updatedDate",
                                                                                 sortDirectionAsc: false)
    
    func setData() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
}
extension RecentViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections,
            sections[section].numberOfObjects != 0 {
            return sections[section].numberOfObjects
        }

        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequedCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCell.reuseIdentifier, for: indexPath)
        guard let cell = dequedCell as? ContactCell else {
            print("Can't create reusable Cell")
            return dequedCell
        }
        if validateIndexPath(indexPath) {
            guard let contact = fetchedResultsController.object(at: indexPath) as? Contact else {
                print("Can't fetch object from FetchResultController by indexPath = \(indexPath)")
                return cell
            }
            cell.fillData(with: contact)
            return cell
        }
        let label = UILabel(frame: cell.frame)
        label.text = "Create"
        label.textAlignment = .center
        cell.addSubview(label)
        return cell
    }
    
    func validateIndexPath(_ indexPath: IndexPath) -> Bool {
        if let sections = fetchedResultsController.sections,
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
