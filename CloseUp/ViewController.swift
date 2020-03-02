//
//  ViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 02.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        setView()
        if true {
            label.text = "TRUE"
            label.textColor = .black
        }
    }

    func setView() {
        
        let gradient = Background().gradient
        gradient.frame = view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

class Background {
    
    let gradient = CAGradientLayer()
    
    init() {
        let topColor = UIColor(red: 68.0 / 255.0, green: 168.0 / 255.0, blue: 238.0 / 255.0, alpha: 1)
        let bottomColor = UIColor(red: 168.0 / 255.0, green: 178.0 / 255.0, blue: 200.0 / 255.0, alpha: 1)
        gradient.colors = [topColor, bottomColor]
//        gradient.locations = [0.0, 1.0]
    }
}


