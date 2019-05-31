//
//  SettingsViewController.swift
//  Snake🐍
//
//  Created by Olivia Mellen on 5/20/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var fastSpeedSwitch: UISwitch!
    @IBOutlet var poisonAppleSwitch: UISwitch!
    @IBOutlet var wallsSwitch: UISwitch!
    @IBOutlet var biggerGridSwitch: UISwitch!
    @IBOutlet var AISnakeSwitch: UISwitch!
    
    var userDefaults = UserDefaults.standard
    
    var fastSpeed = false
    var poisonApples = false
    var walls = false
    var biggerGrid = false
    var AISnake = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fastSpeed = userDefaults.bool(forKey: "fastSpeed")
        poisonApples = userDefaults.bool(forKey: "poisonApples")
        walls = userDefaults.bool(forKey: "walls")
        biggerGrid = userDefaults.bool(forKey: "biggerGrid")
        AISnake = userDefaults.bool(forKey: "AISnake")
        fastSpeedSwitch.isOn = fastSpeed
        poisonAppleSwitch.isOn = poisonApples
        wallsSwitch.isOn = walls
        biggerGridSwitch.isOn = biggerGrid
        AISnakeSwitch.isOn = AISnake
    }
   
    @IBAction func whenFastSpeedPressed(_ sender: Any) {
        fastSpeed = fastSpeedSwitch.isOn
        userDefaults.set(fastSpeed, forKey: "fastSpeed")
    }
    
    @IBAction func whenPoisonApplesPressed(_ sender: Any) {
        poisonApples = poisonAppleSwitch.isOn
        userDefaults.set(poisonApples, forKey: "poisonApples")
    }
    
    @IBAction func whenWallsPressed(_ sender: Any) {
        walls = wallsSwitch.isOn
        userDefaults.set(walls, forKey: "walls")
    }
    
    @IBAction func whenBiggerGriddPressed(_ sender: Any) {
        biggerGrid = biggerGridSwitch.isOn
        userDefaults.set(biggerGrid, forKey: "biggerGrid")
    }
    @IBAction func whenSnakepressed(_ sender: Any) {
            AISnake = AISnakeSwitch.isOn
        userDefaults.set(AISnake, forKey: "AISnake")
    }
    
    
}
