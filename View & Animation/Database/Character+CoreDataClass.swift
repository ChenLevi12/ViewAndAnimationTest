//
//  Character+CoreDataClass.swift
//  View & Animation
//
//  Created by chen levi on 14.5.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Character)
public class Character: NSManagedObject {
    
    convenience init(name: String?, nickName: String?, image: String?, dateOfBirth: Int16, powers: [String]?, actorName: String?, movies: [[String:Any]]){
        let context = DBManager.shared.context
        let desc = NSEntityDescription.entity(forEntityName: "Character", in: context)!
        self.init(entity: desc, insertInto: context)
        self.name = name
        self.nickname = nickName
        self.image = image
        self.dateOfBirth = dateOfBirth
        self.powers = powers
        self.actorName = actorName
        self.movies = movies
        
        DBManager.shared.saveContext()
    }
    
    

}
