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
    let contactListViewController = ContactListViewController()

    @IBAction func infoButtonPress(_ sender: UIButton) {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRecentViewController()
        initContactTableViewController()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contactListViewController.setData()
        contactList.reloadData()
        recentContactsViewController.setData()
        recentContacts.reloadData()
    }

    private func initRecentViewController() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        recentContacts.collectionViewLayout = collectionViewLayout

        let nib = UINib(nibName: "RecentContactCell", bundle: nil)
        recentContacts.register(nib, forCellWithReuseIdentifier: RecentContactCell.reuseIdentifier)

        recentContacts.delegate = recentContactsViewController
        recentContacts.dataSource = recentContactsViewController
        recentContactsViewController.setData()
    }
    
    private func initContactTableViewController() {
        let nib = UINib(nibName: "ContactListCell", bundle: nil)
        contactList.register(nib, forCellReuseIdentifier: ContactListCell.reuseIdentifier)

        contactList.delegate = contactListViewController
        contactList.dataSource = contactListViewController
        contactListViewController.setData()
    }

    private func setView() {
        let gradient = Background().gradient
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
}

