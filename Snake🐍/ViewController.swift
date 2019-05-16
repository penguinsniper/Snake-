//
//  ViewController.swift
//  Snake🐍
//
//  Created by Ryan Lau on 5/1/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {
    var highScore:Int = 0
    var difficulty:[Int] = []

    @IBOutlet var menuHighScore: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let newHighScore = UserDefaults.standard.integer(forKey: "highScore")
        menuHighScore.text = "High Score: \(newHighScore)"
        
    }
  
    
    
     @IBAction func whenEasyPressed(_ sender: Any) {
        difficulty = [1]
     }
    
     @IBAction func whenMediumPressed(_ sender: Any) {
        
     }
    
     @IBAction func whenHardPressed(_ sender: Any) {
        
     }

}

