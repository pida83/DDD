//
//  Dependencies.swift
//  Config
//
//  Created by cheonsong on 2022/09/05.
//

import ProjectDescription
//    .binary(path: "https://dl.google.com/geosdk/GoogleMaps.json", requirement: .upToNext("6.2.1-beta"))
let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: [
            .rxSwift,
            .rxDataSources,
            .alamofire,
            .moya,
            .snapKit,
            .then,
            .kingfisher,
            .lottie,
            .rxKeyboard,
            .rxGesture,
            .swiftyJson,
            .toast,
            .googleGroup,
            .naverGroup,
            .realm,
            .webp,
            .sdImage,
            .dropDown
    ],
    platforms: [.iOS]
)

public extension Package {
    static let rxSwift: Package       = .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .branch("main"))
    static let rxDataSources: Package = .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources", requirement: .branch("main"))
    static let alamofire: Package     = .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .branch("master"))
    static let moya: Package          = .remote(url: "https://github.com/Moya/Moya", requirement: .branch("master"))
    static let snapKit: Package       = .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMinor(from: "5.0.1"))
    static let then: Package          = .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2.7.0"))
    static let kingfisher: Package    = .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "5.15.6"))
    static let lottie: Package        = .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .upToNextMajor(from: "3.2.1"))
    static let rxKeyboard: Package    = .remote(url: "https://github.com/RxSwiftCommunity/RxKeyboard", requirement: .upToNextMajor(from: "2.0.0"))
    static let rxGesture: Package     = .remote(url: "https://github.com/RxSwiftCommunity/RxGesture", requirement: .upToNextMajor(from: "4.0.4"))
    static let swiftyJson: Package    = .remote(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", requirement: .upToNextMajor(from: "4.0.0"))
    static let toast: Package         = .remote(url: "https://github.com/scalessec/Toast-Swift", requirement: .branch("master"))
//    static let reSwift: Package       = .remote(url: "https://github.com/ReSwift/ReSwift.git", requirement: .upToNextMajor(from: "5.0.0"))
    static let firebase: Package      = .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "9.0.0"))
//    static let dropDown: Package      = .remote(url: "https://github.com/AssistoLab/DropDown", requirement: .upToNextMajor(from: "2.3.2"))
    static let webp: Package      = .remote(url: "https://github.com/SDWebImage/SDWebImageWebPCoder.git", requirement: .upToNextMajor(from: "0.3.0"))
    static let sdImage: Package      = .remote(url: "https://github.com/SDWebImage/SDWebImage.git", requirement: .upToNextMajor(from: "5.1.0"))

        
    static let dropDown: Package      = .local(path: .relativeToRoot("LocalPackages/DropDown"))
    static let googleGroup: Package  = .local(path: .relativeToRoot("LocalPackages/GoogleGroup"))
    static let naverGroup: Package  = .local(path: .relativeToRoot("LocalPackages/NMapsMapa"))
    static let realm: Package  = .local(path: .relativeToRoot("LocalPackages/RealmSwiftPack"))
    
    
}
