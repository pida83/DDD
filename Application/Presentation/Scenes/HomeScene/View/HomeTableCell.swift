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

struct HomeCellLayoutModel {
    let imageView: UIImageView = .init(frame: .zero).then{$0.backgroundColor = .red}
    let titleLabel: UILabel    = .init(frame: .zero).then{
        $0.backgroundColor = .red
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    let commentLabel: UILabel  = .init(frame: .zero).then{
        $0.backgroundColor = .red
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    let priceLabel: UILabel    = .init(frame: .zero).then{
        $0.numberOfLines = 0
        $0.backgroundColor = .red
        $0.font = UIFont.systemFont(ofSize: 18)
    }
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
        [bottomLine, imageView, titleLabel, commentLabel, priceLabel].forEach(parent.addSubview)
    }
    
    func setConstraint(parent: UIView) {
        bottomLine.snp.makeConstraints{
            $0.height.equalTo(0.3)
            $0.left.equalTo(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(0.3)
        }
        
        imageView.snp.makeConstraints{
            $0.width.height.equalTo(100)
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(imageView.snp.right).offset(20)
            $0.right.equalToSuperview()
        }

        commentLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalTo(imageView.snp.right).offset(20)
            $0.right.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(commentLabel.snp.bottom).offset(5)
            $0.left.equalTo(imageView.snp.right).offset(20)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
}

class HomeTableCell: UITableViewCell {
    static let identifier = description()
    
    typealias CellDataType  = (model: Product, row: Int, cellHeight: CGFloat)
    
    var layoutModel : HomeCellLayoutModel = HomeCellLayoutModel()
    
    
    var cellHeight: CGFloat!
    var model: Product!
    
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
        backgroundColor = .clear
        
    }
    
    func setConstraint(){
        
    }
    
    func setData(data: CellDataType) {
        print(#function)
//        layoutModel.cellHeight = data.cellHeight
        
        model = data.model
        
        layoutModel.titleLabel.text   = model.comment
        layoutModel.commentLabel.text = model.comment
        layoutModel.priceLabel.text   = model.comment + model.comment + model.comment + model.comment + model.comment + model.comment + model.comment
    }
}

