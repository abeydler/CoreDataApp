//
//  Task+CoreDataProperties.swift
//  TasksCoreData
//
//  Created by Austin Beydler on 11/30/17.
//  Copyright © 2017 Austin Beydler. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var detail: String?

}
