//
//  ContactsViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 02.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class ContactListViewController: NSObject, UITableViewDelegate {

    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Contact",
                                                                                 sortBy: "name",
                                                                                 sortDirectionAsc: true)

    func setData() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequedCell = tableView.dequeueReusableCell(withIdentifier: ContactListCell.reuseIdentifier, for: indexPath)
        guard let cell = dequedCell as? ContactListCell else {
            print("Can't create reusable Cell in TableView")
            return dequedCell
        }
        guard let contact = fetchedResultsController.object(at: indexPath) as? Contact else {
            print("Can't fetch object from FetchResultController by indexPath = \(indexPath)")
            return cell
        }
        cell.fillData(with: contact)
        return cell
    }
}
