//
//  PumpViewController.swift
//  View & Animation
//
//  Created by chen levi on 15.5.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//

import UIKit

class PumpViewController: UIViewController {
    var endAnimation = false
    @IBOutlet weak var heightOfHeart: NSLayoutConstraint!
    @IBOutlet weak var withOfHeart: NSLayoutConstraint!
    @IBOutlet weak var heartPhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        pumpAnimation()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pumpAnimation(){
        
        UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
            self.heightOfHeart.constant += 30
            self.withOfHeart.constant += 30
            self.view.layoutIfNeeded()
        }, completion: { (sec) in
            UIView.animate(withDuration: 0.5, delay: 0.1, animations: {
                self.heightOfHeart.constant -= 30
                self.withOfHeart.constant -= 30
                self.view.layoutIfNeeded()
            }, completion: { (end) in
                if self.endAnimation == false{
                    self.pumpAnimation()
                }
            })
        })

        
        
    }

    
    @IBAction func heartTapped(_ sender: Any) {
        print("imageTapped")
        
        if endAnimation{
            endAnimation = false
            pumpAnimation()
        }else{
            endAnimation = true
        }
        
    }
    
    
    
   
    
   

}
