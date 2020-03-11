//
//  CreateContactViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 08.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class CreateContactViewController: UIViewController {

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func createButtonPressed(_ sender: Any) {
        // TODO: Save data to Database
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
