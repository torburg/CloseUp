//
//  InfoViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 02.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    let appVersion: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    @objc func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    private func setView() {

        let gradient = Background().gradient
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let versionLabel = UILabel()
        versionLabel.text = "App version: \(appVersion ?? "Unknown")"
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(versionLabel)

        let constraints = [
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: backButton.topAnchor, constant: -20),
            versionLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
