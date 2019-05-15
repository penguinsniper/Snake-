
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
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var highScoreLabel: UILabel!
    var highScore = 0
    let bestHighScore = UserDefaults.standard.integer(forKey: "highScore")
    
    var score = 0
    
    var tickCount = 1
    var time = Timer()
    var timerTwo = Timer()
    
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
            for timeWentThrogh in 1...snakeArray.count {
                let num = snakeArray[snakeArray.count - 1 - (timeWentThrogh-1)]
                let colorControllerLink = ColorViewController(throwAway: "")
                if timeWentThrogh % 2 == 0 {
                    gridViews[num].backgroundColor = colorControllerLink.mainColorCross
                } else {
                    gridViews[num].backgroundColor = colorControllerLink.secondColorCross
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        startTicks()
        
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
        
        
        
        highScoreLabel.text = "High Score: \(bestHighScore)"
    }
    
    func startGame(){
        fullSnakeInView = false
        create()
        spawnApple()
        createSnake()
        alive = true
        score = 0
        
        
    }
    
    func create() {
        let viewsControllerLink = Views(gridAmount: gridSize)
        gridViews = viewsControllerLink.viewB
        for REP in 1...gridViews.count {
            gridViews[REP-1].backgroundColor = UIColor.black
            view.addSubview(gridViews[REP-1])
        }
    }
    
    var numIntoTheSnakeArray = 0
    var fixForZero = false
    func death() {
        fixForZero = false
        numIntoTheSnakeArray = snakeArray.count - 1
        timerTwo = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(GameViewController.changeColorAtDeath)), userInfo: nil, repeats: true)
        
    }
    
    @objc func changeColorAtDeath() {
        if fixForZero == false {
            print(numIntoTheSnakeArray)
            let num = snakeArray[numIntoTheSnakeArray]
            gridViews[num].backgroundColor = UIColor(red:0.70, green:0.00, blue:0.00, alpha:1.0)
            if numIntoTheSnakeArray == 0{
                timerTwo.invalidate()
                fixForZero = true
            }
            numIntoTheSnakeArray -= 1
        } else {
            timerTwo.invalidate()
            print("why")
        }
    }
    func spawnApple() {
        var appleView: Int = Int(arc4random_uniform(UInt32(gridSize*gridSize)-1))
        if gridViews[appleView].backgroundColor == UIColor.black {
            gridViews[appleView].backgroundColor = UIColor.red
        }
        
    }
    
    func moveSnake() {
        if alive == true {
        var snakeGoingToGo = 0
        var validSpace = true
        for timeWentThrogh in 1...snakeArray.count {
        if snakeGoingToGo == snakeArray[timeWentThrogh - 1] {
            alive = false
            validSpace = false
            death()
        }
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
            if snakeGoingToGo >= gridSize * gridSize {
                validSpace = false
            }
        case 4:
            snakeGoingToGo = snakeHead + gridSize
            if snakeGoingToGo >= gridSize * gridSize {
                validSpace = false
            }
        default:
            print("fail")
        }
        var appleCreate = false
        if snakeGoingToGo >= 0 && snakeGoingToGo < gridSize * gridSize - 1 && validSpace == true{
            if gridViews[snakeGoingToGo].backgroundColor == UIColor.red {
                
                }
                score += 1
                scoreLabel.text = "Score: \(score)"
                
                appleCreate = true
                touchApple = true
                
                if score > bestHighScore && score > highScore {
                    highScore = score
                    UserDefaults.standard.set(highScore, forKey: "highScore")
                    let newHighScore = UserDefaults.standard.integer(forKey: "highScore")
                    highScoreLabel.text = "High Score: \(newHighScore)"
                }
            }
            if ifHittingSnake(theNumber:snakeGoingToGo) == true {
                alive = false
                validSpace = false
                death()
            } else {
                gridViews[snakeGoingToGo].backgroundColor = UIColor.green
                snakeHead = snakeGoingToGo
                snakeArray += [snakeGoingToGo]
            }
        } else {
            alive = false
            death()
        }
        if appleCreate == true {
            spawnApple()
        }
        }
    }
    func deleteSnake() {
        if alive == true {
        gridViews[snakeArray[0]].backgroundColor = UIColor.black
        snakeArray.remove(at: 0)
        }
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
            if ifHittingSnake(theNumber:snakeHead + gridSize) != true {
                self.movement = 1
            }
        }
        
        if (sender.direction == .left) {
            if ifHittingSnake(theNumber:snakeHead + gridSize) != true {
                movement = 2
            }
        }
        if (sender.direction == .up) {
            if snakeHead - gridSize > 0 {
                if ifHittingSnake(theNumber:snakeHead + gridSize) != true {
                    movement = 3
                }
            }
        }
        
        if (sender.direction == .down) {
            if snakeHead + gridSize < gridSize*gridSize - 1 {
                if ifHittingSnake(theNumber:snakeHead + gridSize) != true {
                    movement = 4
                }
            }
        }
        }
    }
    @IBAction func whenRestartPressed(_ sender: Any) {
        startGame()
        score = 0
        scoreLabel.text = "Score: \(0)"
    }
    func ifHittingSnake(theNumber: Int) -> Bool{
        for timeWentThrogh in 1...snakeArray.count {
            if theNumber == snakeArray[timeWentThrogh - 1] {
                return true
            }
        }
        return false
    }
}

