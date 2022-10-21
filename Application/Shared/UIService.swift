//
//  SharedConst.swift
//  CloneProjectTests
//
//  Created by inforex_imac on 2022/10/17.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
import SnapKit
import Then


public class UIService {
    public static let shared: UIService = UIService()
    
    func getUIView() -> UIView{
        return UIView(frame: .zero).then{ $0.backgroundColor = CloneProjectAsset.defaultColor.color }
    }
    
    func getUITable() -> UITableView {
        return .init(frame: .zero).then {
            $0.backgroundColor = .black
            $0.separatorStyle = .none
            $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            $0.contentInset.top = 0
            $0.rowHeight = UITableView.automaticDimension;
            $0.estimatedRowHeight = 130
            $0.allowsSelection  = false
        }
    }
    
    func getUIStackView() -> UIStackView {
        return .init(frame: .zero).then{
            $0.backgroundColor = .clear
            $0.distribution    = .fillEqually
        }
    }
    
    func getImageView(image: UIImage) -> ImageContent {
        return .init(image: image)
    }
    
}


class ImageContent : UIView  {
    
    lazy var imageView : UIImageView = .init().then{
        addSubview($0)
        $0.tintColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(image: UIImage?){
        self.init(frame: .zero)
        self.imageView.image = image
    }
    
    override func didMoveToWindow() {
        imageView.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
    }
    
}
