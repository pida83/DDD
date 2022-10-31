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


@propertyWrapper
struct FloorNumber {
    public init(wrappedValue initialValue: Int) {
        wrappedValue = Int(floor(Double(initialValue)))
    }
    
    public var wrappedValue: Int
}

//public struct Archive<ValueType> {
//    public init(wrappedValue initialValue: ValueType) {
//        wrappedValue = initialValue
//    }
//
//    public var wrappedValue: ValueType
//}


public struct StreamModel {
    @FloorNumber var upCnt : Int        = 0
    @FloorNumber var downCnt : Int      = 0
    @FloorNumber var dps : Int          = 0
    @FloorNumber var sum : Int          = 0
                 var dpsDatas : [Int] = []
    @FloorNumber var average: Int = 0
    @FloorNumber var lastPrice: Int = 0
     var howStrong: String = ""
    
    mutating func update(data: JSON) -> StreamModel {
        self.dps = self.dps + 1
        
        self.howStrong = ""
        
        let isMoreExpenciveThan : Bool = data["p"].intValue > self.lastPrice
        if isMoreExpenciveThan {
            upCnt += 1
        } else {
            downCnt += 1
        }
        
        if data["m"].boolValue {
            sum -= 1
            if !isMoreExpenciveThan {
                sum -= 1
            }
        }else {
            sum += 1
            if isMoreExpenciveThan {
                sum += 1
            }
        }
        self.lastPrice  = data["p"].intValue
        
        if dps > average {
            self.howStrong.append("*")
        }
        
        if dps > average * 2 {
            self.howStrong.append("*")
        }
        
        if dps > average * 3 {
            self.howStrong.append("*")
        }
        
        if dps > average * 4 {
            self.howStrong.append("*")
        }
        
        return self
        
    }
    
    mutating func appendDps() {
        self.dpsDatas.append(self.dps)
        
        if dpsDatas.count > 10 {
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


public protocol MypageViewModelInput {
    func viewDidLoad()
}

public protocol MypageViewModelOutput {
    var outModel: PublishSubject<StreamModel> {get set}
    var output_upCnt: BehaviorSubject<Int> {get set}
    var output_downCnt: BehaviorSubject<Int> {get set}
    var output_dps : BehaviorSubject<Int> {get set}
    var output_sum : BehaviorSubject<Int> {get set}
    var output_dpsAverage: BehaviorSubject<[Int]> {get set}
    var didUpdate : PublishSubject<Bool> {get set}
    var data: [StreamModel] {get set}
}

public protocol MypageViewModel: MypageViewModelInput, MypageViewModelOutput {
    
    
}

public class DefaultMypageViewModel: MypageViewModel {
    
    public var outModel: PublishSubject<StreamModel>         = .init()
    public var output_upCnt: BehaviorSubject<Int>          = .init(value: 0)
    public var output_downCnt: BehaviorSubject<Int>        = .init(value: 0)
    public var output_dps: BehaviorSubject<Int>            = .init(value: 0)
    public var output_sum: BehaviorSubject<Int>            = .init(value: 0)
    public var output_dpsAverage: BehaviorSubject<[Int]>  = .init(value: [])
    public var didUpdate : PublishSubject<Bool> = .init()
    
    public var data: [StreamModel] = [] {
        didSet {
            didUpdate.onNext(true)
        }
        
    }
    
    
    var counter = StreamModel()
    
    var socket1: WebSocket!
    var socket2: WebSocket!
    var isConnected = false
    
    var outputJSON : [JSON] = []
    
    
    // MARK: - OUTPUT
    public init() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            if self!.data.count > 7 {
                self!.data.removeFirst()
            }
            
            self?.counter.appendDps()
            self?.data.append(self!.counter)
            self!.counter.resetState()
            
            
        })
    }
}

// MARK: - INPUT. View event methods
extension DefaultMypageViewModel {
    public func viewDidLoad() {
        var request = URLRequest(url: URL(string: "wss://stream.binance.com:9443/ws/btcusdt@trade")!)
            request.timeoutInterval = 5
            socket2 = WebSocket(request: request)
            socket2.delegate = self
            socket2.connect()
    }
}


extension DefaultMypageViewModel : WebSocketDelegate {
    public func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
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
                break
            case .reconnectSuggested(_):
                print("recon")
                break
            case .cancelled:
                isConnected = false
            case .error(let error):
                isConnected = false
                self.socket2.connect()
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
