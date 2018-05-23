//
//  CharacterOBJ.swift
//  View & Animation
//
//  Created by chen levi on 15.5.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//

import UIKit


class CharacterRequest{
    
    var instance: Character!
        init(){
        guard let url = URL(string: "http://heroapps.co.il/employee-tests/ios/logan.json") else{print("a problem with json"); return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            //get json from the api
            guard let data = data else{return}
            guard let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else{return}
            guard let jsonData = json["data"] as? [String:Any] else{return}
            //get values from json
            let name = jsonData["name"] as? String
            let nickname = jsonData["nickname"] as? String
            let image = jsonData["image"] as? String
            let dateOfBirth = jsonData["dateOfBirth"] as? Int16 ?? 0
            let powers = jsonData["powers"] as? [String]
            let actorName = jsonData["actorName"] as? String
            guard let movies = jsonData["movies"] as? [[String:Any]] else{return}
            
            //save character object to CoreData in this line
            self.instance = Character(name: name, nickName: nickname, image: image, dateOfBirth: dateOfBirth, powers: powers, actorName: actorName, movies: movies)
            
            
            
            DispatchQueue.main.async {
                //notify api call ended
                NotificationCenter.default.post(name: .finished, object: nil)
            }
            
            
        }.resume()
    }
        
        
}
