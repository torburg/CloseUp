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

    @IBOutlet weak var contactView: UIView!

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
        print("Main viewDidLoad")
        super.viewDidLoad()
        print(#function)
        initRecentViewController()
        initContactTableViewController()
        setView()
    }
    
    private func initRecentViewController() {
        
        // FIXME: All init shoulbe be in RecentVC, init needs Layout != nil
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        let nib = UINib(nibName: "ContactCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ContactCell")
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.frame = contactView.frame
        collectionView.backgroundColor = .white
        
        collectionView.delegate = recentViewController
        collectionView.dataSource = recentViewController
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

    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        contactTable.reloadData()
        recentViewController.setData()
    }
}

