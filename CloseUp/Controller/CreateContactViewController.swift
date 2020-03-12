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

    @IBOutlet weak var addButton: UIView!

    @IBAction func addFieldButton(_ sender: Any) {
        let textField = UITextField(frame: addButton.frame)
        textField.backgroundColor = .white
        textField.placeholder = "Hit me"
        textField.textColor = .black

        let newCenterForAddButton = CGPoint(x: addButton.center.x, y: addButton.center.y + 50)
        UIView.beginAnimations(nil, context: .none)
        UIView.setAnimationDuration(0.1)
        addButton.center = newCenterForAddButton
        UIView.commitAnimations()

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
            let contact = preparedContactToSave()
            prepareNotesToSave(for: contact)
            CoreDataManager.instance.saveContext()
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func preparedContactToSave() -> Contact {
        let contact = Contact()
        contact.name = name.text!
        contact.createdDate = Date()
        contact.updatedDate = Date()
        return contact
    }

    private func prepareNotesToSave(for contact: Contact) {
        let notesViews = notesView.subviews
        let textViews = notesViews.filter { $0 is UITextField }.map { $0 as! UITextField }
        for note in textViews {
            if let text = note.text,
            !text.isEmpty {
                let note = Note()
                note.contact = contact
                note.content = text
            }
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
