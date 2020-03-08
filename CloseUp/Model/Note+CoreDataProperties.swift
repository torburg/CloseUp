//
//  Note+CoreDataProperties.swift
//  CloseUp
//
//  Created by Maksim Torburg on 08.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var label: String?
    @NSManaged public var contact: Contact?

}
