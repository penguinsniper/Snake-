
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
    let userDefaults = UserDefaults.standard
    
    
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
    var fastSpeed = false
    var poisonApples = false
    var walls = false
    var biggerGrid = false
    
    var difficulty:Int!
    var mainColor:UIColor = UIColor.green
    var secondColor:UIColor = UIColor.yellow
    var oldSnakeHead = 0
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        fastSpeed = userDefaults.bool(forKey: "fastSpeed")
        poisonApples = userDefaults.bool(forKey: "poisonApples")
        walls = userDefaults.bool(forKey: "walls")
        biggerGrid = userDefaults.bool(forKey: "biggerGrid")
        
        highScoreLabel.text = "High Score: \(bestHighScore)"
        switch userDefaults.integer(forKey: "mainColor") {
            
        case 0:
            mainColor = UIColor.green
        case 1:
            mainColor = UIColor.yellow
        case 2:
            mainColor = UIColor.orange
        case 3:
            mainColor = UIColor.blue
        case 4:
            mainColor = UIColor.cyan
        case 5:
            mainColor = UIColor.magenta
        case 6:
            mainColor = UIColor.purple
        case 7:
            mainColor = UIColor.brown
        case 8:
            mainColor = UIColor.white
        case 9:
            mainColor = UIColor.gray
        case 10:
            mainColor = UIColor.black
        default:
            mainColor = UIColor.green
            
        }
        switch userDefaults.integer(forKey: "secondColor") {
        case 0:
            secondColor = UIColor.green
        case 1:
            secondColor = UIColor.yellow
        case 2:
            secondColor = UIColor.orange
        case 3:
            secondColor = UIColor.blue
        case 4:
            secondColor = UIColor.cyan
        case 5:
            secondColor = UIColor.magenta
        case 6:
            secondColor = UIColor.brown
        case 7:
            secondColor = UIColor.white
        case 8:
            secondColor = UIColor.gray
        case 9:
            secondColor = UIColor.black
        default:
            secondColor = UIColor.yellow
            
        }
        startGame()
        startTicks()
    }
    
    func startTicks(){
        var tickSpeed = 0.2
        if fastSpeed == true {
            tickSpeed = 0.175
        }
        time = Timer.scheduledTimer(timeInterval: 0.20, target: self, selector: (#selector(GameViewController.tick)), userInfo: nil, repeats: true)
    }
    @objc func tick(){
        if alive == true {
            moveSnake()
            if touchApple == false && snakeArray.count > 3 {
                deleteSnake()
            } else {
                if touchApple == true {
                    touchApple = false
                    if walls == true {
                        addWall()
                    }
                    spawnApple()
                    
                }
            }
            for timeWentThrogh in 1...snakeArray.count {
                let num = snakeArray[snakeArray.count - 1 - (timeWentThrogh-1)]
                if timeWentThrogh % 2 == 0 {
                    gridViews[num].backgroundColor = secondColor
                } else {
                    gridViews[num].backgroundColor = mainColor
                }
            }
        }
    }
    func addWall() {
        var wallHit = false
        while wallHit == false {
        var wallView:Int = Int(arc4random_uniform(UInt32(gridSize*gridSize)-1))
        if ifHittingSnake(theNumber: wallView) == false && gridViews[wallView].backgroundColor != UIColor.darkGray && gridViews[wallView].backgroundColor != UIColor.red{
            gridViews[wallView].backgroundColor = UIColor.darkGray
            wallHit = true
        }
        }
    }
    func startGame(){
        fullSnakeInView = false
        create()
        var appleView: Int = Int(arc4random_uniform(UInt32(gridSize*gridSize)-1))
        gridViews[appleView].backgroundColor = UIColor.red
        createSnake()
        alive = true
        score = 0
        movement = 4
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
        var appleHit = false
        var pAppleHit = false
        while appleHit == false {
            var appleView: Int = Int(arc4random_uniform(UInt32(gridSize*gridSize)-1))
        if ifHittingSnake(theNumber: appleView) == false && gridViews[appleView].backgroundColor != UIColor.darkGray && gridViews[appleView].backgroundColor != UIColor.red {
            gridViews[appleView].backgroundColor = UIColor.red
            appleHit = true
        }
            print("hi1")
        }
        if poisonApples == true {
        while pAppleHit == false {
            var pAppleView: Int = Int(arc4random_uniform(UInt32(gridSize*gridSize)-1))
            if ifHittingSnake(theNumber: pAppleView) == false && gridViews[pAppleView].backgroundColor != UIColor.darkGray && gridViews[pAppleView].backgroundColor != UIColor.red{
                gridViews[pAppleView].backgroundColor = UIColor.purple
                pAppleHit = true
            }
        }
        }
    }
    
    func moveSnake() {
        var appleCreate = false
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
            if snakeGoingToGo < 0 {
                validSpace = false
            }
        case 4:
            snakeGoingToGo = snakeHead + gridSize
            if snakeGoingToGo > gridSize * gridSize {
                validSpace = false
            }
        default:
            print("fail")
        }
            if validSpace == true {
            if gridViews[snakeGoingToGo].backgroundColor == UIColor.darkGray {
                validSpace = false
                }
                if gridViews[snakeGoingToGo].backgroundColor == UIColor.purple {
                    deleteSnake()
                    score -= 1
                }
            }
        if snakeGoingToGo >= 0 && snakeGoingToGo < gridSize * gridSize - 1 && validSpace == true {
            if gridViews[snakeGoingToGo].backgroundColor == UIColor.red {
                score += 1
                scoreLabel.text = "Score: \(score)"
                
                appleCreate = true
                touchApple = true
                }
                
                if score > bestHighScore && score > highScore {
                    highScore = score
                    UserDefaults.standard.set(highScore, forKey: "highScore")
                    let newHighScore = UserDefaults.standard.integer(forKey: "highScore")
                    highScoreLabel.text = "High Score: \(newHighScore)"
                }
            
            if ifHittingSnake(theNumber:snakeGoingToGo) == true {
                alive = false
                validSpace = false
                death()
            } else {
                gridViews[snakeGoingToGo].backgroundColor = mainColor
                oldSnakeHead = snakeHead
                snakeHead = snakeGoingToGo
                snakeArray += [snakeGoingToGo]
                
                
            }
        } else {
            alive = false
            death()
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
        gridViews[startPoint].backgroundColor = mainColor
        snakeHead = startPoint
        snakeArray = [startPoint]
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if alive == true {
        if (sender.direction == .right) {
            if snakeHead + 1 != oldSnakeHead{
                self.movement = 1
            }
        }
        
        if (sender.direction == .left) {
            if snakeHead - 1 != oldSnakeHead {
                movement = 2
            }
        }
        if (sender.direction == .up) {
            if snakeHead - gridSize > 0 {
                if snakeHead - gridSize != oldSnakeHead {
                    movement = 3
                }
            }
        }
        if (sender.direction == .down) {
            if snakeHead + gridSize < gridSize*gridSize {
                if snakeHead + gridSize != oldSnakeHead {
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
        print(snakeArray)
        for timeWentThrogh in 1...snakeArray.count {
            if theNumber == snakeArray[timeWentThrogh - 1] {
                return true
            }
        }
        return false
    }
}

