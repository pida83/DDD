import ProjectDescription
import ProjectDescriptionHelpers


var projectName : String { return "CloneProject" }
var projectPath: String { return "Application"}
var platform : Platform { return .iOS}
var bundleID : String { return "com.test"}
var infoList : ProjectDescription.InfoPlist { return .file(path: .relativeToRoot("Supporting Files/Info.plist"))}

//    .compactMap{$0.target.compactMap{$0}}
let project: Project = Project(
    name: projectName,
    organizationName: "Yeoboya",
    targets:
        CloneProject.allCases.flatMap{$0.target}
//        CloneModule.allCases.flatMap{
//        return $0.target
//    }
)


enum CloneProject: String, CaseIterable {
    case project = "CloneProject"
    
    var value: String {
        return self.rawValue.capitalized
    }
    
    var target : [Target] {
        switch self {
        case .project:
            fallthrough
        default :
            let cases = CloneModule.allCases.map{
                return TargetDependency.target(name: $0.value)
            }
            
            return makeProjectTarget(name: projectName, bundleID: bundleID, platform: platform, path: projectPath, dependencies: [.tcpSocket, .rxSwift, .rxCocoa, .rxGesture, .lottie, .rxRelay, .rxDataSources, .then, .snapKit, .swiftyJson, .toast, .alamofire, .googleGroup, .moya, .naverGroup, .realm, .dropDown, .webp, .sdImage, .protoBuffer, .starScream, .grpc, .sChart])
        }
    }
    
    func makeProjectTarget(name : String, bundleID: String , platform: ProjectDescription.Platform, path : String, dependencies : [ProjectDescription.TargetDependency]) -> [Target] {
        let base = SettingsDictionary().automaticCodeSigning(devTeam: "GP9D94CZ57").otherLinkerFlags(["-ObjC"])
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(bundleID).\(name)",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.ipad, .iphone]),
            infoPlist: infoList,
            sources: ["\(path)/**"],
            resources: ["\(path)/**"],
            dependencies: dependencies,
            settings: .settings(
                base: base,
                defaultSettings: .recommended
            )
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(bundleID).\(name)Tests",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.ipad, .iphone]),
            infoPlist: infoList,
            sources: ["\(path)/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
        ])
        return [mainTarget, testTarget]
    }
}

// 프레임 워크는 그냥 이렇게
enum CloneModule: String, CaseIterable {
    case tcpSocket = "TCPSocket"
    
    var value : String {
        return self.rawValue.capitalized
    }
    
    var target : [Target] {
        switch self {
        case .tcpSocket:
            fallthrough
        default:
            return makeFramework(name: self.value, bundleID: bundleID, platform: platform, path: projectPath, dependencies: [])
        }
    }
    
    func makeFramework(name : String, bundleID: String , platform: ProjectDescription.Platform, path : String, dependencies : [ProjectDescription.TargetDependency], useResources: Bool = false) -> [Target]{
        let sources = Target(name: name,
                platform: platform,
                product: .framework,
                bundleId: "\(bundleID).\(name)",
//                 deploymentTarget: .iOS(targetVersion: "13.0", devices: [.ipad, .iphone]),
                infoPlist: infoList,
                sources: ["CustomFramework/\(name)/**"],
                resources: useResources ? ["CustomFramework/\(name)/Resources/**"] : [],
                dependencies: dependencies)
//        let tests = Target(name: "\(name)Tests",
//                platform: platform,
//                product: .unitTests,
//                           bundleId: "\(bundleID).\(name)Tests",
//                           deploymentTarget: .iOS(targetVersion: "13.0", devices: [.ipad, .iphone]),
//                infoPlist: infoList,
//                sources: ["\(path)/\(name)/Tests/**"],
//                resources: [],
//                dependencies: [.target(name: name)])
//        return [sources, tests]
        return [sources]
    }
    
    
    
}

public extension TargetDependency {
    static let rxSwift: TargetDependency         = .external(name: "RxSwift")
    static let rxCocoa: TargetDependency         = .external(name: "RxCocoa")
    static let rxRelay: TargetDependency         = .external(name: "RxRelay")
    static let rxDataSources: TargetDependency   = .external(name: "RxDataSources")
    static let alamofire: TargetDependency       = .external(name: "Alamofire")
    static let moya: TargetDependency            = .external(name: "Moya")
    static let rxMoya: TargetDependency          = .external(name: "RxMoya")
    static let snapKit: TargetDependency         = .external(name: "SnapKit")
    static let then: TargetDependency            = .external(name: "Then")
    static let kingfisher: TargetDependency      = .external(name: "Kingfisher")
    static let rxKeyboard: TargetDependency      = .external(name: "RxKeyboard")
    static let lottie: TargetDependency          = .external(name: "Lottie")
    static let rxGesture: TargetDependency       = .external(name: "RxGesture")
    static let swiftyJson: TargetDependency      = .external(name: "SwiftyJSON")
    static let toast: TargetDependency           = .external(name: "Toast")
//    static let reSwift: TargetDependency         = .external(name: "ReSwift")
    static let firebaseAnalytics: TargetDependency = .external(name: "FirebaseAnalytics")
    static let googleGroup: TargetDependency = .external(name: "GoogleGroup")
    static let naverGroup: TargetDependency = .external(name: "NMapsMapa")
    static let realm: TargetDependency = .external(name: "RealmSwiftPack")
    static let dropDown: TargetDependency = .external(name: "DropDown")
    static let webp: TargetDependency = .external(name: "SDWebImageWebPCoder")
    static let sdImage: TargetDependency = .external(name: "SDWebImage")
    static let protoBuffer: TargetDependency = .external(name: "SwiftProtobuf")
//    static let socketIO: TargetDependency = .external(name: "SocketIO")
    static let tcpSocket: TargetDependency = .framework(path: "CustomFramework/TCPSocket/TCPSocket.framework")
    static let starScream: TargetDependency = .external(name: "Starscream")
    static let grpc: TargetDependency = .external(name: "GRPC")
    static let sChart: TargetDependency = .external(name: "GRPC")
    
}

