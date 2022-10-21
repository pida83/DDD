//
//  MainDiContainer.swift
//  Util
//
//  Created by inforex_imac on 2022/10/13.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit



// 각 계층의 클래스는 DIContainer에 의존적이지 않으며 의존성 주입과 생성자의 역할만 한다
final class AppDIContainer: DIContainer {
    init() { }
    
//    // MARK: Repository

//    // MARK: Usecases

//    // MARK: ViewModel
    
    
    
    func makeAppController() -> CommonTabbarController {
        return CommonTabbarController()
    }
    
}


// DIContainer를 만들어 주는데 의존성이 필요하다면 주입해준다 ( ex: 특정 네트워크 모듈 이라던가 ...)
extension AppDIContainer : AppCoordinatorDependencies {
    func makeHomeDIContainer() -> HomeDIContainer {
        .init()
    }
    
    func makeHoodDIContainer() -> HoodDIContainer {
        .init()
    }
    
    func makeAroundDIContainer() -> AroundDIContainer {
        .init()
    }
    
    func makeChatDIContainer() -> ChatDIContainer {
        .init()
    }
    
    func makeMypageDIContainer() -> MypageDIContainer {
        .init()
    }
}
