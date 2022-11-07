//
//  HoodViewController.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import Charts

class HoodViewController: UIViewController {
    
    var viewModel: HoodViewModel!
    var layoutModel: HoodLayoutModel!
    var disposeBag: DisposeBag = .init()

    
    static func create(with viewModel: HoodViewModel) -> HoodViewController {
        let vc = HoodViewController()
        vc.viewModel = viewModel
        vc.layoutModel = HoodLayoutModel(actions: HoodLayoutModelAction(didConnect: vc.didConnect))
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        
        viewModel.viewDidLoad()
        layoutModel.viewDidLoad(parent: self.view)
        layoutModel.mainTable.delegate = self
        layoutModel.mainTable.dataSource = self
//        layoutModel.chartView.delegate = self
    }
    
    func didConnect(){
        self.viewModel.startProcess()
    }
    
    func setData() {
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        var unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        print("data")
        var entry : [BarChartDataEntry] = []
        
        for i in 0 ..< months.count  {
            var dat = BarChartDataEntry(x: Double(i), y: unitsSold[i])
            
            entry.append(BarChartDataEntry(x: Double(i), y: unitsSold[i]))
        }
        
        let chartDataSet = BarChartDataSet(entries: entry, label: "data")
        
        let data = BarChartData(dataSet: chartDataSet)
            data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
            data.barWidth = 0.5
        
        self.layoutModel.chartView.data = data
        self.layoutModel.chartView.fitBars = true
        self.layoutModel.chartView.backgroundColor = .white
        let xAxis = self.layoutModel.chartView.xAxis
                xAxis.labelPosition = .bottom
                xAxis.labelFont = .systemFont(ofSize: 10)
                xAxis.drawAxisLineEnabled = true
                xAxis.granularity = 1
                xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
                xAxis.setLabelCount(months.count, force: false)
//        self.layoutModel.chartView.leftAxis.enabled = false
        let leftAxis = self.layoutModel.chartView.leftAxis
                leftAxis.labelFont = .systemFont(ofSize: 10)
//                leftAxis.drawAxisLineEnabled = true
//                leftAxis.drawGridLinesEnabled = true
                leftAxis.axisMinimum = 0
                leftAxis.axisMaximum = 30
                leftAxis.granularity = 1

        let rightAxis = self.layoutModel.chartView.rightAxis
                rightAxis.enabled = true
                rightAxis.labelFont = .systemFont(ofSize: 10)
                rightAxis.drawAxisLineEnabled = true
                rightAxis.axisMinimum = 0
                rightAxis.axisMaximum = 30
                rightAxis.granularity = 1
//                rightAxis.valueFormatter = IndexAxisValueFormatter(values: months)
//                rightAxis.setLabelCount(months.count, force: false)

//        let l = self.layoutModel.chartView.legend
//                l.horizontalAlignment = .left
//                l.verticalAlignment = .bottom
//                l.orientation = .horizontal
//                l.drawInside = false
//                l.form = .square
//                l.formSize = 8
//                l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
//                l.xEntrySpace = 4
        
        //        chartView.legend = l
            layoutModel.chartView.fitBars = true
        

//                sliderX.value = 12
//                sliderY.value = 50
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.setData()
//        layoutModel.mainTable.delegate = self
//        layoutModel.mainTable.dataSource = self
        
        
        
    }
    
    func bind(to viewModel: HoodViewModel) {
        viewModel.didListUpdate.subscribe(onNext: {_ in
            self.layoutModel.mainTable.reloadData()
//            self.setData()
        }).disposed(by: disposeBag)
    }
}
extension HoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("test \(viewModel.data.count)")
        return viewModel.dataList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MypageTableCell.identifier) as? MypageTableCell else { return UITableViewCell() }
        
        let data    =  viewModel.dataList[indexPath.row]
        let row        = indexPath.row
        
        cell.setData(data: data.value, name: data.key)
        return cell
    }
}

extension HoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension HoodViewController: ChartViewDelegate {
    
}
