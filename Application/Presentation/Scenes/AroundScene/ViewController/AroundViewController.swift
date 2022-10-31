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
import SnapKit
import Then
import SwiftProtobuf


//import Lottie

public class AroundViewController: UIViewController {
    let vue = UIImageView(image: UIImage(named: "Particle"))
    var viewModel: AroundViewModel!
    var layoutModel: AroundLayoutModel!
    let img: UIImageView = .init()
    let restartBtn: UIButton = .init(frame: .zero).then{
        $0.setTitle("재시작", for: .normal)
        $0.backgroundColor = .red
    }
    
    public static func create(with viewModel: AroundViewModel) -> AroundViewController {
        let vc = AroundViewController()
        vc.viewModel = viewModel
        vc.layoutModel = .init()
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
//        let manager = SocketManager(socketURL: URL(string: "::5001")!, config: [.compress, .log(true), .reconnects(true)])
//            manager.defaultSocket.connect()
//        manager.defaultSocket.onAny{
//            print($0)
//        }
        
        let WebPCoder = SDImageWebPCoder.shared
            SDImageCodersManager.shared.addCoder(WebPCoder)
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        layoutModel.viewDidLoad(parent: self.view)
           
        restart()
        
        self.view.addSubview(self.restartBtn)
        restartBtn.snp.makeConstraints{
            $0.width.equalTo(50)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-100)
        }
        restartBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(restart)))
        
        
        var info = BookInfo()
        info.id = 1
        info.title = "test"
        info.author = "tat1"
        do {
            let binaryData: Data = try info.serializedData()
            
            let decode = try BookInfo(serializedData: binaryData)
            let json = try info.jsonUTF8Data()
            let recevedFrom = try BookInfo(jsonUTF8Data: json)
//            manager.defaultSocket.emit("data", with: [binaryData])
//            dump(binaryData)
//            print("binary", binaryData)
//            print("decoded", decode)
//            print("json", json)
//            print("receved", recevedFrom)
            
        } catch let err {
            print(err.localizedDescription)
        }
        
        self.layoutModel.skView.showsFPS = true
        self.layoutModel.skView.showsNodeCount = true
        self.layoutModel.skView.ignoresSiblingOrder = true
        self.layoutModel.skView.showsPhysics = true
        self.layoutModel.skView.showsFields = true
    }
    
    @objc func restart() {
        self.layoutModel.skView.scene?.removeFromParent()
        self.layoutModel.skView.subviews.forEach{
            $0.removeFromSuperview()
        }
        
        let scene = GameScene(size: view.bounds.size)
            scene.gameAction = .init(addView: setView)
            scene.scaleMode = .resizeFill
        self.layoutModel.skView.presentScene(scene)
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setView(position: CGPoint) {
        print("action \(position)")
        let coinSize = CGSize(width: 80, height: 80)

            // skview 오프젝트 y 포지션은 오브젝트 포지션의 위치를 기준으로 오프젝트가 위로가면 양수 밑으로 가면 음수이다
            let xx = self.layoutModel.skView.center.x + position.x - (coinSize.width / 2)
            let yy = self.layoutModel.skView.center.y + (-position.y) - (coinSize.height / 2)
            
            let img: UIImageView = .init()
                img.sd_setImage(with: Bundle.main.url(forResource: "coin_ani_01", withExtension: "webp") )
        
        self.layoutModel.skView.addSubview(img)
        img.frame = .init(origin: .init(x: xx, y: yy), size: coinSize)
    }
    
    func bind(to viewModel: AroundViewModel) {

    }
}
