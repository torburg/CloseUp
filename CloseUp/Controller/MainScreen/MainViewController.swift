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

    @IBOutlet weak var contactList: UITableView!

    @IBOutlet weak var recentContacts: UICollectionView!

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

    @IBAction func infoButtonPress(_ sender: UIButton) {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRecentViewController()
        initContactTableViewController()

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
        recentContacts.backgroundColor = .clear

        let nib = UINib(nibName: "RecentContactCell", bundle: nil)
        recentContacts.register(nib, forCellWithReuseIdentifier: RecentContactCell.reuseIdentifier)

        recentContacts.delegate = recentContactsViewController
        recentContacts.dataSource = recentContactsViewController
    }
    
    private func initContactTableViewController() {
        let nib = UINib(nibName: "ContactListCell", bundle: nil)
        contactList.register(nib, forCellReuseIdentifier: ContactListCell.reuseIdentifier)
        contactList.backgroundColor = .clear

        searchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Search me"
            controller.searchResultsUpdater = self
            definesPresentationContext = true

            contactList.tableHeaderView = controller.searchBar

            return controller
        }()

        contactList.delegate = self
        contactList.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

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
}
