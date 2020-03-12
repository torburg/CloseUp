//
//  Note+CoreDataClass.swift
//  CloseUp
//
//  Created by Maksim Torburg on 12.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.getEntityByName("Note"), insertInto: CoreDataManager.instance.context)
    }
}
