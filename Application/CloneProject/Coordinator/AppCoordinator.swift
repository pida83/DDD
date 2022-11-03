//
//  AppCoordinator.swift
//  Util
//
//  Created by inforex_imac on 2022/10/13.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
//import RealmSwift


 protocol AppCoordinatorDependencies {
    func makeHomeDIContainer() -> HomeDIContainer
    func makeHoodDIContainer() -> HoodDIContainer
    func makeAroundDIContainer() -> AroundDIContainer
    func makeChatDIContainer() -> ChatDIContainer
    func makeMypageDIContainer() -> MypageDIContainer
}

// AppCoordinator 는 디펜던시로부터 필요한 코디네이터를 받고 화면에 올려준다
 final class AppCoordinator: Coordinator {
     var childCoordinator: [Coordinator] = []
    private var coordinator : CommonTabbarController
    
    private var dependencies : AppCoordinatorDependencies
    
     init (coordinator: CommonTabbarController, dependencies: AppCoordinatorDependencies){
        self.coordinator = coordinator
        self.dependencies = dependencies
    }
    
    // 각 뷰의 DI Container를 통해 코디네이터를 받고 스타트 하자
     func start() {
        let vc1 = getNavigation()
        let vc2 = getNavigation()
        let vc3 = getNavigation()
        let vc4 = getNavigation()
        let vc5 = getNavigation()
         
        vc1.tabBarItem = UITabBarItem(title: TabItem.home.title, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        vc2.tabBarItem = UITabBarItem(title: TabItem.hood.title, image: UIImage(systemName: "menubar.rectangle"), selectedImage: UIImage(systemName: "menubar.dock.rectangle"))
        vc3.tabBarItem = UITabBarItem(title: TabItem.around.title, image: UIImage(systemName: "location.north.circle"), selectedImage: UIImage(systemName: "location.north.circle.fill"))
        vc4.tabBarItem = UITabBarItem(title: TabItem.chat.title, image: UIImage(systemName: "arrowshape.turn.up.forward.circle"), selectedImage: UIImage(systemName: "arrowshape.turn.up.forward.circle.fill"))
        vc5.tabBarItem = UITabBarItem(title: TabItem.mypage.title, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
         // 디펜던시를 통해코디 네이터 받자
        let homeDI   = self.dependencies.makeHomeDIContainer()
        let chatDI   = self.dependencies.makeChatDIContainer()
        let hoodDI   = self.dependencies.makeHoodDIContainer()
        let aroundDI = self.dependencies.makeAroundDIContainer()
        let mypageDI = self.dependencies.makeMypageDIContainer()
        
        // 결국 메인 앱코디네이터에서 하는건 코디네이터를 불러와 스타트 해주는 일이다
        let hoomCoordinator   = homeDI.makeHomeCoordinater(navigationController: vc1)
        let hoodCoordinator   = hoodDI.makeHoodCoordinator(navigationController: vc2)
        let aroundCoordinator = aroundDI.makeAroundCoordinater(navigationController: vc3)
        let chatCoordinator   = chatDI.makeChatCoordinator(navigationController: vc4)
        let mypageCoordinator = mypageDI.makeMypageCoordinator(navigationController: vc5)
        
        childCoordinator                   = [hoomCoordinator, hoodCoordinator, aroundCoordinator,  chatCoordinator, mypageCoordinator]
        coordinator.viewControllers        = [vc1, vc2, vc3, vc4, vc5]
        coordinator.modalPresentationStyle = .overFullScreen
        
        hoomCoordinator.start()
        chatCoordinator.start()
        hoodCoordinator.start()
        aroundCoordinator.start()
        mypageCoordinator.start()
        coordinator.selectedIndex = 4
    }
}

extension AppCoordinator {
    
    /**
     네비게이션컨트롤러를 생성한다
     - Parameters: -
     - Returns: UINavigationController
     */
    func getNavigation() -> UINavigationController{
        let navigation = UINavigationController()
            navigation.setToolbarHidden(true, animated: false)
            navigation.setNavigationBarHidden(true, animated: false)
        navigation.navigationBar.isTranslucent = false
        
        return navigation
    }
}
