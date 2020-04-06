//
//  MainViewPresenter.swift
//  CloseUp
//
//  Created by Maksim Torburg on 04.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

protocol MainView: class {
    func initContactList()
    func setLayoutSettingView()
    func initRecentViewController()
    func setMainViewBackground()
}

protocol ContactListCellView {

}

protocol MainViewPresenter {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfItems(in section: Int) -> Int
    func configure(_ cell: ContactListCell, withContactAt: IndexPath) -> ContactListCell
}

class MainViewPresenterImplementation: MainViewPresenter {
    weak var view: MainView?
    var dataManager: CoreDataManager!

    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Contact",
                                                                                    sortBy: "name",
                                                                                    sortDirectionAsc: true)

    init(view: MainView, dataManager: CoreDataManager) {
        self.view = view
        self.dataManager = dataManager
    }

    func viewDidLoad() {
        view?.initContactList()
        view?.setLayoutSettingView()
        view?.initRecentViewController()
        view?.setMainViewBackground()
//        view?.bringSubviewToFront(view?.addButton)

    }

    func viewWillAppear() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
//        view?.contactList.reloadData()
//        recentContactsViewController.setData()
//        recentContacts.reloadData()
    }

    func numberOfItems(in section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }

    func configure(_ cell: ContactListCell, withContactAt indexPath: IndexPath) -> ContactListCell {
        guard let contact = fetchedResultsController.object(at: indexPath) as? Contact else {
            print("Can't fetch object from FetchResultController by indexPath = \(indexPath)")
            return cell
        }
        cell.fillData(with: contact)
        return cell
    }
}
