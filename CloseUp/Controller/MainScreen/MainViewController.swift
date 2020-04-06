//
//  MainViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 02.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainView {

    @IBOutlet weak var greeting: UILabel!

    @IBOutlet weak var layoutButton: UIButton!

    @IBOutlet weak var contactList: UICollectionView!

    @IBOutlet weak var recentContacts: UICollectionView!

    @IBOutlet weak var addButton: UIButton!

    var configurator = MainViewConfiguratorImplementation()
    var presenter: MainViewPresenter!

    let recentContactsViewController = RecentContactsViewController()
//    var searchController = UISearchController()
//    var isSearchBarEmpty: Bool {
//      return searchController.searchBar.text?.isEmpty ?? true
//    }
//    var isFiltering: Bool {
//        return searchController.isActive && !isSearchBarEmpty
//    }

    private var currentLayout = CurrentLayout.onePerRow

    var layoutMenu: UIView?

    @IBAction func layoutSetButtonPressed(_ sender: UIButton) {
        if layoutMenu != nil {
            closeLayoutMenuView()
            return
        }
        layoutMenu = {
            let menuView = UIView()
            menuView.backgroundColor = UIColor(white: 1, alpha: 0.5)
            let image = CurrentLayout.allCases.filter{ $0 != currentLayout }.first?.image
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            menuView.addSubview(imageView)
            let constraints = [
                imageView.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: menuView.centerYAnchor),
                imageView.widthAnchor.constraint(equalTo: menuView.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: menuView.heightAnchor),
            ]
            NSLayoutConstraint.activate(constraints)

            menuView.layer.cornerRadius = 10
            return menuView
        }()
        guard let layoutMenu = self.layoutMenu else {
            return
        }
        layoutMenu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(layoutMenu)
        let constraints = [
            layoutMenu.topAnchor.constraint(equalTo: layoutButton.topAnchor),
            layoutMenu.leftAnchor.constraint(equalTo: layoutButton.rightAnchor),
            layoutMenu.heightAnchor.constraint(equalTo: layoutButton.heightAnchor),
            layoutMenu.widthAnchor.constraint(equalTo: layoutButton.widthAnchor),
        ]
        NSLayoutConstraint.activate(constraints)

        let layoutMenuTapGesture = UITapGestureRecognizer(target: self, action: #selector(switchLayoutTapped))
        layoutMenu.gestureRecognizers = [layoutMenuTapGesture]

        let viewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeLayoutMenuView))
        view.gestureRecognizers = [viewTapGestureRecognizer]
    }

    @objc
    func switchLayoutTapped() {
        closeLayoutMenuView()
        switch currentLayout {
        case .onePerRow:
            currentLayout = .twoPerRow
        case .twoPerRow:
            currentLayout = .onePerRow
        }
        UserDefaults.standard.setValue(currentLayout.rawValue, forKey: "SavedLayout")
        setLayoutSettingView()
        contactList.reloadData()
    }

    @objc
    func closeLayoutMenuView() {
        if layoutMenu != nil {
            layoutMenu?.removeFromSuperview()
            layoutMenu = nil
            view.gestureRecognizers?.removeLast()
        }
    }

    @IBAction func addButtonPress(_ sender: Any) {
        let newContactViewController = CreateContactViewController()
        newContactViewController.modalPresentationStyle = .fullScreen
        self.present(newContactViewController, animated: true, completion: nil)
    }

    @IBAction func infoButtonPress(_ sender: UIButton) {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(viewController: self)
        presenter.viewDidLoad()
    }

    func initContactList() {
        contactList.register(ContactListCell.self, forCellWithReuseIdentifier: ContactListCell.reuseIdentifier)
        contactList.backgroundColor = .clear
        contactList.showsVerticalScrollIndicator = false
    }

    func setMainViewBackground() {
        setBackground(for: self)
    }

    func setLayoutSettingView() {
        if let layout = UserDefaults.standard.string(forKey: "SavedLayout") {
            currentLayout = CurrentLayout(rawValue: layout) ?? CurrentLayout.onePerRow
        }
        let image = currentLayout.image
        layoutButton.setImage(image, for: .normal)
        layoutButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
        layoutButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
        contactList.reloadData()
        recentContactsViewController.setData()
        recentContacts.reloadData()
    }

    func initRecentViewController() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        recentContacts.collectionViewLayout = collectionViewLayout
        recentContacts.layer.cornerRadius = 20

        recentContacts.register(RecentContactCell.self, forCellWithReuseIdentifier: RecentContactCell.reuseIdentifier)

        recentContacts.delegate = recentContactsViewController
        recentContacts.dataSource = recentContactsViewController
    }
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequedCell = contactList.dequeueReusableCell(withReuseIdentifier: ContactListCell.reuseIdentifier, for: indexPath)
        guard let cell = dequedCell as? ContactListCell else {
            print("Can't create reusable Cell in TableView")
            return dequedCell
        }
        return presenter.configure(cell, withContactAt: indexPath)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = currentLayout.minimumSpaceBetweenItems * CGFloat(currentLayout.itemsPerRow)
        let availableWidth = collectionView.frame.width - paddingWidth
        let itemWidth = availableWidth / CGFloat(currentLayout.itemsPerRow)
        let itemSize = CGSize(width: itemWidth, height: 70)
        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return currentLayout.minimumSpaceBetweenItems
    }
}

extension MainViewController {
    private enum CurrentLayout: String, CaseIterable {
        case twoPerRow
        case onePerRow

        var image: UIImage {
            switch self {
            case .onePerRow:
                return UIImage(named: "3x1")!.withRenderingMode(.alwaysOriginal)
            case .twoPerRow:
                return UIImage(named: "2x3")!.withRenderingMode(.alwaysOriginal)
            }
        }

        var itemsPerRow: Int {
            switch self {
            case .onePerRow:
                return 1
            case .twoPerRow:
                return 2
            }
        }

        var minimumSpaceBetweenItems: CGFloat {
            switch self {
            case .onePerRow:
                return 0
            case .twoPerRow:
                return CGFloat(20)
            }
        }
    }
}

//extension MainViewController: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        filterFetchedResultsBySearchText(searchBar.text!)
//    }
//
//    func filterFetchedResultsBySearchText(_ searchText: String) {
//        if isFiltering {
//            let predicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)
//            fetchedResultsController.fetchRequest.predicate = predicate
//            do {
//                try fetchedResultsController.performFetch()
//            } catch {
//                print(error)
//            }
//            contactList.reloadData()
//        } else {
//            let predicate = NSPredicate(value: true)
//            fetchedResultsController.fetchRequest.predicate = predicate
//            do {
//                try fetchedResultsController.performFetch()
//            } catch {
//                print(error)
//            }
//            contactList.reloadData()
//        }
//    }
//}
