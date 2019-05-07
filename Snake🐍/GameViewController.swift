
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
    var movement = 1
    var touchApple = false
    
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
        moveSnake()
        if touchApple == false && snakeArray.count <= 3 {
            deleteSnake()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        startTicks()
        score = 0
    }
    func startGame(){
        fullSnakeInView = false
        create()
        spawnApple()
        createSnake()
        let startSound = Bundle.main.path(forResource: "Snake Hissing Noise", ofType: "mp3")!
        let createURL1 = URL(fileURLWithPath: startSound)
        do {
            playSound = try AVAudioPlayer(contentsOf: createURL1)
            playSound?.play()
        }
        
        
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
        switch movement {
        case 1:
            snakeGoingToGo = snakeHead + 1
            for REAPET in 1...gridSize{
                if snakeGoingToGo == (gridSize * REAPET) - 1 {
                    validSpace = false
                }
            }
        case 2:
            snakeGoingToGo = snakeHead - 1
            for REAPE in 0...gridSize - 1 {
                if snakeGoingToGo == (gridSize * REAPE) {
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
        print(snakeGoingToGo)
        if snakeGoingToGo >= 0 && snakeGoingToGo < gridSize * gridSize && validSpace == true{
            if gridViews[snakeGoingToGo].backgroundColor == UIColor.red {
                spawnApple()
                touchApple = true
            }
            gridViews[snakeGoingToGo].backgroundColor = UIColor.green
            snakeHead = snakeGoingToGo
            snakeArray += [snakeGoingToGo]
            print("\(snakeArray) hhhhh")
        }
    }
    func deleteSnake() {
        gridViews[snakeArray[1]].backgroundColor = UIColor.black
        snakeArray.remove(at: 1)
    }
    func createSnake() {
        var startPoint = Int((gridSize * gridSize) / 2)
        gridViews[startPoint].backgroundColor = UIColor.green
        snakeHead = startPoint
        snakeArray = [startPoint]
    }
    
    func moveRight() {
        movement = 1
    }
    func moveLeft() {
        movement = 2
    }
    func moveUp() {
        movement = 3
    }
    func moveDown() {
        movement = 4
    }
}

