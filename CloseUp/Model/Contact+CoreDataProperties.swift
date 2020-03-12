//
//  Contact+CoreDataProperties.swift
//  CloseUp
//
//  Created by Maksim Torburg on 12.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var createdDate: Date
    @NSManaged public var name: String
    @NSManaged public var updatedDate: Date
    @NSManaged public var note: NSSet?

}

// MARK: Generated accessors for note
extension Contact {

    @objc(addNoteObject:)
    @NSManaged public func addToNote(_ value: Note)

    @objc(removeNoteObject:)
    @NSManaged public func removeFromNote(_ value: Note)

    @objc(addNote:)
    @NSManaged public func addToNote(_ values: NSSet)

    @objc(removeNote:)
    @NSManaged public func removeFromNote(_ values: NSSet)

}
