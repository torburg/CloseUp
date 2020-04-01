//
//  MainViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 02.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var greeting: UILabel!

    @IBOutlet weak var contactList: UICollectionView!

    @IBOutlet weak var recentContacts: UICollectionView!

    @IBOutlet weak var addButton: UIButton!

    @IBAction func addButtonPress(_ sender: Any) {
        let newContactViewController = CreateContactViewController()
        newContactViewController.modalPresentationStyle = .fullScreen
        self.present(newContactViewController, animated: true, completion: nil)
    }
    let recentContactsViewController = RecentContactsViewController()
    var searchController = UISearchController()
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Contact",
                                                                                 sortBy: "name",
                                                                                 sortDirectionAsc: true)

    private var chosenLayout = currentLayout.onePerRow
    let minimumSpaceBetweenItems = CGFloat(20)

    @IBAction func infoButtonPress(_ sender: UIButton) {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRecentViewController()
        initContactList()
        addButton.layer.zPosition = 1

        setBackgroubd(for: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        contactList.reloadData()
        recentContactsViewController.setData()
        recentContacts.reloadData()
    }

    private func initRecentViewController() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        recentContacts.collectionViewLayout = collectionViewLayout
        recentContacts.layer.cornerRadius = 20

        recentContacts.register(RecentContactCell.self, forCellWithReuseIdentifier: RecentContactCell.reuseIdentifier)

        recentContacts.delegate = recentContactsViewController
        recentContacts.dataSource = recentContactsViewController
    }
    
    private func initContactList() {
        contactList.register(ContactListCell.self, forCellWithReuseIdentifier: ContactListCell.reuseIdentifier)
        contactList.backgroundColor = .clear
        searchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Search me"
            controller.searchResultsUpdater = self
            definesPresentationContext = true

//            contactList.tableHeaderView = controller.searchBar

            return controller
        }()
    }
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequedCell = contactList.dequeueReusableCell(withReuseIdentifier: ContactListCell.reuseIdentifier, for: indexPath)
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

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemPerRow: Int?
        switch chosenLayout {
        case .onePerRow:
            itemPerRow = 1
        case .twoPerRow:
            itemPerRow = 2
        }
        let itemWidth = collectionView.frame.width / CGFloat(itemPerRow ?? 1)
        let itemSize = CGSize(width: itemWidth, height: 70)
        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpaceBetweenItems
    }
}

extension MainViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterFetchedResultsBySearchText(searchBar.text!)
    }

    func filterFetchedResultsBySearchText(_ searchText: String) {
        if isFiltering {
            let predicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)
            fetchedResultsController.fetchRequest.predicate = predicate
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print(error)
            }
            contactList.reloadData()
        } else {
            let predicate = NSPredicate(value: true)
            fetchedResultsController.fetchRequest.predicate = predicate
            do {
                try fetchedResultsController.performFetch()
            } catch {
                print(error)
            }
            contactList.reloadData()
        }
    }

    private enum currentLayout {
        case twoPerRow
        case onePerRow
    }
}
