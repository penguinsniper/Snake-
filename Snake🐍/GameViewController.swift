
/////////
//
//
//
//

//





import UIKit
import AVFoundation

class GameViewController: UIViewController, AVAudioPlayerDelegate {
var playSound = AVAudioPlayer()
    
    
    
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
    
    @IBOutlet var restartButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var highScoreLabel: UILabel!
    
    var score = 0
    var highscore = 0
    
    var tickCount = 1
    var time = Timer()
    
    func startTicks(){
        time = Timer.scheduledTimer(timeInterval: 0.20, target: self, selector: (#selector(GameViewController.tick)), userInfo: nil, repeats: true)
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
        spawnApple()
        createSnake()
        alive = true
        do {
            playSound = try AVAudioPlayer(contentsOf: URL.init (fileURLWithPath: Bundle.main.path(forResource: "Snake Hissing Sound Effect", ofType: "mp3")!))
            
        } catch {
            print("error, no audio")
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
        var appleView: Int = Int(arc4random_uniform(UInt32(gridSize*gridSize)-1))
        if gridViews[appleView].backgroundColor == UIColor.black {
            gridViews[appleView].backgroundColor = UIColor.red
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
        if gridViews[snakeGoingToGo].backgroundColor == UIColor.green {
            alive = false
            validSpace = false
        }
        if snakeGoingToGo >= 0 && snakeGoingToGo < gridSize * gridSize && validSpace == true{
            if gridViews[snakeGoingToGo].backgroundColor == UIColor.red {
                score += 1
                scoreLabel.text = "Score: \(score)"
                spawnApple()
                touchApple = true
                UserDefaults.standard.set(highScoreLabel.text, forKey: "highscore")
                if score > highscore {
                    let newHighscore = UserDefaults.standard.integer(forKey: "highscore")
                    highScoreLabel.text = "High Score: \(newHighscore)"
                }
                
            }
            gridViews[snakeGoingToGo].backgroundColor = UIColor.green
            snakeHead = snakeGoingToGo
            snakeArray += [snakeGoingToGo]
        } else {
            alive = false
        }
    }
    func deleteSnake() {
        gridViews[snakeArray[0]].backgroundColor = UIColor.black
        snakeArray.remove(at: 0)
        
    }
    func createSnake() {
        var startPoint = Int((gridSize * gridSize) / 2)
        gridViews[startPoint].backgroundColor = UIColor.green
        snakeHead = startPoint
        snakeArray = [startPoint]
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if alive == true {
        if (sender.direction == .right) {
            if gridViews[snakeHead + 1].backgroundColor != UIColor.green {
                self.movement = 1
            }
        }
        
        if (sender.direction == .left) {
            if gridViews[snakeHead - 1].backgroundColor != UIColor.green {
                movement = 2
            }
        }
        if (sender.direction == .up) {
            if gridViews[snakeHead - gridSize].backgroundColor != UIColor.green {
                movement = 3
            }
        }
        
        if (sender.direction == .down) {
            if gridViews[snakeHead + gridSize].backgroundColor != UIColor.green {
                movement = 4
            }
        }
        }
    }
}

