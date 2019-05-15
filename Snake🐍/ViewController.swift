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
    

    @IBOutlet var menuHighScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newHighScore = UserDefaults.standard.integer(forKey: "highScore")
        menuHighScore.text = "High Score: \(newHighScore)"
        
    }
  
    

}

