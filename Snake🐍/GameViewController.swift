



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
    var oldSnakeHead = 0
    var snakeArray:[Int] = []
    var movement = 4
    var touchApple = false
    var alive = true
    var fastSpeed = false
    var poisonApples = false
    var walls = false
    var biggerGrid = false
    var secondPattern = false
    var AISnake = false
    //AI
    var AISnakeHead = 0
    var AIOldSnakeHead = 0
    var AISnakeArray:[Int] = []
    var AIMovement = 4
    var AITouchApple = false
    var AIAlive = true
    
    
    var difficulty:Int!
    var mainColor:UIColor = UIColor.green
    var secondColor:UIColor = UIColor.yellow
    
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
    var AITimerTwo = Timer()
    
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
        if biggerGrid == true {gridSize = 43}
        highScoreLabel.text = "High Score: \(bestHighScore)"
        secondPattern = userDefaults.bool(forKey: "secondPattern")
        
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
            mainColor = UIColor.brown
        case 7:
            mainColor = UIColor.white
        case 8:
            mainColor = UIColor.gray
        case 9:
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
    var tickSpeed = 0.2
    func startTicks(){
        tickSpeed = 0.2
        if fastSpeed == true {
            tickSpeed = 0.1
        }
        time = Timer.scheduledTimer(timeInterval: tickSpeed, target: self, selector: (#selector(GameViewController.tick)), userInfo: nil, repeats: true)
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
            if secondPattern == true {
                for timeWentThrogh in 1...snakeArray.count {
                    let num = snakeArray[snakeArray.count - 1 - (timeWentThrogh-1)]
                    if timeWentThrogh % 3 == 1 {
                        gridViews[num].backgroundColor = mainColor
                    } else {
                        gridViews[num].backgroundColor = secondColor
                    }
                }
            } else {
                for timeWentThrogh in 1...snakeArray.count {
                    let num = snakeArray[snakeArray.count - 1 - (timeWentThrogh-1)]
                    if timeWentThrogh % 2 == 0 {
                        gridViews[num].backgroundColor = secondColor
                    } else {
                        gridViews[num].backgroundColor = mainColor
                    }
                }
            }
            AITick()
            //AI
            if AISnake == true {
              
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
        
        //AI
        AICreateSnake()
        AIAlive = true
        AIMovement = 4
        if AISnake == true {
        
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
            if snakeGoingToGo >= 0 && snakeGoingToGo < gridSize * gridSize && validSpace == true {
                if gridViews[snakeGoingToGo].backgroundColor == UIColor.darkGray {
                    validSpace = false
                }
            }
        if snakeGoingToGo >= 0 && snakeGoingToGo < gridSize * gridSize && validSpace == true {
            if gridViews[snakeGoingToGo].backgroundColor == UIColor.purple {
                deleteSnake()
                score -= 1
            }
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
                    highScoreAnimation()
                }
            
            if ifHittingSnake(theNumber:snakeGoingToGo) == true || ifHittingAISnake(theNumber:snakeGoingToGo){
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
        for timeWentThrogh in 1...snakeArray.count {
            if theNumber == snakeArray[timeWentThrogh - 1] {
                return true
            }
        }
        return false
    }
    
    func highScoreAnimation() {
        let bounds = highScoreLabel.bounds
        
        UIView.animate(withDuration: 2, delay: 0.3, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            self.highScoreLabel.bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width - 50, height: bounds.size.height)
        }) { (success:Bool) in
            if success {
                self.highScoreLabel.bounds = bounds
            }
        }
    }
    
    func AICreateSnake() {
        var startPoint = 1 + gridSize
        gridViews[startPoint].backgroundColor = UIColor.yellow
        AISnakeHead = startPoint
        AISnakeArray = [startPoint]
    }
    
    func AITick() {
        AIMove()
        if AIAlive == true && alive == true {
            AIMoveSnake()
            if AITouchApple == false && AISnakeArray.count > 3 {
                AIDeleteSnake()
            } else {
                if AITouchApple == true {
                    AITouchApple = false
                    if walls == true {
                        addWall()
                    }
                    spawnApple()
                }
            }
                for timeWentThrogh in 1...AISnakeArray.count {
                    let num = AISnakeArray[AISnakeArray.count - 1 - (timeWentThrogh-1)]
                    if timeWentThrogh % 2 == 0 {
                        gridViews[num].backgroundColor = UIColor.green
                    } else {
                        gridViews[num].backgroundColor = UIColor.yellow
                    }
                }
        }
    }
    
    func AIMoveSnake() {
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
            switch AIMovement {
            case 1:
                snakeGoingToGo = AISnakeHead + 1
                for REAPE in 0...gridSize - 1 {
                    if snakeGoingToGo == (gridSize * REAPE) {
                        validSpace = false
                    }
                }
            case 2:
                snakeGoingToGo = AISnakeHead - 1
                for REAPET in 1...gridSize{
                    if snakeGoingToGo == (gridSize * REAPET) - 1 {
                        validSpace = false
                    }
                }
            case 3:
                snakeGoingToGo = AISnakeHead - gridSize
                if snakeGoingToGo < 0 {
                    validSpace = false
                }
            case 4:
                snakeGoingToGo = AISnakeHead + gridSize
                if snakeGoingToGo > gridSize * gridSize {
                    validSpace = false
                }
            default:
                print("fail")
            }
            if snakeGoingToGo >= 0 && snakeGoingToGo < gridSize * gridSize && validSpace == true {
                if gridViews[snakeGoingToGo].backgroundColor == UIColor.darkGray {
                    validSpace = false
                }
                if gridViews[snakeGoingToGo].backgroundColor == UIColor.purple {
                    AIDeleteSnake()
                    print("Purple")
                }
                if gridViews[snakeGoingToGo].backgroundColor == UIColor.red {
                    appleCreate = true
                    AITouchApple = true
                }
            }
            if snakeGoingToGo >= 0 && snakeGoingToGo < gridSize * gridSize && validSpace == true {
                
                if ifHittingAISnake(theNumber:snakeGoingToGo) == true || ifHittingSnake(theNumber:snakeGoingToGo){
                    AIAlive = false
                    validSpace = false
                    AIDeath()
                } else { gridViews[snakeGoingToGo].backgroundColor = mainColor
                    AIOldSnakeHead = AISnakeHead
                    AISnakeHead = snakeGoingToGo
                    AISnakeArray += [snakeGoingToGo]
                }
            } else {
                AIAlive = false
                AIDeath()
            }
        }
        
    }
    
    var AINumIntoTheSnakeArray = 0
    var AIFixForZero = false
    
    func AIDeath() {
        AIFixForZero = false
        AINumIntoTheSnakeArray = AISnakeArray.count - 1
        timerTwo = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(GameViewController.AIChangeColorAtDeath)), userInfo: nil, repeats: true)
    }
    
    func AIDeleteSnake() {
        if AIAlive == true && alive == true {
            gridViews[AISnakeArray[0]].backgroundColor = UIColor.black
            AISnakeArray.remove(at: 0)
        }
    }
    
    @objc func AIChangeColorAtDeath() {
        if AIFixForZero == false {
            let num = AISnakeArray[AINumIntoTheSnakeArray]
            gridViews[num].backgroundColor = UIColor(red:0.70, green:0.00, blue:0.00, alpha:1.0)
            if AINumIntoTheSnakeArray == 0{
                AITimerTwo.invalidate()
                AIFixForZero = true
            }
            AINumIntoTheSnakeArray -= 1
        } else {
            AITimerTwo.invalidate()
        }
    }
    var AIDirection = 1
    func AIMove() {
        if AIAlive == true {
        var AISnakeGoingToGo = 0
        var doneSearching = false
            print("\n\n")
        for REAPET in 0...20 {
            AIDirection = Int(arc4random_uniform(4)) + 1
            if Int(arc4random_uniform(4)) != 2 {
                AIDirection == AIMovement
            }
        switch AIDirection {
        case 1:
            var isPosible = true
            AISnakeGoingToGo = AISnakeHead + 1
            
            if AISnakeGoingToGo == AIOldSnakeHead {
                isPosible = false
            }
            
            for REAPE in 0...gridSize - 1 {
                if AISnakeGoingToGo == (gridSize * REAPE) {
                    isPosible = false
                }
            }
            
            if AISnakeGoingToGo < gridSize*gridSize {
            if gridViews[AISnakeGoingToGo].backgroundColor == UIColor.purple || gridViews[AISnakeGoingToGo].backgroundColor == UIColor.gray{
                isPosible = false
            }
                
                if gridViews[AISnakeGoingToGo].backgroundColor == UIColor.red {
                    doneSearching == true
                }
            }
            
            if ifHittingAISnake(theNumber:AISnakeGoingToGo) == true {
                isPosible = false
            }
            
            if ifHittingSnake(theNumber:AISnakeGoingToGo) == true {
                isPosible = false
            }
            
            if AISnakeGoingToGo == gridSize {
                isPosible = false
            }
            
            if doneSearching == true {
                isPosible = false
            }
            
            if isPosible == true {
                AIMovement = 1
                print(1)
            }
        case 2:
            var isPosible = true
            AISnakeGoingToGo = AISnakeHead - 1
            
            if AISnakeGoingToGo == AIOldSnakeHead {
                isPosible = false
            }
            
            for REAPET in 1...gridSize{
                if AISnakeGoingToGo == (gridSize * REAPET) - 1 {
                    isPosible = false
                }
            }
            
            if AISnakeGoingToGo == -1 {
                isPosible = false
            }
            
            if AISnakeGoingToGo >= 0 {
            if gridViews[AISnakeGoingToGo].backgroundColor == UIColor.purple || gridViews[AISnakeGoingToGo].backgroundColor == UIColor.gray{
                isPosible = false
            }
                
                if gridViews[AISnakeGoingToGo].backgroundColor == UIColor.red {
                    doneSearching == true
                }
            }
            
            if ifHittingAISnake(theNumber:AISnakeGoingToGo) == true {
                isPosible = false
            }
            
            if ifHittingSnake(theNumber:AISnakeGoingToGo) == true {
                isPosible = false
            }
            
            if doneSearching == true {
                isPosible = false
            }
            
            if isPosible == true {
                AIMovement = 2
                print(2)
            }
        case 3:
            var isPosible = true
            AISnakeGoingToGo = AISnakeHead - gridSize
            
            if AISnakeGoingToGo == AIOldSnakeHead {
                isPosible = false
            }
            
            if AISnakeGoingToGo < 0 {
                isPosible = false
            }
            
            if AISnakeGoingToGo >= 0 {
            if gridViews[AISnakeGoingToGo].backgroundColor == UIColor.purple || gridViews[AISnakeGoingToGo].backgroundColor == UIColor.gray{
                isPosible = false
            }
                
                if gridViews[AISnakeGoingToGo].backgroundColor == UIColor.red {
                    doneSearching == true
                }
            }
            
            if AISnakeGoingToGo == oldSnakeHead {
                isPosible = false
            }
            
            if ifHittingAISnake(theNumber:AISnakeGoingToGo) == true {
                isPosible = false
            }
            
            if ifHittingSnake(theNumber:AISnakeGoingToGo) == true {
                isPosible = false
            }
            
            if doneSearching == true {
                isPosible = false
            }
            
            if isPosible == true {
                AIMovement = 3
                print(3)
            }
        case 4:
            var isPosible = true
            AISnakeGoingToGo = AISnakeHead + gridSize
            
            if AISnakeGoingToGo == AIOldSnakeHead {
                isPosible = false
            }
            
            if snakeHead + gridSize >= gridSize*gridSize {
                isPosible = false
            }
            if snakeHead + gridSize == oldSnakeHead {
                isPosible = false
            }
            
            if AISnakeGoingToGo < gridSize*gridSize {
            if gridViews[AISnakeGoingToGo].backgroundColor == UIColor.purple || gridViews[AISnakeGoingToGo].backgroundColor == UIColor.gray{
                isPosible = false
            }
                
                if gridViews[AISnakeGoingToGo].backgroundColor == UIColor.red {
                    doneSearching == true
                }
            }
            
            if ifHittingAISnake(theNumber:AISnakeGoingToGo) == true {
                isPosible = false
            }
            
            if ifHittingSnake(theNumber:AISnakeGoingToGo) == true {
                isPosible = false
            }
            
            if doneSearching == true {
                isPosible = false
            }
            
            if isPosible == true {
                AIMovement = 4
                print(4)
            }
        default:
            break
        }
        }
        }
    }
    
    func ifHittingAISnake(theNumber: Int) -> Bool{
        for timeWentThrogh in 1...AISnakeArray.count {
            if theNumber == AISnakeArray[timeWentThrogh - 1] {
                return true
            }
        }
        return false
    }
//    if alive == true {
//    moveSnake()
//    if touchApple == false && snakeArray.count > 3 {
//    deleteSnake()
//    } else {
//    if touchApple == true {
//    touchApple = false
//    if walls == true {
//    addWall()
//    }
//    spawnApple()
//    }
//    }
//    print(secondPattern)
//    if secondPattern == true {
//    for timeWentThrogh in 1...snakeArray.count {
//    let num = snakeArray[snakeArray.count - 1 - (timeWentThrogh-1)]
//    if timeWentThrogh % 3 == 1 {
//    gridViews[num].backgroundColor = mainColor
//    } else {
//    gridViews[num].backgroundColor = secondColor
//    }
//    }
//    } else {
//    for timeWentThrogh in 1...snakeArray.count {
//    let num = snakeArray[snakeArray.count - 1 - (timeWentThrogh-1)]
//    if timeWentThrogh % 2 == 0 {
//    gridViews[num].backgroundColor = secondColor
//    } else {
//    gridViews[num].backgroundColor = mainColor
//    }
//    }
//    }
//    AITick()
}

