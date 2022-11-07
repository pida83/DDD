//
//  ChatViewController.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import GRPC
import Starscream
import SwiftProtobuf
import NIO

class ChatViewController: UIViewController {
    
    var viewModel: ChatViewModel!
    var layoutModel: ChatLayoutModel!
    var disposeBag: DisposeBag = .init()
    var tcp : TCPTransport!
    
    static func create(with viewModel: ChatViewModel) -> ChatViewController {
        let vc = ChatViewController()
        vc.viewModel = viewModel
        vc.layoutModel = .init()
        return vc
    }
    
    func testAsync() async {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            
        }
        tcp = TCPTransport(connection: .init(host: .init("localhost"), port: .init("5001")!, using: .tcp))
        tcp.register(delegate: self)
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        layoutModel.viewDidLoad(parent: self.view)
        
            
        
        actions()
        
        
//        let clent = TCPClient(address: "localhost", port: 5001)
//
//        let connectStatus = clent.connect(timeout: 10)
//
//        switch connectStatus {
//        case .success:
//            print("success")
//        case .failure(let err):
//            print(err)
//        }
        
        
    }
    
    func actions() {
        self.layoutModel.sendBtn.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                // 약한참조 처리
                guard let `self` = self else {
                    return
                }
                
                var note = Note()
                note.id = "1"
                note.title = "title"
                note.content = "test"
                
                
                let group   = MultiThreadedEventLoopGroup(numberOfThreads: 1)
                let channel = ClientConnection.insecure(group: group).connect(host: "localhost", port: 5001)
                let client  = NoteServiceNIOClient(channel: channel)
                
                let req = NoteRequestId.with{
                    $0.id = "1"
                }
                
                
                var info = BookInfo()
                    info.id = 1
                    info.title = "test"
                    info.author = "tat1"
                do {
                    let binaryData: Data = try info.serializedData()
                    
                    let decode = try BookInfo(serializedData: binaryData)
                    let json = try info.jsonUTF8Data()
                    let recevedFrom = try BookInfo(jsonUTF8Data: json)
                    self.tcp.write(data: binaryData){ error in
                        print("error \(error)")
                    }
                    
        //            manager.defaultSocket.emit("data", with: [binaryData])
        //            dump(binaryData)
        //            print("binary", binaryData)
        //            print("decoded", decode)
        //            print("json", json)
        //            print("receved", recevedFrom)
                    
                } catch let err {
                    print(err.localizedDescription)
                }
            })
            .disposed(by: disposeBag)
    }
    func bind(to viewModel: ChatViewModel) {

    }
}
extension ChatViewController: TransportEventClient {
    func connectionChanged(state: Starscream.ConnectionState) {
        switch state {
        case .connected:
            print("connected")
        case .cancelled:
            print("cancell")
        case .failed(let err):
            print(err)
        case .receive(let data):
            print(data)
        case .waiting:
            print("waiting")
        case .viability(let isViability):
            print("viability \(isViability)")
        case .shouldReconnect(let isConn):
            print("shouldReconnect \(isConn)")
        }
    }
    
    
}
