//
//  ViewController.swift
//  View & Animation
//
//  Created by chen levi on 14.5.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var yearBorn: UILabel!
    @IBOutlet weak var powers: UILabel!
    @IBOutlet weak var originalActor: UILabel!
    @IBOutlet weak var imageA: UIImageView!
    var moviesData: [[String:Any]] = []
    var character: Character!
    var requestCharacterCall:CharacterRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(finished(notification:)), name: .finished, object: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
    
        let characterFromData = try! DBManager.shared.getCharacters()
        
        //check if data exist in CoreData
        if characterFromData.count != 0{
            print("go to DataCore")
            //if fes pull the data from CoreData
            character = characterFromData[0]
            setViewsValue()
        }else{
            print("call to api")
            //else make api call in another class
            requestCharacterCall = CharacterRequest()
        }
        
    }
    
    @objc func finished(notification: NSNotification){
        //set the object after api call ended
        character = requestCharacterCall.instance
        setViewsValue()
    }
    
    
    func setViewsValue() {
        //set the values in all views
        self.navigationItem.title = character.name
        nickname.text = character.nickname
        yearBorn.text = "\(character.dateOfBirth)"
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
        //show image from url
        URLSession.shared.dataTask(with: imgURL) { (data, response, error) in
            guard let data = data else{return}
            DispatchQueue.main.async {
                let img = UIImage(data: data)
                self.imageA.image = img
                
            }
            }.resume()
        //make circle image
        imageA.layer.cornerRadius = imageA.bounds.width / 2
        imageA.layer.masksToBounds = true
        
        moviesData = character.movies
        tableView.reloadData()
    }
    
    
    
    @IBAction func imageTapped(_ sender: Any) {
        //go to full screen image
        performSegue(withIdentifier: "photo", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass image to next viewcontroller
        if let dest = segue.destination as? PhotoViewController{
            dest.img = imageA.image
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
}


extension Notification.Name{
    static let finished = Notification.Name("finished")
}

