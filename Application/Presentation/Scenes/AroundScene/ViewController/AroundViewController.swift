//
//  AroundViewController.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import SDWebImageWebPCoder
import SDWebImage

//import Lottie

public class AroundViewController: UIViewController {
    let vue = UIImageView(image: UIImage(named: "Particle"))
    var viewModel: AroundViewModel!
    var layoutModel: AroundLayoutModel!
    let img: UIImageView = .init()
    public static func create(with viewModel: AroundViewModel) -> AroundViewController {
        let vc = AroundViewController()
        vc.viewModel = viewModel
        vc.layoutModel = .init()
        return vc
    }
    
//    public override func loadView() {
//        self.view = layoutModel.skView
//
//        super.loadView()
//
//    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let WebPCoder = SDImageWebPCoder.shared
            SDImageCodersManager.shared.addCoder(WebPCoder)
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        layoutModel.viewDidLoad(parent: self.view)
        let scene = GameScene(size: view.bounds.size)
            scene.gameAction = .init(addView: setView)
        
        
        scene.scaleMode = .resizeFill
        self.layoutModel.skView.presentScene(scene)


        
        
        
//        img.image = UIImage(data: try! )
//        img.sd_setImage(with: )
        
//            img.sd_setImage(with: Bundle.main.url(forResource: "coin_ani_03", withExtension: "webp"))

//        print(img)
        
//        self.layoutModel.skView.showsFPS = true
//        self.layoutModel.skView.showsNodeCount = true
//        self.layoutModel.skView.ignoresSiblingOrder = true
//        self.layoutModel.skView.showsPhysics = true
//        self.layoutModel.skView.showsFields = true
        
        
        
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setView(position: CGPoint) {
        
        print("action \(position) \(self.view.frame.width / 2) \(self.view.frame.height / 2)")
        
//        let x = self.layoutModel.skView.frame.width / 2 + position.x
//        let y = self.layoutModel.skView.frame.height / 2 + position.y
        
        let xx = (self.view.frame.width / 2) + position.x - 25
        let yy = (self.view.frame.height / 2) - position.y - 100
        print(self.view.center)
        
        
            let img: UIImageView = .init()
                img.sd_setImage(with: Bundle.main.url(forResource: "coin_ani_01", withExtension: "webp") )
        self.layoutModel.skView.addSubview(img)
        img.frame = .init(origin: .init(x: xx, y: yy), size: .init(width: 50, height: 50))
        
    }
    
    func bind(to viewModel: AroundViewModel) {

    }
}
