//
//  ViewController.swift
//  View & Animation
//
//  Created by chen levi on 14.5.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ValueCompleted {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var yearBorn: UILabel!
    @IBOutlet weak var powers: UILabel!
    @IBOutlet weak var originalActor: UILabel!
    @IBOutlet weak var imageA: UIImageView!
    var moviesData: [[String:Any]] = []
    var character: CharacterOBJ!
    static var ins: ViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewController.ins = self
        tableView.dataSource = self
        tableView.delegate = self
    
        let characterFromData = try! DBManager.shared.getCharacters()
        if characterFromData.count != 0{
            
            print("go to DataCore")
            let characterOBJFromData = CharacterOBJ(name: characterFromData[0].name, nickname: characterFromData[0].nickname, image: characterFromData[0].image, dateOfBirth: characterFromData[0].dateOfBirth, powers: characterFromData[0].powers, actorName: characterFromData[0].actorName, movies: characterFromData[0].movies)
            character = characterOBJFromData
        }else{
            print("call to api")
            let characterOBJ = CharacterOBJ()
            character = characterOBJ
            
            
            
        }
        
    }
    
    
    static func finished(){
        ViewController.ins?.completedLoading()
    }
    
    func completedLoading() {
        let savedCharacter = Character(characterOBJ: character)
        self.navigationItem.title = character.name
        nickname.text = character.nickname
        yearBorn.text = "\(character.dateOfBirth!)"
        originalActor.text = character.actorName
        var str = ""
        guard let powersStr = character.powers else{return}
        for i in powersStr{
            if str == ""{
                str = i
            }else{
                str += ", \(i)"
            }
        }
        powers.text = str
        
        guard let imgURL = URL(string: character.image!) else{return}
        URLSession.shared.dataTask(with: imgURL) { (data, response, error) in
            guard let data = data else{return}
            DispatchQueue.main.async {
                let img = UIImage(data: data)
                self.imageA.image = img
                
            }
            }.resume()
        
        imageA.layer.cornerRadius = imageA.bounds.width / 2
        imageA.layer.masksToBounds = true
        
        moviesData = character.movies!
        tableView.reloadData()
    }
    
    
    
    @IBAction func imageTapped(_ sender: Any) {
        performSegue(withIdentifier: "photo", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PhotoViewController{
            dest.img = imageA.image
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.name.text = moviesData[indexPath.row]["name"] as? String
        cell.year.text = "\((moviesData[indexPath.row]["year"] as? Int)!)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let delayTime = 0.1 * Double(indexPath.row + 1)
        UIView.animate(withDuration: 0.3, delay: delayTime, animations: {
            cell.alpha = 1.0
        })
    }
    
}

