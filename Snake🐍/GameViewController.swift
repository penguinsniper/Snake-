//
//  GameViewController.swift
//  Snake🐍
//
//  Created by Olivia Mellen on 5/1/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var gridViews:[UIView] = []
    var gridSize = 21
    var rightSideViews:[Int] = []
    var leftSideViews:[Int] = []
    var fullSkakeInView = false
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipe: UISwipeGestureRecognizer!
    @IBOutlet var downSwipe: UISwipeGestureRecognizer!
    @IBOutlet var upSwipe: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        create()
        // Do any additional setup after loading the view.
    }
    func startGame (){
        fullSkakeInView = false
    }
    func moveSnake() {
        if fullSkakeInView == true {
            
        } else {
            
        }
    }
    func create() {
        let viewsControllerLink = Views(gridAmount: gridSize)
        gridViews = viewsControllerLink.viewB
        for REP in 1...gridViews.count {
            gridViews[REP-1].backgroundColor = UIColor.black
            view.addSubview(gridViews[REP-1])
        }
        rightSideViews = []
        leftSideViews = []
        for REAPE in 0...gridSize - 1{
            rightSideViews += [gridSize * REAPE]
        }
        for REAPET in 1...gridSize {
            leftSideViews += [(gridSize * REAPET) - 1]
        }
    }
    func spawnApple() {
        
    }
}
