//
//  Movie+CoreDataClass.swift
//  View & Animation
//
//  Created by chen levi on 14.5.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    
    convenience init(name: String, year: Int16){
        let context = DBManager.shared.context
        let desc = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
        self.init(entity: desc, insertInto: context)
        self.name = name
        self.year = year
        
        DBManager.shared.saveContext()
    }

}
