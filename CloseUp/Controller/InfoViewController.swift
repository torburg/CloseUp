//
//  InfoViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 02.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
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
        
        view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
