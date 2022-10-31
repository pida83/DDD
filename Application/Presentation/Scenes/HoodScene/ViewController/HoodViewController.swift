//
//  HoodViewController.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import SnapKit

public class HoodViewController: UIViewController {
    
    var viewModel: HoodViewModel!
    var layoutModel: HoodLayoutModel!
    
    var vue : UIView = .init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    public static func create(with viewModel: HoodViewModel) -> HoodViewController {
        let vc = HoodViewController()
        vc.viewModel = viewModel
        vc.layoutModel = .init()
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
        layoutModel.viewDidLoad(parent: self.view)
        
        view.addSubview(vue)
        vue.snp.makeConstraints{
            $0.width.height.equalTo(100)
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        vue.backgroundColor = .white
       // UIPanGestureRecognizer는 target(ViewController)에서 drag가 감지되면 action을 실행한다.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(drag))
       // panGesture가 보는 view는 circleView가 된다.
       view.addGestureRecognizer(gesture)
    }
    
    @objc func drag(sender: UITapGestureRecognizer) {
        let view = sender.location(in: self.view)
//        self.view.convert(<#T##point: CGPoint##CGPoint#>, from: <#T##UICoordinateSpace#>)
        print(self.vue.frame.contains(view), "  ", sender.view)
    }
    
    func bind(to viewModel: HoodViewModel) {

    }
}
