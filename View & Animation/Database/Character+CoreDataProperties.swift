//
//  Character+CoreDataProperties.swift
//  View & Animation
//
//  Created by chen levi on 14.5.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var name: String?
    @NSManaged public var nickname: String?
    @NSManaged public var image: String?
    @NSManaged public var dateOfBirth: Int16
    @NSManaged public var powers: [String]?
    @NSManaged public var actorName: String?
    @NSManaged public var movies: [[String:Any]]

}
