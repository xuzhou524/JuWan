//
//  GameScene.swift
//  JuWan
//
//  Created by fanzhe on 2021/2/1.
//

import SwiftUI
import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreNode: SKSpriteNode!
    var solid: SKSpriteNode!
    var ground: SKSpriteNode!
    var nowFruit: SKSpriteNode!
    var redLine: SKSpriteNode!
    var fruitSlot: FruitSlot! = FruitSlot()
    var groundFruits: [SKSpriteNode] = []
    
    let slotPosition = CGPoint(x: screen.width / 2, y: screen.height - 100)
    
    let groundBitMask: UInt32 = 0xFFFFFFFF >> 1
    
    let groundAudio = AudioUtil(resourceName: "falldown")
    let explodeAudio = AudioUtil(resourceName: "bomb")
    let bonusAudio = AudioUtil(resourceName: "win")
    
    var canCollisonFruitWithFruit = true
    var canTouch = true
    
    
    var gameover:Bool = false
    
    var gameoverNode: SKSpriteNode!
    var restartNode: SKSpriteNode!
    
    var score: Int = 0 {
        didSet {
            // update scoreNode
            updateScoreNode()
            PlayWatermelonViewController().saveHighScore(s: score)
        }
    }
    
    private func updateScoreNode() {
        scoreNode.removeAllChildren()
        
        var characterArray:[Int] = []
        var offset: CGFloat = 0
        var cp = score
        while cp != 0 {
            characterArray.append(cp % 10)
            cp /= 10
        }
        while characterArray.count != 0 {
            let last = characterArray.popLast()!
            let lastNode = SKSpriteNode(imageNamed: getNumberTexture(last))
            lastNode.anchorPoint = CGPoint.zero
            lastNode.position = CGPoint(x: offset * (lastNode.size.width - 10), y: 0)
            offset += 1
            scoreNode.addChild(lastNode)
        }
    }
}

// MARK: - Update
extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        if gameover { return }
        if redLine != nil && checkFailed() {
            gameover = true
            // Animation
            run(.sequence([
                .repeat(.sequence([
                    .run {
                        var topFruit = self.groundFruits[0]
                        var index = 0
                        for i in 0..<self.groundFruits.count {
                            if self.groundFruits[i].position.y > self.groundFruits[i].position.y {
                                topFruit = self.groundFruits[i]
                                index = i
                                
                            }
                        }
                        self.groundFruits.remove(at: index)
                        topFruit.run(.fadeOut(withDuration: 0.3))
                        topFruit.removeFromParent()
                        
                        AudioUtil(resourceName: "bomb").playAudio()
                        
                    },
                    .wait(forDuration: 0.1),
                ]), count: groundFruits.count),
                .run {
                    // load GameOver
                    self.loadGameover()
                }
            ]))
        }
    }
    
    
    
    func checkFailed() -> Bool {
        for fruit in groundFruits {
            if fruit.position.y + fruit.size.height/2 > screen.height - 20 {
                return true
            }
        }
        return false
    }
}

// MARK: - LoadUI
extension GameScene {
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        backgroundColor = UIColor(#colorLiteral(red: 0.9999857545, green: 0.9065491557, blue: 0.6149721146, alpha: 1))
            
        initGame()
    }
    
    func initGame() {
        self.removeAllChildren()
        loadSolid()
        loadGround()
        loadScore()
        loadNewFruit()
    }
    
    func loadGameover() {
        gameoverNode = SKSpriteNode(imageNamed: "gameover")
        gameoverNode.position = CGPoint(x: screen.width/2, y: screen.height/2 + 15)
        gameoverNode.setScale(0)
        gameoverNode.zPosition = 1
        
        restartNode = SKSpriteNode(imageNamed: "restart")
        restartNode.position = CGPoint(x: screen.width/2, y: screen.height/2 - 15)
        restartNode.setScale(0)
        restartNode.zPosition = 1
        
        addChild(gameoverNode)
        
        addChild(restartNode)
        
        gameoverNode.run(.scale(to: 0.25, duration: 0.3))
        restartNode.run(.scale(to: 0.25, duration: 0.3))
    }
    
    func loadRedLine() {
        redLine = SKSpriteNode(imageNamed: "redline")
        redLine.anchorPoint = CGPoint.zero
        redLine.position = CGPoint(x: 0, y: screen.height - 100)
        redLine.run(.repeat(.sequence([
            .fadeOut(withDuration: 0.3),
            .fadeIn(withDuration: 0.3)
        ]), count: -1))
        addChild(redLine)
    }
    
    func loadSolid() {
        solid = SKSpriteNode(color: UIColor(#colorLiteral(red: 0.4392156863, green: 0.337254902, blue: 0.2509803922, alpha: 1)), size: CGSize(width: screen.width, height: screen.height / 4))
        solid.anchorPoint = CGPoint.zero
        solid.position = CGPoint.zero
        addChild(solid)
    }
    
    func loadGround() {
        ground = SKSpriteNode(color: UIColor(#colorLiteral(red: 0.6666666667, green: 0.5490196078, blue: 0.3803921569, alpha: 1)), size: CGSize(width: screen.width, height: 20))
        ground.anchorPoint = CGPoint.zero
        ground.position = CGPoint(x: 0, y: screen.height / 4)
        
        let groundPhysicsBody = SKPhysicsBody(edgeLoopFrom:
            CGRect(x: 0,
                   y: 0,
                   width: ground.size.width,
                   height: ground.size.height))
        ground.physicsBody = groundPhysicsBody
        ground.physicsBody?.categoryBitMask = groundBitMask
        ground.physicsBody?.contactTestBitMask = groundBitMask
        
        addChild(ground)
    }
    
    func loadScore() {
        scoreNode = SKSpriteNode()
        
        scoreNode.anchorPoint = CGPoint.zero
        scoreNode.position = CGPoint(x: 20, y: screen.height - 80)
        scoreNode.setScale(0.5)
        
        let zeroNode = SKSpriteNode(imageNamed: "0")
        zeroNode.anchorPoint = CGPoint.zero
        zeroNode.position = CGPoint.zero
        
        scoreNode.addChild(zeroNode)
        
        addChild(scoreNode)
    }
    
    // load default in the sky
    func loadNewFruit() {
        nowFruit = fruitSlot.randomFruit()
        nowFruit.position = slotPosition
        addChild(nowFruit)
    }
    
    // generate by position
    func generateNewFruit(fruitName: String, position: CGPoint, gravity: Bool = true) {
        let fruit = SKSpriteNode(imageNamed: fruitName)
        fruit.name = fruitName
        fruit.position = position
        fruit.setScale(0.4)
        if gravity {
            fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.height / 2 + 1)
            let bitMask = getFruitTextureByName(fruitName: fruit.name!).bitMask
            fruit.physicsBody?.categoryBitMask = bitMask
            fruit.physicsBody?.contactTestBitMask = bitMask
        }
        groundFruits.append(fruit)
        addChild(fruit)
    }
    
    // animation
    func generateBonusAnimation() {
        canTouch = false
        
        let darkNode = SKSpriteNode(color: UIColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.4017105622)), size: CGSize(width: screen.width, height: screen.height))
        darkNode.anchorPoint = CGPoint.zero
        darkNode.position = CGPoint.zero
        darkNode.zPosition = 1
        addChild(darkNode)
        
        let bonusNode = SKSpriteNode()
        bonusNode.anchorPoint = CGPoint.zero
        bonusNode.position = CGPoint(x: screen.width / 2, y: screen.height / 2)
        
        let watermelon = SKSpriteNode(imageNamed: FruitTexture.watermelon.imageName)
        let backLight = SKSpriteNode(imageNamed: "light")
        watermelon.setScale(0.4)
        
        bonusNode.addChild(backLight)
        bonusNode.addChild(watermelon)
        
        bonusNode.setScale(0.3)
        addChild(bonusNode)
        
        bonusNode.zPosition = 1
        
        backLight.run(.rotate(byAngle: 5, duration: 5))
        
        bonusNode.run(.sequence([
            .move(to: CGPoint(x: screen.width / 2, y: screen.height / 2 + 200), duration: 0.3),
            .move(to: CGPoint(x: screen.width / 2, y: screen.height / 2), duration: 0.5),
            .wait(forDuration: 1),
            .move(to: CGPoint(x: screen.width / 2, y: screen.height - 100), duration: 0.5)
        ]))
        bonusNode.run(.sequence([
            .scale(to: 0.5, duration: 0.3),
            .scale(to: 1.5, duration: 0.5),
            .wait(forDuration: 1),
            .scale(to: 0, duration: 0.5),
        ]))
        darkNode.run(.sequence([
            .wait(forDuration: 2.3),
            .fadeOut(withDuration: 0.1),
            .run {
                bonusNode.removeFromParent()
                watermelon.removeFromParent()
                bonusNode.removeFromParent()
                darkNode.removeFromParent()
                
                self.canTouch = true
            }
        ]))
    }
}

// MARK: - Touches
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !canTouch { return }
        
        guard let touch = touches.first else { return }
        // game over
        if gameover {
            let location = touch.location(in: self)
            if let node = self.atPoint(location) as? SKSpriteNode {
                if node == restartNode {
                    gameover = false
                    initGame()
                }
            }
            return
        }
        
        canTouch = false
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.loadNewFruit()
            self.nowFruit.setScale(0)
            self.nowFruit.run(.sequence([
                .scale(to: 0.4, duration: 0.3),
                .run {
                    self.canTouch = true
                }
            ]))
        }
        
        let location = touch.location(in: self)
        nowFruit.run(.sequence([
            .moveTo(x: location.x, duration: 0.1),
            .wait(forDuration: 0.1),
            .run {
                // contact
                self.nowFruit.physicsBody = SKPhysicsBody(circleOfRadius: self.nowFruit.size.height / 2)
                let bitMask = getFruitTextureByName(fruitName: self.nowFruit.name!).bitMask
                self.nowFruit.physicsBody?.categoryBitMask = bitMask
                self.nowFruit.physicsBody?.contactTestBitMask = bitMask
                self.groundFruits.append(self.nowFruit)
            },
            .wait(forDuration: 1),
            .run {
                // check redline
                if !self.checkRedLine() && self.redLine != nil {
                    self.redLine.run(.fadeOut(withDuration: 0.2))
                    self.redLine.removeFromParent()
                    self.redLine = nil
                }
            }
        ]))
    }
    
    func checkRedLine() -> Bool {
        for fruit in groundFruits {
            if fruit.position.y + fruit.size.height / 2 > screen.height - 100 {
                loadRedLine()
                return true
            }
        }
        return false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

// MARK: - Collisions
extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        
        // Fruit with Ground
        handleFruitWithGround(contact)
        
        // Fruit with Fruit
        handleFruitWithFruit(contact)
    }
    
    func handleFruitWithGround(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        FruitTexture.allCases.forEach{ fruitTexture in
            if collision == fruitTexture.bitMask | groundBitMask {
                // Play sound
                groundAudio.playAudio()
            }
        }
        
    }
    
    func handleFruitWithFruit(_ contact: SKPhysicsContact) {
        if !canCollisonFruitWithFruit {
            return
        }
        
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        FruitTexture.allCases.forEach{ fruitTexture in
            if collision == fruitTexture.bitMask | fruitTexture.bitMask {
                // calculate score
                let score = fruitSlot.getMixScore(before: fruitTexture.imageName)
                
                self.score += score
                // fix repeat score bug
                canCollisonFruitWithFruit = false
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    self.canCollisonFruitWithFruit = true
                }
                
                if fruitTexture.bitMask == FruitTexture.watermelon.bitMask {
                    return
                }
                
                if fruitTexture.bitMask != FruitTexture.halfwatermelon.bitMask {
                    // common
                    explodeAudio.playAudio()
                } else {
                    // bonus
                    bonusAudio.playAudio()
                    generateBonusAnimation()
                    self.score += 100
                }
                // show
                contact.bodyA.node?.run(.sequence([
                    .fadeOut(withDuration: 0.1),
                    .removeFromParent()
                ]))
                contact.bodyB.node?.run(.sequence([
                    .fadeOut(withDuration: 0.1),
                    .removeFromParent()
                ]))
                guard let fruitName = fruitSlot.mixFruit(before: fruitTexture.imageName) else { return }
                generateNewFruit(fruitName: fruitName, position: contact.contactPoint)
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}


struct GameScene_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
