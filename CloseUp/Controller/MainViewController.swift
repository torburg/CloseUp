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

    @IBOutlet weak var contactTable: UITableView!

    @IBOutlet weak var contactView: UICollectionView!

    @IBAction func addButtonPress(_ sender: Any) {
        let newContactViewController = CreateContactViewController()
        newContactViewController.modalPresentationStyle = .fullScreen
        self.present(newContactViewController, animated: true, completion: nil)
    }
    
    let recentViewController = RecentViewController()
    let tableController = ContactsViewController()

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
        contactTable.reloadData()
        recentViewController.setData()
        contactView.reloadData()
    }

    private func initRecentViewController() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        contactView.collectionViewLayout = collectionViewLayout

        let nib = UINib(nibName: "ContactCell", bundle: nil)
        contactView.register(nib, forCellWithReuseIdentifier: "ContactCell")

        contactView.delegate = recentViewController
        contactView.dataSource = recentViewController
        recentViewController.setData()
    }
    
    private func initContactTableViewController() {
        contactTable.delegate = tableController
        contactTable.dataSource = tableController
    }

    private func setView() {
        let gradient = Background().gradient
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
}

