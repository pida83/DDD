//
//  HoodViewModel.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa
import Starscream

protocol HoodViewModelInput {
    func viewDidLoad()
    func startProcess()
}

protocol HoodViewModelOutput {
    var list : [JSON] {get set}
    var didListUpdate : PublishSubject<Void> {get set}
//    var stateData : [String: StreamModel] {get set}
    var dataList: [(key: String , value: StreamModel)] {get set}
}

protocol HoodViewModel: HoodViewModelInput, HoodViewModelOutput {
    
    
}

class DefaultHoodViewModel: HoodViewModel {
    var list : [JSON] = [] {
        didSet {
            listProcess()
        }
    }
    var map: [String] = []
    let apiEndPoint = "\(EndPoints.DEFAULT_API_URL)/ticker/24hr?type=MINI"
//    lazy var socketURLEndpoint = "wss://stream.binance.com:9443/ws/\(self.selected.lowercased())@trade"
    var isConnected : Bool = false
    var socket: [WebSocket] = []
    var combineSocket: WebSocket!
    var modelData: StreamModel = .init()
    
    var stateData : [String: StreamModel] = [:]
    
    var dataList: [(key: String , value: StreamModel)] = [] {
        didSet {
            didListUpdate.onNext(())
        }
    }
    
    var selected: String = "bttc" {
        didSet {
            connect()
        }
    }
    
    var didListUpdate : PublishSubject<Void> = .init()
    
    // MARK: - OUTPUT
    init() {
            
    }
    
    func listProcess() {
        if list.count < 1 {
            print(self.stateData.count)
            return
        }
        let map = list.map{
            $0["symbol"].stringValue.lowercased() + "@aggTrade"
        }
        self.map = map
        print(self.map)
        connect()
//        let symbol = list.removeFirst()["symbol"].stringValue
//        self.selected = symbol
        
    }
    
    
    
    func connect(){
        print("connect")
        // 소켓을 연결해보자
//        var request = URLRequest(url: URL(string: "\(EndPoints.DEFAULT_SOCKET_URL)/\(self.selected.lowercased())@trade")!)
        var request = URLRequest(url: URL(string: "\(EndPoints.DEFAULT_SOCKET_URL)/")!)
            request.timeoutInterval = 5
        
        let socket = WebSocket(request: request)
            socket.delegate = self
            socket.connect()
        
//        self.socket.append(socket)
        self.combineSocket = socket
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: disconnect(timer:))
    }
    
    func disconnect(timer: Timer? = nil) {
        self.combineSocket.disconnect()
        self.dataList = stateData.map{(key: $0.key.lowercased() , value: $0.value)}
            .sorted(by: { first, second in
            first.value.dps > second.value.dps
        })
//        if self.isConnected != false {
//            socket.removeFirst().disconnect()
//            if timer != nil, socket.count < 1 {
//
//                self.dataList = stateData.map{(key: $0.key.lowercased() , value: $0.value)}
//                    .sorted(by: { first, second in
//                    first.value.dps > second.value.dps
//                })
//            }
//
//        }
    }
}

// MARK: - INPUT. View event methods
extension DefaultHoodViewModel {
    func viewDidLoad() {
        
//        startProcess()
        
    }
    
    func startProcess(){
        self.stateData = [:]
        self.dataList = []
        let req = AF.request(apiEndPoint)
            req.responseData { [weak self] data in
                if let data = data.data , let json = try? JSON(data: data) {
                    let ticker = json.filter{
                        !$1["symbol"].stringValue.contains("BUSD") &&
                        $1["symbol"].stringValue.contains("USDT") &&
                        $1["symbol"].stringValue.hasSuffix("USDT")
                    }.map{$1}
                     .sorted(by: {$0["quoteVolume"].floatValue > $1["quoteVolume"].floatValue })
                    self?.list = ticker[0 ... 14].map{$0}
//                    self?.listProcess()
                }
            }
    }
}
extension DefaultHoodViewModel: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
            case .connected(let headers):
                self.isConnected = true
                print("websocket is connected aa: \(headers)")
            let data : [String: Any] = ["method": "SUBSCRIBE",
                                        "params": map,
                                        "id": 1]
            
            guard let dat = try? JSON(data).rawString() else {
                return
            }
            
            self.combineSocket.write(string: dat)
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
            case .disconnected(let reason, let code):
            self.isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .reconnectSuggested(_):
            self.isConnected = false
                print("recon")
            case .cancelled:
                print("cancelled")
            self.isConnected = false
            case .error(let error):
                print("error")
            self.isConnected = false
            }
    }
    
    func progressJSON(_ data : JSON) {
        if data["result"].exists() {
            return
        }
        print(data)
        if self.stateData[data["s"].stringValue] == nil {
            self.stateData[data["s"].stringValue] = .init()
            self.stateData[data["s"].stringValue]?.update(data: data)
        } else {
            self.stateData[data["s"].stringValue] = self.stateData[data["s"].stringValue]?.update(data: data)
        }
        
        
        
//        if self.stateData[data["symbol"].stringValue]
//        self.stateData[data["symbol"].stringValue] = self.modelData
//        self.modelData = modelData.update(data: data)
    }
    
    
}
