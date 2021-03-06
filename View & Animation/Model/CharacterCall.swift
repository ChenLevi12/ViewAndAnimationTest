//
//  CharacterCall.swift
//  View & Animation
//
//  Created by chen levi on 14.5.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//

import UIKit

class CharacterOBJ{
    
    var name: String?
    var nickname: String?
    var image: String?
    var dateOfBirth: Int16?
    var powers: [String]?
    var actorName: String?
    var movies: [[String:Any]]?
    
    
    init(){
        guard let url = URL(string: "http://heroapps.co.il/employee-tests/ios/logan.json") else{print("a problem with json"); return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else{return}
            guard let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else{return}
            guard let jsonData = json["data"] as? [String:Any] else{return}
            let name = jsonData["name"] as? String
            let nickname = jsonData["nickname"] as? String
            let image = jsonData["image"] as? String
            let dateOfBirth = jsonData["dateOfBirth"] as? Int16 ?? 0
            let powers = jsonData["powers"] as? [String]
            let actorName = jsonData["actorName"] as? String
            guard let movies = jsonData["movies"] as? [[String:Any]] else{return}
            
            self.name = name
            self.nickname = nickname
            self.image = image
            self.dateOfBirth = dateOfBirth
            self.powers = powers
            self.actorName = actorName
            self.movies = movies
        }.resume()
    }
    
    
}
