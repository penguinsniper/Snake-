//
//  GameViewController.swift
//  Snake🐍
//ffff
//  Created by Olivia Mellen on 5/1/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var gridViews:[UIView] = []
    var gridSize = 21
    var rightSideViews:[Int] = []
    var leftSideViews:[Int] = []
    var fullSnakeInView = false
    var snakeHead = 0
    var snakeArray:[Int] = []
    
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipe: UISwipeGestureRecognizer!
    @IBOutlet var downSwipe: UISwipeGestureRecognizer!
    @IBOutlet var upSwipe: UISwipeGestureRecognizer!
    
    var tickCount = 1
    var time = Timer()
    
    func startTicks(){
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.tick)), userInfo: nil, repeats: true)
    }
    @objc func tick(){
        tickCount += 1
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    func startGame(){
        fullSnakeInView = false
        create()
        spawnApple()
        createSnake()
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
        var appleView: Int = Int(arc4random_uniform(UInt32(gridSize*gridSize)))
        if gridViews[appleView].backgroundColor == UIColor.black {
            gridViews[appleView].backgroundColor = UIColor.red
        }
    }
    func moveSnake() {
        if fullSnakeInView != true {
         addToSnake()
        }
    }
    func addToSnake() {
        
    }
    func createSnake() {
        var startPoint = 221
        gridViews[startPoint].backgroundColor = UIColor.green
        snakeHead = startPoint
        snakeArray = [startPoint]
        
    }
    
    func moveRight() {
        let movement = 1
    }
    func moveLeft() {
        let movement = 1
    }
    func moveUp() {
        let movement = 1
    }
    func moveDown() {
        let movement = 1
    }
}
