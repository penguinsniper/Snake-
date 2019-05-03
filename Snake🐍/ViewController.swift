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
    var tick = 1
    var time = Timer()
    
    func startTimer(){
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer(){
        tick += 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
  
    

}

