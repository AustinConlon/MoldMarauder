//
//  CreditsScene.swift
//  Mold Marauder
//
//  Created by Nathan Mueller on 3/17/17.
//  Copyright © 2017 Nathan Mueller. All rights reserved.
//

import SpriteKit
class CreditsScene: SKScene {
    
    var backButton: SKNode! = nil
    
    let gameLayer = SKNode()
    var point = CGPoint()
    
    var cometLayer = SKNode()
    
    //touch handler
    var touchHandler: ((String) -> ())?
    
    //for background animations
    var backframes = [SKTexture]()
    let background = SKSpriteNode(texture: SKTexture(image: UIImage(named: "cyber_menu_glow")!))
    //comet sprites
    var cometSprite: SKNode! = nil
    var cometSprite2: SKNode! = nil
    var cometTimer: Timer!
    
    let levelUpSound = SKAction.playSoundFileNamed("Ka-Ching.wav", waitForCompletion: false)
    let cashRegisterSound = SKAction.playSoundFileNamed("cash register.wav", waitForCompletion: false)
    let selectSound = SKAction.playSoundFileNamed("select.wav", waitForCompletion: false)
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        background.size = size
        backframes.append(SKTexture(image: UIImage(named: "cyber_menu_glow")!))
        backframes.append(SKTexture(image: UIImage(named: "cyber_menu_glow F2")!))
        backframes.append(SKTexture(image: UIImage(named: "cyber_menu_glow F3")!))
        addChild(background)
        background.run(SKAction.repeatForever(
            SKAction.animate(with: backframes,
                             timePerFrame: 0.15,
                             resize: false,
                             restore: true)),
                       withKey:"background")
        addChild(cometLayer)
        
        addChild(gameLayer)
        
        let _ = SKLabelNode(fontNamed: "Lemondrop")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        animateComets()
        cometTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(animateComets), userInfo: nil, repeats: true)
        createButton()
    }
    
    func createButton()
    {
        // BACK MENU
        var Texture = SKTexture(image: UIImage(named: "exit")!)
        backButton = SKSpriteNode(texture:Texture)
        // Place in scene
        backButton.position = CGPoint(x:self.frame.midX+160, y:self.frame.midY+190);
        
        self.addChild(backButton)
        
        let labelOne = SKLabelNode(fontNamed: "Lemondrop")
        labelOne.fontSize = 13
        labelOne.fontColor = UIColor.black
        labelOne.text = "Nathan Mueller: "
        labelOne.position = CGPoint(x:self.frame.midX-65, y:self.frame.midY+150)
        addChild(labelOne)
        
        let labelTwo = SKLabelNode(fontNamed: "Lemondrop")
        labelTwo.fontSize = 13
        labelTwo.fontColor = UIColor.black
        labelTwo.text = "Code, Game Design, Sound Design, Art"
        labelTwo.position = CGPoint(x:self.frame.midX, y:self.frame.midY+136)
        addChild(labelTwo)
        
        let labelThree = SKLabelNode(fontNamed: "Lemondrop")
        labelThree.fontSize = 13
        labelThree.fontColor = UIColor.black
        labelThree.text = "Vlad Popovsky: "
        labelThree.position = CGPoint(x:self.frame.midX-65, y:self.frame.midY+115)
        addChild(labelThree)

        let labelFour = SKLabelNode(fontNamed: "Lemondrop")
        labelFour.fontSize = 13
        labelFour.fontColor = UIColor.black
        labelFour.text = "Music"
        labelFour.position = CGPoint(x:self.frame.midX-65, y:self.frame.midY+102)
        addChild(labelFour)
        
        let labelFive = SKLabelNode(fontNamed: "Lemondrop")
        labelFive.fontSize = 13
        labelFive.fontColor = UIColor.black
        labelFive.text = "Special Thanks: "
        labelFive.position = CGPoint(x:self.frame.midX-65, y:self.frame.midY+81)
        addChild(labelFive)
        
        let labelSix = SKLabelNode(fontNamed: "Lemondrop")
        labelSix.fontSize = 13
        labelSix.fontColor = UIColor.black
        labelSix.text = "DeviantArt user BakaBrony and Hasbro"
        labelSix.position = CGPoint(x:self.frame.midX, y:self.frame.midY+68)
        addChild(labelSix)
        
        let labelSeven = SKLabelNode(fontNamed: "Lemondrop")
        labelSeven.fontSize = 13
        labelSeven.fontColor = UIColor.black
        labelSeven.text = "for Cave Background"
        labelSeven.position = CGPoint(x:self.frame.midX, y:self.frame.midY+55)
        addChild(labelSeven)
        
        let labelEight = SKLabelNode(fontNamed: "Lemondrop")
        labelEight.fontSize = 13
        labelEight.fontColor = UIColor.black
        labelEight.text = "Github user crashoverride777:"
        labelEight.position = CGPoint(x:self.frame.midX-30, y:self.frame.midY+34)
        addChild(labelEight)
        
        let labelNine = SKLabelNode(fontNamed: "Lemondrop")
        labelNine.fontSize = 13
        labelNine.fontColor = UIColor.black
        labelNine.text = "for SwiftySKScrollView"
        labelNine.position = CGPoint(x:self.frame.midX-30, y:self.frame.midY+21)
        addChild(labelNine)
        
        let labelTen = SKLabelNode(fontNamed: "Lemondrop")
        labelTen.fontSize = 13
        labelTen.fontColor = UIColor.black
        labelTen.text = "Github user mkrd: "
        labelTen.position = CGPoint(x:self.frame.midX-30, y:self.frame.midY)
        addChild(labelTen)
        
        let label11 = SKLabelNode(fontNamed: "Lemondrop")
        label11.fontSize = 13
        label11.fontColor = UIColor.black
        label11.text = "for Swift-Big-Integer"
        label11.position = CGPoint(x:self.frame.midX, y:self.frame.midY-13)
        addChild(label11)
        
        let label12 = SKLabelNode(fontNamed: "Lemondrop")
        label12.fontSize = 13
        label12.fontColor = UIColor.black
        label12.text = "And RayWenderleich.com"
        label12.position = CGPoint(x:self.frame.midX, y:self.frame.midY-35)
        addChild(label12)
        
        let label13 = SKLabelNode(fontNamed: "Lemondrop")
        label13.fontSize = 13
        label13.fontColor = UIColor.black
        label13.text = "For countless invaluable tutorials"
        label13.position = CGPoint(x:self.frame.midX, y:self.frame.midY-48)
        addChild(label13)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        // Check if the location of the touch is within the back button's bounds
        if backButton.contains(touchLocation) {
            print("back")
            if let handler = touchHandler {
                handler("back")
            }
        }
        
        
    }
    
    func playSound(select: String) {
        switch select {
        case "levelup":
            run(levelUpSound)
        case "cash register":
            run(cashRegisterSound)
        case "select":
            run(selectSound)
        default:
            run(levelUpSound)
        }
    }
    
    func animateName(name: String) {
        // Figure out what the midpoint of the chain is.
        let centerPosition = CGPoint(
            x: (point.x),
            y: (point.y + 10))
        
        // Add a label for the score that slowly floats up.
        let scoreLabel = SKLabelNode(fontNamed: "Lemondrop")
        scoreLabel.fontSize = 28
        scoreLabel.text = name
        scoreLabel.position = centerPosition
        scoreLabel.zPosition = 300
        gameLayer.addChild(scoreLabel)
        
        let ranX = Int(arc4random_uniform(40)) - 20
        let ranY = Int(arc4random_uniform(25) + 1)
        let Y = ranY + 120
        let moveAction = SKAction.move(by: CGVector(dx: ranX, dy: Y), duration: 3)
        moveAction.timingMode = .easeOut
        scoreLabel.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
    }
    
    func animateComets() {
        let comet = SKTexture(image: UIImage(named: "comet")!)
        let comet180 = SKTexture(image: UIImage(named: "comet180")!)
        let cometUp = SKTexture(image: UIImage(named: "cometUp")!)
        let cometDown = SKTexture(image: UIImage(named: "cometDown")!)
        
        //left or right
        let side = Int(arc4random_uniform(4))
        let y = randomInRange(lo: Int(self.frame.minY), hi: Int(self.frame.maxY))
        let x = randomInRange(lo: Int(self.frame.minX), hi: Int(self.frame.maxX))
        if side == 1{
            cometSprite = SKSpriteNode(texture:comet)
            cometSprite.position = CGPoint(x: -500, y: y)
            cometLayer.addChild(cometSprite)
            
            let moveOne = SKAction.move(to: CGPoint(x: 500,y: y), duration:0.6)
            cometSprite.run(SKAction.sequence([moveOne]))
            
            cometSprite2 = SKSpriteNode(texture:comet)
            cometSprite2.position = CGPoint(x: -500, y: y + 30)
            cometLayer.addChild(cometSprite2)
            
            let moveTwo = SKAction.move(to: CGPoint(x: 500,y: y + 30), duration:0.6)
            cometSprite2.run(SKAction.sequence([moveTwo]))
            
        }
        if side == 2 {
            cometSprite = SKSpriteNode(texture:cometUp)
            cometSprite.position = CGPoint(x: x, y: -700)
            cometLayer.addChild(cometSprite)
            
            let moveOne = SKAction.move(to: CGPoint(x: x,y: 700), duration:0.8)
            cometSprite.run(SKAction.sequence([moveOne]))
            
            cometSprite2 = SKSpriteNode(texture:cometUp)
            cometSprite2.position = CGPoint(x: x + 30, y: -700)
            cometLayer.addChild(cometSprite2)
            
            let moveTwo = SKAction.move(to: CGPoint(x: x + 30,y: 700), duration:0.8)
            cometSprite2.run(SKAction.sequence([moveTwo]))
        }
        if side == 3 {
            cometSprite = SKSpriteNode(texture:cometDown)
            cometSprite.position = CGPoint(x: x, y: 700)
            cometLayer.addChild(cometSprite)
            
            let moveOne = SKAction.move(to: CGPoint(x: x,y: -700), duration:0.8)
            cometSprite.run(SKAction.sequence([moveOne]))
            
            cometSprite2 = SKSpriteNode(texture:cometDown)
            cometSprite2.position = CGPoint(x: x - 30, y: 700)
            cometLayer.addChild(cometSprite2)
            
            let moveTwo = SKAction.move(to: CGPoint(x: x - 30,y: -700), duration:0.8)
            cometSprite2.run(SKAction.sequence([moveTwo]))
        }
        else {
            cometSprite = SKSpriteNode(texture:comet180)
            cometSprite.position = CGPoint(x: 500, y: y)
            cometLayer.addChild(cometSprite)
            
            let moveOne = SKAction.move(to: CGPoint(x: -500,y: y), duration:0.6)
            cometSprite.run(SKAction.sequence([moveOne]))
            
            cometSprite2 = SKSpriteNode(texture:comet180)
            cometSprite2.position = CGPoint(x: 500, y: y - 30)
            cometLayer.addChild(cometSprite2)
            
            let moveTwo = SKAction.move(to: CGPoint(x: -500,y: y - 30), duration:0.6)
            cometSprite2.run(SKAction.sequence([moveTwo]))
        }
        
    }
    
    
    func randomInRange(lo: Int, hi : Int) -> Int {
        return lo + Int(arc4random_uniform(UInt32(hi - lo + 1)))
    }
}