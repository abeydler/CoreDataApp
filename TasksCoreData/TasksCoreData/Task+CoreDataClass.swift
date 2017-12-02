//
//  Task+CoreDataClass.swift
//  TasksCoreData
//
//  Created by Austin Beydler on 11/30/17.
//  Copyright © 2017 Austin Beydler. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    
    convenience init?(name: String?, detail: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        
        self.init(entity: Task.entity(), insertInto: managedContext)
        
        self.name = name
        self.detail = detail
    }

}
