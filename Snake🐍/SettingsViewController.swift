//
//  SettingsViewController.swift
//  Snake🐍
//
//  Created by Olivia Mellen on 5/20/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var userDefaults = UserDefaults.standard
    
    var fastSpeed = false
    var poisonApples = false
    var walls = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.set(fastSpeed, forKey: "fastSpeed")
        userDefaults.set(poisonApples, forKey: "poisonApples")
        userDefaults.set(walls, forKey: "walls")
    }
   
    @IBAction func whenFastSpeedPressed(_ sender: Any) {
        fastSpeed = true
        userDefaults.set(fastSpeed, forKey: "fastSpeed")
    }
    
    @IBAction func whenPoisonApplesPressed(_ sender: Any) {
        poisonApples = true
        userDefaults.set(poisonApples, forKey: "poisonApples")
    }
    
    @IBAction func whenWallsPressed(_ sender: Any) {
        walls = true
        userDefaults.set(walls, forKey: "walls")
    }
}
