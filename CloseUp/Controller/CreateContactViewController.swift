//
//  CreateContactViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 08.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class CreateContactViewController: UIViewController {

    @IBOutlet weak var notesView: UIView!

    @IBOutlet weak var name: UITextField!

    @IBAction func addFieldButton(_ sender: Any) {
        let textField = UITextField(frame: CGRect(x: 0, y: 50, width: notesView.frame.width, height: 40))
        textField.backgroundColor = .blue
        textField.text = "Hit me"
        textField.textColor = .white
        notesView.addSubview(textField)
    }

    @IBAction func cancelButtonPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func createButtonPress(_ sender: Any) {
        // TODO: Save data to Database
        if let contactName = name.text,
            contactName.isEmpty {
            let alertController = UIAlertController(title: "Name can't be empty", message: "Fill it", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
            present(alertController, animated: true, completion: { print("empty")})
        } else {
            print("else")
            let contact = Contact()
            contact.name = name.text!
            contact.createdDate = Date()
            contact.updatedDate = Date()
            CoreDataManager.instance.saveContext()
            self.dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    func setView(){
        name.becomeFirstResponder()
    }
}

extension CreateContactViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .green
        return cell
    }
}
