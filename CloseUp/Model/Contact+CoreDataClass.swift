//
//  Contact+CoreDataClass.swift
//  CloseUp
//
//  Created by Maksim Torburg on 06.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Contact)
public class Contact: NSManagedObject {
    convenience init() {
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: CoreDataManager.instance.context)
        
        self.init(entity: entity!, insertInto: CoreDataManager.instance.context)
    }
}
