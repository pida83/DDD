//
//  MypageViewModel.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import Starscream
import SwiftyJSON
import RxSwift
import RxCocoa
import Alamofire




protocol MypageViewModelInput {
    func viewDidLoad()
    
    func didInputSelected(name: String)
    
    func didTapDisconnect()
}

protocol MypageViewModelOutput {
    var outModel: PublishSubject<StreamModel> {get set}
    
    var output_didUpdate : PublishSubject<Bool> {get set}
    var output_didUpdateList : PublishSubject<Bool>{get set}
    var output_name : PublishSubject<String> {get set}
    var data: [StreamModel] {get set}
    var lists : [String] {get set}
    var didScroll : Bool {get set}
}

protocol MypageViewModel: MypageViewModelInput, MypageViewModelOutput {
    var selected: String {get set}
}

class DefaultMypageViewModel: MypageViewModel {
    
    var outModel: PublishSubject<StreamModel> = .init()
    var output_didUpdate : PublishSubject<Bool> = .init()
    var output_didUpdateList : PublishSubject<Bool> = .init()
    var output_name: PublishSubject<String> = .init()
    var didScroll: Bool = false
    var lists : [String] = .init() {
        didSet {
            output_didUpdateList.onNext(true)
        }
    }

    var selected : String  = "btc" {
        didSet {
            self.reconnect()
        }
    }
    
    var data: [StreamModel] = [] {
        didSet {
            output_didUpdate.onNext(true)
        }
    }
    
    
    var counter = StreamModel()
    
    
    var socket1: WebSocket!
    var socket2: WebSocket!
    var isConnected = false
    
    var outputJSON : [JSON] = []
    
    
    // MARK: - OUTPUT
    init() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timers in
            if self!.data.count > 60 * 60 {
                self!.data.removeFirst()
            }
            
            self?.counter.appendDps()
            self?.data.append(self!.counter)
            self!.counter.resetState()
        })
        
        let req = AF.request("\(EndPoints.DEFAULT_API_URL)/ticker/24hr?type=mini")
            req.responseData { [weak self] data in
                if let data = data.data , let json = try? JSON(data: data) {
                    let ticket = json.filter{$1["symbol"].stringValue.contains("USDT")}.map{ $1["symbol"].stringValue.lowercased()}
                    self?.lists = ticket
                }
            }
    }
}

// MARK: - INPUT. View event methods
extension DefaultMypageViewModel {
    
    func viewDidLoad() {
        
        
    }
    
    func connect(){
        
        var request = URLRequest(url: URL(string: "\(EndPoints.DEFAULT_SOCKET_URL)/\(self.selected)usdt@trade")!)
            request.timeoutInterval = 5
            socket2 = WebSocket(request: request)
            socket2.delegate = self
            socket2.connect()
        
       
        
    }
    
    func didInputSelected(name: String) {
        self.selected = name.lowercased()
    }
    
    func didTapDisconnect() {
        
        
        self.socket2.disconnect()
    }
    
    func reconnect() {
        
//        print("recon")
        if self.isConnected {
            socket2.disconnect()
            
        }
        
        self.connect()
    }
}


extension DefaultMypageViewModel : WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
            self.output_name.onNext(self.selected)
            print("websocket is connected: \(headers) \(self.selected)")
            case .disconnected(let reason, let code):
                isConnected = false
//                self.socket2.connect()
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                progressJSON(JSON(parseJSON: string))
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
            print("viabilityChanged")
                break
            case .reconnectSuggested(_):
                print("recon")
            self.reconnect()
                break
            case .cancelled:
            print("cancelled")
                isConnected = false
//            self.reconnect()
            case .error(let error):
                isConnected = false
                self.reconnect()
                handleError(error)
            }
    }
    
    func progressJSON(_ data : JSON) {
        self.counter = counter.update(data: data)
            outModel.onNext(self.counter)
    }
    
    
    func handleError(_ err: Error?){
        print("error :: ")
        print(err)
    }
    
}



@propertyWrapper
struct FloorNumber {
    init(wrappedValue initialValue: Int) {
        wrappedValue = Int(floor(Double(initialValue)))
    }
    
    var wrappedValue: Int
}

//struct Archive<ValueType> {
//    init(wrappedValue initialValue: ValueType) {
//        wrappedValue = initialValue
//    }
//
//    var wrappedValue: ValueType
//}


struct StreamModel {
    @FloorNumber var upCnt : Int        = 0
    @FloorNumber var downCnt : Int      = 0
    @FloorNumber var dps : Int          = 0
    @FloorNumber var sum : Int          = 0
                 var dpsDatas : [Int] = []
    @FloorNumber var average: Int = 0
    var lastPrice: Float = 0
     var strength: Int = 0
    
    mutating func addDPS (){
        self.dps = self.dps + 1
    }
    
    fileprivate mutating func addStrenth() {
        self.strength = 0
        if dps > average {
            self.strength += 1
        }
        
        self.strength = (0...4).reduce(0) { last , next in
            return dps > average * next ? next : last
        }
        
    }
    
    mutating func setUpAndDown(_ data: JSON) {
        if data["m"].boolValue {
            upCnt += data["q"].intValue
        }
    }
    
    fileprivate mutating func setSum(_ isBuyer: Bool, _ isRaiseUp: Bool) {
        if isBuyer {
            sum -= !isRaiseUp ? 2 : 1
        }else {
            sum += isRaiseUp ? 2 : 1
        }
    }
    
    mutating func update(data: JSON) -> StreamModel {
        addDPS()
        
        addStrenth()
        
        let isRaiseUp = data["p"].floatValue > self.lastPrice
        
        setUpAndDown(data)
        
        setSum(data["m"].boolValue, isRaiseUp)
        
        self.lastPrice  = data["p"].floatValue
        
        return self
        
    }
    
    mutating func appendDps() {
        self.dpsDatas.append(self.dps)
        
        if dpsDatas.count > 60 * 60 {
            dpsDatas.removeFirst()
        }
        
        average = dpsDatas.reduce(0, +) / Int(dpsDatas.count)
        
    }
    
    mutating func resetState(){
        upCnt   = 0
        downCnt = 0
        dps     = 0
        sum     = 0
    }
}
