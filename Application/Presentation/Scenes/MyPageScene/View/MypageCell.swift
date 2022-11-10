//
//  HomeTableCell.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/19.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
import SnapKit
import Then

struct MypageCellLayoutModel {
//    let imageView: UIImageView = .init(frame: .zero).then{$0.backgroundColor = .red}
//    let titleLabel: UILabel    = .init(frame: .zero).then{
//        $0.backgroundColor = .red
//        $0.font = UIFont.systemFont(ofSize: 15)
//    }
    let commentLabel: UILabel  = .init(frame: .zero).then{
        $0.backgroundColor = .clear
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
//    let priceLabel: UILabel    = .init(frame: .zero).then{
//        $0.numberOfLines = 0
//        $0.backgroundColor = .red
//        $0.font = UIFont.systemFont(ofSize: 18)
//    }
//
    var bottomLine: UIView = .init(frame: .zero).then{ $0.backgroundColor = .white.withAlphaComponent(0.5)}
    var cellHeight : CGFloat = 0
    init() {
        
    }
    
    func viewDidLoad(parent: UIView) {
        parent.backgroundColor = .clear
        setLayout(parent: parent)
        setConstraint(parent: parent)
    }
    
    func setLayout(parent: UIView){
        [bottomLine, commentLabel].forEach(parent.addSubview)
    }
    
    func setConstraint(parent: UIView) {
        bottomLine.snp.makeConstraints{
            $0.height.equalTo(0.3)
            $0.left.equalTo(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(0.3)
        }
        
        commentLabel.snp.makeConstraints{
//            $0.height.equalTo(80)
//            $0.top.left.right.equalToSuperview().inset(10)
            $0.edges.equalToSuperview().inset(10)
        }
        
    }
    
}

class MypageTableCell: UITableViewCell {
    static let identifier = description()
    
//    typealias CellDataType  = StreamModel
    
    var layoutModel : MypageCellLayoutModel = MypageCellLayoutModel()
    
    
    var cellHeight: CGFloat!
    var model: StreamModel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model      = nil
        cellHeight = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        layoutModel.viewDidLoad(parent: contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setLayout(){
        backgroundColor = .black
        
    }
    
    func setConstraint(){
        
    }
    
    func setData(data: StreamModel, name: String) {
//        layoutModel.cellHeight = height
        
        model = data
        let sum       = "\(data.sum)".leftPadding(toLength: 5, withPad: "  ")
        let dps       = "\(data.dps)".leftPadding(toLength: 5, withPad: "  ")
        let average   = "\(data.average)".leftPadding(toLength: 5, withPad: "  ")
        let strength   = String(repeating: "*", count: data.strength).leftPadding(toLength: 5, withPad: "  ")
        
        let check     = "\(data.sum > data.average ? "+" : "")"
        let outputText = "[\(data.lastPrice)] [d:\(dps)] [b:\(data.upCnt)] [av:\(average) \(strength)]"
        
        layoutModel.commentLabel.text = outputText
        layoutModel.commentLabel.textColor = data.sum < 1 ? .red : .white
        var color: UIColor = .clear
        
        if data.strength > 3 || check == "+" {
            if data.sum < 1 {
                color = .red
            } else {
                color = .white
            }
        }

        
        self.contentView.layer.borderColor = color.cgColor
        self.contentView.layer.borderWidth = 2
        
//        backgroundColor = color
        
//        layoutModel.titleLabel.text   = model.comment
//        layoutModel.commentLabel.text = model.comment
//        layoutModel.priceLabel.text   = model.comment + model.comment + model.comment + model.comment + model.comment + model.comment + model.comment
    }
}

