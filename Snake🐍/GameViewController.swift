
/////////
//
//
//
//

//












import UIKit
import AVFoundation

class GameViewController: UIViewController, AVAudioPlayerDelegate {
    var playSound: AVAudioPlayer?
    
    
    
    var gridViews:[UIView] = []
    var gridSize = 21
    var rightSideViews:[Int] = []
    var leftSideViews:[Int] = []
    var fullSnakeInView = false
    var snakeHead = 0
    var snakeArray:[Int] = []
    var movement = 4
    var touchApple = false
    var alive = true
    
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipe: UISwipeGestureRecognizer!
    @IBOutlet var downSwipe: UISwipeGestureRecognizer!
    @IBOutlet var upSwipe: UISwipeGestureRecognizer!
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    
    var tickCount = 1
    var time = Timer()
    
    func startTicks(){
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.tick)), userInfo: nil, repeats: true)
    }
    @objc func tick(){
        if alive == true {
        moveSnake()
        if touchApple == false && snakeArray.count > 3 {
            deleteSnake()
        } else {
            touchApple = false
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        startTicks()
        score = 0
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        upSwipe.direction = .up
        downSwipe.direction = .down
        
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    func startGame(){
        fullSnakeInView = false
        create()
        for repeti in 0...25 {
        spawnApple()
        }
        createSnake()
        let startSound = Bundle.main.path(forResource: "Snake Hissing Sound Effect", ofType: "mp3")!
        let createURL1 = URL(fileURLWithPath: startSound)
        do {
            playSound = try AVAudioPlayer(contentsOf: createURL1)
            playSound?.play()
        } catch {
            // no audio found
            
        }
        alive = true
    }
    func create() {
        let viewsControllerLink = Views(gridAmount: gridSize)
        gridViews = viewsControllerLink.viewB
        for REP in 1...gridViews.count {
            gridViews[REP-1].backgroundColor = UIColor.black
            view.addSubview(gridViews[REP-1])
        }
    }
    func spawnApple() {
        var appleView: Int = Int(arc4random_uniform(UInt32(gridSize*gridSize))) - 1
        if gridViews[appleView].backgroundColor == UIColor.black {
            gridViews[appleView].backgroundColor = UIColor.red
        }
        if appleView == snakeHead {
            score += 1
            scoreLabel.text = "Score: \(score)"
        }
    }
    func moveSnake() {
        var snakeGoingToGo = 0
        var validSpace = true
        if gridViews[snakeGoingToGo].backgroundColor == UIColor.green {
            alive = false
            validSpace = false
        }
        switch movement {
        case 1:
            snakeGoingToGo = snakeHead + 1
            for REAPE in 0...gridSize - 1 {
                if snakeGoingToGo == (gridSize * REAPE) {
                    validSpace = false
                }
            }
        case 2:
            snakeGoingToGo = snakeHead - 1
            for REAPET in 1...gridSize{
                if snakeGoingToGo == (gridSize * REAPET) - 1 {
                    validSpace = false
                }
            }
        case 3:
            snakeGoingToGo = snakeHead - gridSize
        case 4:
            snakeGoingToGo = snakeHead + gridSize
        default:
            print("fail")
        }
        if snakeGoingToGo >= 0 && snakeGoingToGo < gridSize * gridSize && validSpace == true{
            if gridViews[snakeGoingToGo].backgroundColor == UIColor.red {
                spawnApple()
                touchApple = true
            }
            gridViews[snakeGoingToGo].backgroundColor = UIColor.green
            snakeHead = snakeGoingToGo
            snakeArray += [snakeGoingToGo]
        } else {
            
        }
    }
    func deleteSnake() {
        gridViews[snakeArray[0]].backgroundColor = UIColor.black
        snakeArray.remove(at: 0)
        let startSound1 = Bundle.main.path(forResource: "Door Kick Down Sound Effect", ofType: "mp3")!
        let createURL2 = URL(fileURLWithPath: startSound1)
        do {
            playSound = try AVAudioPlayer(contentsOf: createURL2)
            playSound?.play()
        } catch {
            // no audio found
        }
    }
    func createSnake() {
        var startPoint = Int((gridSize * gridSize) / 2)
        gridViews[startPoint].backgroundColor = UIColor.green
        snakeHead = startPoint
        snakeArray = [startPoint]
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .right) {
            movement = 1
        }
        
        if (sender.direction == .left) {
            movement = 2
        }
        if (sender.direction == .up) {
            movement = 3
        }
        
        if (sender.direction == .down) {
            movement = 4
        }
    }
}

