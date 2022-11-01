//
//  GameScene.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/20.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import SpriteKit
import Then
import Lottie
import SDWebImage


struct GameAction {
    let addView: ((CGPoint) -> Void)
}

class GameScene : SKScene {
    
    var gameAction: GameAction!
    
    let eggA = SKSpriteNode(imageNamed: "egg1").then{$0.name = "egg1"} // 분홍
    let eggB = SKSpriteNode(imageNamed: "egg2").then{$0.name = "egg2"} // 파랑
    let eggC = SKSpriteNode(imageNamed: "egg3").then{$0.name = "egg3"} // 노랑
    
    lazy var nodeQueue = [eggA, eggB , eggC]
    var bgObject = SKNode()

    func createGround() {
        let groundTexture = SKTexture(imageNamed: "egg1")
        print("\(#function) \(self.size)")
        for i in 0 ..< 1{
            let ground = SKSpriteNode(texture: groundTexture)
            
            ground.zPosition = -10
            ground.position = .init(x: 0, y: 0)
            ground.position = CGPoint(x: (groundTexture.size().width / 2.0 + (groundTexture.size().width * CGFloat(i))), y: groundTexture.size().height / 2)
            
            addChild(ground)

            let moveLeft = SKAction.moveBy(x: -ground.size.width, y: 0, duration: 3)
            let moveReset = SKAction.moveBy(x: ground.size.width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)

            ground.run(moveForever)
        }
    }
    
    override func sceneDidLoad() {
        print("\(#function) \(self.size)")
        createGround()
    }
        
//    override func didFinishUpdate() {
//        print("\(#function) \(self.size)")
//    }
    
    override func didMove(to view: SKView) {
//        print(#function)
        anchorPoint = .init(x: 0.5, y: 0.5)
        eggA.anchorPoint = .init(x: 0.5, y: 0.5)
        eggC.anchorPoint = .init(x: 0.5, y: 0.5)
        physicsWorld.gravity = CGVector(dx:0, dy: -3);
        physicsWorld.contactDelegate = self
        
        
        
//
//        eggA.size = .init(width: 100, height: 100)
//        eggC.size = .init(width: 100, height: 100)
//        let gravityVector = vector_float3(0,-3,0);
//        let gravityNode = SKFieldNode.linearGravityField(withVector: gravityVector)
//
//
//        gravityNode.strength = 1.5
//        gravityNode.zRotation = CGFloat.pi // Flip gravity.
////        gravityNode.categoryBitMask = 0x1 << 0
//
//
//        var splinePoints = [CGPoint(x: -100, y: 100), CGPoint(x: 100, y: 100),
//                            CGPoint(x: 100, y: -100), CGPoint(x: 100, y: 100)
//                            ]
//
////        let ground = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 100, height: 30))
//////        SKShapeNode(splinePoints: &splinePoints,
//////                                 count: splinePoints.count)
////        ground.name = "ground"
////        ground.lineWidth = 5
////        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.frame.size)
//////        SKPhysicsBody(edgeChainFrom: ground.path!)
////        ground.physicsBody?.restitution = 1.0
////        ground.physicsBody?.isDynamic = false
//        eggC.physicsBody = SKPhysicsBody(rectangleOf: eggC.frame.size)
//        eggC.physicsBody?.restitution = 1.0
//        eggC.physicsBody?.isDynamic = false
////        addChild(ground)
//        addChild(gravityNode)
//        addChild(eggA)
////        let data = try! Data(contentsOf: Bundle.main.url(forResource: "coin_ani_01", withExtension: "webp")!)
////        let txtu = SKTexture(data: data, size: .init(width: 50.0, height: 50.0))
//
//
//        eggC.position = .init(x: 0, y: 0)
//
////        var vue : UIImageView = .init()
////            vue.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
////        vue.sd_setImage(with: URL(string: "http://littlesvr.ca/apng/images/SteamEngine.webp")){ img , err ,_,_ in
////            self.eggA.texture = SKTexture(image: img!)
////            print(img)
////            print(err)
////        }
////
////        self.view?.addSubview(vue)
//
//
//
//
//        eggA.physicsBody = SKPhysicsBody(texture: eggA.texture!, size: eggA.texture!.size())
//
////        eggA.physicsBody?.categoryBitMask = 32
////        eggA.physicsBody?.collisionBitMask =  32
////        eggC.physicsBody?.categoryBitMask = 32
////        eggC.physicsBody?.collisionBitMask =  32
//
//
//        eggA.physicsBody?.contactTestBitMask = 32
////        eggC.physicsBody?.contactTestBitMask = 32
//
////        eggA.physicsBody?.isDynamic = false
////        eggA.physicsBody?.affectedByGravity = true
//
//
////        physicsWorld.contactDelegate = self
////        physicsWorld.gravity = .init(dx: 0.0, dy: 0.3)
////        physicsWorld.speed = 1
////        let defaultX = eggA.size.width / 2
////        let defaultY = eggA.size.height / 2
//
////        eggA.position = .init(x: -eggA.size.width, y: 0)
////        eggB.position = .init(x: -eggA.size.width, y: -100)
////        eggC.position = .init(x: -eggA.size.width, y: -200)
//        // 포지션은 대상의 센터를 기준으로 한다
////        eggA.position = .init(x: defaultX, y: defaultY)  // 분홍
////        eggB.position = .init(x: size.width / 2, y: defaultY * 3) // 파랑
////        eggC.position = .init(x: size.width - defaultX, y: defaultY) // 노랑
//
//
////        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
////        let actionRotate = SKAction.rotate(byAngle: .pi, duration: actualDuration)
////        let gravityVector = vector_float3(0,-1,0);
////        let gravityNode = SKFieldNode.linearGravityField(withVector: gravityVector)
////
////        gravityNode.strength = 9.8
////
////        addChild(gravityNode)
//
//
//               // 중앙 상단으로 세팅
////        snowNode.isUserInteractionEnabled = false
////        snowNode.targetNode = eggA
////        snowNode.position = CGPointMake(-10, -10);
////        snowNode.targetNode = self
////        snowNode.zPosition = -1
//
//        self.addChild(eggC)
////        self.addChild(eggB)
//
//
////        let shield = SKFieldNode.radialGravityField()
//////        shield.strength = 5
////        shield.categoryBitMask = 0x1 << 1
////        shield.region = SKRegion(radius: 100)
////        shield.falloff = 4
////        shield.run(SKAction.sequence([
////            SKAction.strength(to: 0, duration: 2.0),
////            SKAction.removeFromParent()
////            ]))
////        eggA.addChild(shield)
////        eggA.physicsBody = SKPhysicsBody(circleOfRadius: eggA.size.width)
////        eggA.physicsBody?.categoryBitMask = 0x1 << 1
//
////        eggA.run(
////            SKAction.moveTo(x: -100, duration: 3)
////        )
////        eggA.physicsBody?.collisionBitMask = UInt32.max
//
//
////        eggA.run(
////                                    SKAction.group([
////                                        SKAction.moveTo(y: -100, duration: 3),
////                                        SKAction.strength(to: 0, duration: 3)
////
////                                    ])
//
//
//
////            SKAction.group([
////                SKAction.moveTo(y: -100, duration: 4),
////                SKAction.repeatForever(
////                    SKAction.group([
//////                        SKAction.sequence([
//////                            SKAction.scale(to: 0.9, duration: 1),
//////                            SKAction.scale(to: 1, duration: 1),
//////                            SKAction.scale(to: 1.1, duration: 1),
//////                        ]),
////                        SKAction.strength(to: 0, duration: 3),
////                        SKAction.sequence([
////                            SKAction.group([SKAction.scale(to: 0.9, duration: 1),
////                                            SKAction.moveTo(x: eggA.position.x - 10, duration: 1)]),
////
////                            SKAction.group([
////                                SKAction.scale(to: 1, duration: 1),
////                                SKAction.moveTo(x: eggA.position.x , duration: 1),
////                            ]),
////
////                            SKAction.group([
////                                SKAction.scale(to: 1.1, duration: 1),
////                                SKAction.moveTo(x: eggA.position.x + 10, duration: 1),
////                            ]),
////                            SKAction.moveTo(x: eggA.position.x , duration: 1),
////
////                        ])
////                    ])
////
////                )
////            ])
////        )
////        let gravityCategory: UInt32 = 0x1 << 0
////        let shieldCategory: UInt32 = 0x1 << 1
////
////        let gravity = SKFieldNode.radialGravityField()
////        gravity.strength = 10
////        gravity.categoryBitMask = gravityCategory
////        addChild(gravity)
////
////        let gravity2 = SKFieldNode.radialGravityField()
////        gravity2.strength = 3
////        gravity2.categoryBitMask = shieldCategory
////        eggA.physicsBody?.fieldBitMask = shieldCategory
////
////
////        eggB.physicsBody?.fieldBitMask = gravityCategory
////        ...
////        missile.physicsBody?.fieldBitMask = shieldCategory
//
////        let shieldCategory: UInt32 = 0x1 << 1
////        let shield = SKFieldNode.radialGravityField()
////        shield.strength = 1
////        shield.categoryBitMask = shieldCategory
////        shield.region = SKRegion(radius: 100)
////        shield.falloff = 4
//////        shield.run(SKAction.strength(to: 0, duration: 5.0))
////        addChild(shield)
//
//
//
////        eggB.run(
////            SKAction.sequence([
//////                SKAction.moveTo(y: eggA.position.x + 500, duration: 3),
////                SKAction.strength(to: 0, duration: 3),
////                SKAction.removeFromParent()
////            ])
////        )
////
////        eggC.run(
////            SKAction.moveTo(y: eggA.position.x - 500, duration: 3)
////        )
//
//
//
////        eggA.run(SKAction.repeatForever(
////          SKAction.sequence([
////            actionRotate
//////            SKAction.run(addeggA),
//////            SKAction.wait(forDuration: 1.0)
////          ])
////        ))
        
    }
    
    func addeggA(){
        let eggA = SKSpriteNode(imageNamed: "eggA")
        
            eggA.size = .init(width: 300 , height: 300)
            eggA.position = .init(x: size.width / 2, y: size.height / 2)
        
        let actualY = random(min: 50, max: size.height - 50/2)
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Determine speed of the eggA
        // Create the actions
        let actionRotate = SKAction.rotate(byAngle: .pi, duration: TimeInterval(actualDuration))
//        let actionMoveDone = SKAction.removeFromParent()
        
        self.addChild(eggA)
        
        eggA.run(SKAction.sequence([actionRotate]))
    }
    
    
    func random() -> CGFloat {
      return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(#function) \(self.size)")
//        print(#function)
        
//        eggA.isPaused = true
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(#function)
//        eggA.isPaused = false
//        eggA.position = .init(x: 0, y: 0)
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
//        let touchNode = nodes(at: location)
        let nodeName = atPoint(location).name
        
        if let selectedNode = nodeName, let node = childNode(withName: selectedNode) , nodeName != "ground" {
//            print("shake")
            node.zPosition = 1
//            gameAction.addView(touch.location(in: self.view))
            gameAction.addView(node.position)
            shakeNode(layer: node, duration: 0.5)
//            node.run(shake(initialPosition: node.position , duration: 3.0))
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(#function)
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        let touchNode = nodes(at: location)
//        print(touchNode)
        let nodeName = atPoint(location).name
        
        if let selectedNode = nodeName, let node = childNode(withName: selectedNode) {
//            print("shake")
            node.position = location
            
        }
    }
    
    func shakeNode(layer : SKNode, duration : Float){
        let amplitudeX:Float = 10;
            let amplitudeY:Float = 6;
            let numberOfShakes = duration / 0.04;
            var actionsArray:[SKAction] = [];
            for _ in 1...Int(numberOfShakes) {
                let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
                let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
                let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02)
                    shakeAction.timingMode = SKActionTimingMode.easeOut
                    actionsArray.append(shakeAction);
                    actionsArray.append(shakeAction.reversed())
            }
//        let run = snowNode.run(SKAction.fadeIn(withDuration: 3))
//

            let actionSeq = SKAction.sequence(actionsArray)
        layer.run(actionSeq)
    }
    
    func shake(initialPosition:CGPoint, duration: Float, amplitudeX:Int = 12, amplitudeY:Int = 3) -> SKAction {
        
            let startingX = initialPosition.x
            let startingY = initialPosition.y
            let numberOfShakes = duration / 0.015
            var actionsArray:[SKAction] = []
        
            for index in 1...Int(numberOfShakes) {
                let newXPos = startingX + CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
                let newYPos = startingY + CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
                actionsArray.append(SKAction.move(to: CGPointMake(newXPos, newYPos), duration: 0.015))
            }
        
            actionsArray.append(SKAction.move(to:initialPosition, duration: 0.015))
            return SKAction.sequence(actionsArray)
        }
    
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
//        print(#function)
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
//        print(#function)
    }
    
}
