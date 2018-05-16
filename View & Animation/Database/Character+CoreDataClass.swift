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
    
    convenience init(characterOBJ: CharacterOBJ){
        let context = DBManager.shared.context
        let desc = NSEntityDescription.entity(forEntityName: "Character", in: context)!
        self.init(entity: desc, insertInto: context)
        self.name = characterOBJ.name
        self.nickname = characterOBJ.nickname
        self.image = characterOBJ.image
        self.dateOfBirth = characterOBJ.dateOfBirth!
        self.powers = characterOBJ.powers
        self.actorName = characterOBJ.actorName
        self.movies = characterOBJ.movies!
        
        DBManager.shared.saveContext()
    }
    
    

}
