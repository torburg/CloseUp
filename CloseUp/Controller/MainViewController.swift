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
    
    let tableController = ContactsViewController()
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        contactTable.delegate = tableController
        contactTable.dataSource = tableController
        
        setView()
    }

    private func setView() {
        
        let gradient = Background().gradient
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
}

