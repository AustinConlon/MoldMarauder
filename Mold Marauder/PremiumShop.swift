//
//  PremiumShop.swift
//  Mold Marauder
//
//  Created by Nathan Mueller on 2/21/17.
//  Copyright © 2017 Nathan Mueller. All rights reserved.
//

import SpriteKit
class PremiumShop: SKScene {
    
    var backButton: SKNode! = nil
    var cashWindfallButton: SKNode! = nil
    var deathRayButton: SKNode! = nil
    var incubatorButton: SKNode! = nil
    var starButton: SKNode! = nil
    var autoTapButton: SKNode! = nil
    
    var incLabel: SKLabelNode! = nil
    
    var deathRayBought = false
    var incubatorBought = 0
    var autoTapBought = 0
    
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
        
        // Cash Windfall
        Texture = SKTexture(image: UIImage(named: "cash windfall 2")!)
        cashWindfallButton = SKSpriteNode(texture:Texture)
        // Place in scene
        cashWindfallButton.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY+170);
        
        self.addChild(cashWindfallButton)
        var windfallLabel = SKLabelNode(fontNamed: "Lemondrop")
        windfallLabel.fontSize = 14
        windfallLabel.fontColor = UIColor.black
        windfallLabel.text = "30 Diamonds"
        windfallLabel.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY+106)
        addChild(windfallLabel)
        
        // Death Ray
        if deathRayBought {
            Texture = SKTexture(image: UIImage(named: "death ray bought")!)
        }
        else {
            Texture = SKTexture(image: UIImage(named: "death ray")!)
        }
        
        deathRayButton = SKSpriteNode(texture:Texture)
        // Place in scene
        deathRayButton.position = CGPoint(x:self.frame.midX+50, y:self.frame.midY+170)
        
        self.addChild(deathRayButton)
        var deathLabel = SKLabelNode(fontNamed: "Lemondrop")
        deathLabel.fontSize = 14
        deathLabel.fontColor = UIColor.black
        deathLabel.text = "$2.99"
        deathLabel.position = CGPoint(x:self.frame.midX+50, y:self.frame.midY+106)
        addChild(deathLabel)
        
        // incubator
        if incubatorBought < 6 {
            Texture = SKTexture(image: UIImage(named: "heated incubator \(incubatorBought + 1)")!)
        }
        else {
            Texture = SKTexture(image: UIImage(named: "incubator bought")!)
        }
        incubatorButton = SKSpriteNode(texture:Texture)
        // Place in scene
        incubatorButton.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY-103)//CGPoint(x:self.frame.midX-85, y:self.frame.midY+50)
        
        self.addChild(incubatorButton)
        //incubator price
        incLabel = SKLabelNode(fontNamed: "Lemondrop")
        incLabel.fontSize = 13
        incLabel.fontColor = UIColor.black
        incLabel.text = "\((incubatorBought + 1)*10)% chance for a free"
        incLabel.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY-165)//CGPoint(x:self.frame.midX-85, y:self.frame.midY-10)
        addChild(incLabel)
        var priceLabel2 = SKLabelNode(fontNamed: "Lemondrop")
        priceLabel2.fontSize = 13
        priceLabel2.fontColor = UIColor.black
        priceLabel2.text = "mold w/ each purchase"
        priceLabel2.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY-178)//CGPoint(x:self.frame.midX-85, y:self.frame.midY-23)
        addChild(priceLabel2)
        var priceLabel3 = SKLabelNode(fontNamed: "Lemondrop")
        priceLabel3.fontSize = 13
        priceLabel3.fontColor = UIColor.black
        priceLabel3.text = "15 Diamonds"
        priceLabel3.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY-194)//CGPoint(x:self.frame.midX-85, y:self.frame.midY-36)
        addChild(priceLabel3)
        
        // autoTap
        if autoTapBought < 5 {
            Texture = SKTexture(image: UIImage(named: "auto-miner \(autoTapBought + 1)")!)
        }
        else {
            Texture = SKTexture(image: UIImage(named: "auto-miner purchased")!)
        }
        autoTapButton = SKSpriteNode(texture:Texture)
        // Place in scene
        autoTapButton.position = CGPoint(x:self.frame.midX+50, y:self.frame.midY+50)
        
        self.addChild(autoTapButton)
        var autoLabel = SKLabelNode(fontNamed: "Lemondrop")
        autoLabel.fontSize = 13
        autoLabel.fontColor = UIColor.black
        autoLabel.text = "Hold finger"
        autoLabel.position = CGPoint(x:self.frame.midX+50, y:self.frame.midY-23)
        addChild(autoLabel)
        var autoLabel2 = SKLabelNode(fontNamed: "Lemondrop")
        autoLabel2.fontSize = 13
        autoLabel2.fontColor = UIColor.black
        autoLabel2.text = "to auto-tap"
        autoLabel2.position = CGPoint(x:self.frame.midX+50, y:self.frame.midY-36)
        addChild(autoLabel2)
        var autoLabel3 = SKLabelNode(fontNamed: "Lemondrop")
        autoLabel3.fontSize = 13
        autoLabel3.fontColor = UIColor.black
        autoLabel3.text = "$3.99"
        autoLabel3.position = CGPoint(x:self.frame.midX+50, y:self.frame.midY-49)
        addChild(autoLabel3)

        // star button
        Texture = SKTexture(image: UIImage(named: "starmoldbutton")!)
        
        starButton = SKSpriteNode(texture:Texture)
        // Place in scene
        starButton.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY+50)
        
        self.addChild(starButton)
        //incubator price
        let priceLabel = SKLabelNode(fontNamed: "Lemondrop")
        priceLabel.fontSize = 13
        priceLabel.fontColor = UIColor.black
        priceLabel.text = "1M Points/Second"
        priceLabel.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY-10)
        addChild(priceLabel)
        priceLabel2 = SKLabelNode(fontNamed: "Lemondrop")
        priceLabel2.fontSize = 13
        priceLabel2.fontColor = UIColor.black
        priceLabel2.text = "Immune to worms"
        priceLabel2.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY-23)
        addChild(priceLabel2)
        priceLabel3 = SKLabelNode(fontNamed: "Lemondrop")
        priceLabel3.fontSize = 13
        priceLabel3.fontColor = UIColor.black
        priceLabel3.text = "4.99$"
        priceLabel3.position = CGPoint(x:self.frame.midX-85, y:self.frame.midY-36)
        addChild(priceLabel3)

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
        if cashWindfallButton.contains(touchLocation) {
            print("windfall")
            if let handler = touchHandler {
                handler("windfall")
            }
        }
        if deathRayButton.contains(touchLocation) {
            if deathRayBought == false {
                print("death ray")
                if let handler = touchHandler {
                    handler("death ray")
                }
            }
        }
        if incubatorButton.contains(touchLocation) {
            if incubatorBought < 6 {
                print("incubator")
                if let handler = touchHandler {
                    handler("incubator")
                }
            }
        }
        if starButton.contains(touchLocation) {
            print("star")
            if let handler = touchHandler {
                handler("star")
            }
        }
        if autoTapButton.contains(touchLocation) {
            print("auto-tap")
            if let handler = touchHandler {
                handler("auto-tap")
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