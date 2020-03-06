//
//  Note+CoreDataClass.swift
//  CloseUp
//
//  Created by Maksim Torburg on 06.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    convenience init() {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: CoreDataManager.instance.context)
        
        self.init(entity: entity!, insertInto: CoreDataManager.instance.context)
    }
}
