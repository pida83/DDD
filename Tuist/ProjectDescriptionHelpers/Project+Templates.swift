import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    
    static var BUNDLE_PREFIX = "kr.co.cloneApp"
    
    // Helper function to create the Project for this ExampleApp
        public static func app(name: String, platform: Platform, additionalTargets: [String]) -> Project {
            var targets = makeAppTargets(name: name,
                                         platform: platform,
                                         dependencies: additionalTargets.map { TargetDependency.target(name: $0) })
            targets += additionalTargets.flatMap({ makeFrameworkTargets(name: $0, platform: platform) })
//            dump(additionalTargets.flatMap({ makeFrameworkTargets(name: $0, platform: platform) }))
            return Project(name: name,
                           organizationName: "tuist.io",
                           targets: targets)
        }

        /// Helper function to create the application target and the unit test target.
        private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
            let platform: Platform = platform
            let infoPlist: [String: InfoPlist.Value] = [
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1",
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen"
                ]

            let mainTarget = Target(
                name: name,
                platform: platform,
                product: .app,
                bundleId: "io.tuist.\(name)",
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["Targets/\(name)/Sources/**"],
                resources: ["Targets/\(name)/Resources/**"],
                dependencies: dependencies
            )

            let testTarget = Target(
                name: "\(name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "io.tuist.\(name)Tests",
                infoPlist: .default,
                sources: ["Targets/\(name)/Tests/**"],
                dependencies: [
                    .target(name: "\(name)")
            ])
            return [mainTarget, testTarget]
        }
    
        // MARK: - Private
        /// Helper function to create a framework target and an associated unit test target
        private static func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
            let sources = Target(name: name,
                    platform: platform,
                    product: .framework,
                    bundleId: "io.tuist.\(name)",
                    infoPlist: .default,
                    sources: ["Targets/\(name)/Sources/**"],
                    resources: [],
                    dependencies: [])
            let tests = Target(name: "\(name)Tests",
                    platform: platform,
                    product: .unitTests,
                    bundleId: "io.tuist.\(name)Tests",
                    infoPlist: .default,
                    sources: ["Targets/\(name)/Tests/**"],
                    resources: [],
                    dependencies: [.target(name: name)])
            return [sources, tests]
        }
    
    
    public static func makeFramework(name: String, platform: Platform) -> [Target] {
        let sources = Target(name: name,
                platform: platform,
                product: .framework,
                bundleId: "io.tuist.\(name)",
                infoPlist: .default,
                sources: ["Targets/\(name)/Sources/**"],
                resources: [],
                dependencies: [])
        let tests = Target(name: "\(name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "io.tuist.\(name)Tests",
                infoPlist: .default,
                sources: ["Targets/\(name)/Tests/**"],
                resources: [],
                dependencies: [.target(name: name)])
        return [sources, tests]
    }
    
    public static func makeProject(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
            ]

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "io.tuist.\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "io.tuist.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
        ])
        
        return [mainTarget, testTarget]
    }
    
        
}

    
    
//
//
//
//    public static func project( name: String, packages: [Package] = [], dependencies: [TargetDependency] = [] ) -> Project {
//    var deploymentTarget: DeploymentTarget = .iOS(targetVersion: "13.0", devices: [.iphone, .ipad])
//
//        let mainTarget: Target = Target(
//            name: name,
//            platform: .iOS,
//            product: .app,
//            bundleId: "\(BUNDLE_PREFIX).\(name)",
//            deploymentTarget: deploymentTarget,
//            infoPlist: .file(path: .relativeToRoot("Supporting Files/Info.plist")),
//            sources: ["Application/\(name)/Sources/**"],
//            resources: ["Application/\(name)/Resources/**"],
//            dependencies: dependencies
//        )
//
//        let testTarget: Target = Target(
//            name: "\(name)Tests",
//            platform: .iOS,
//            product: .unitTests,
//            bundleId: "\(BUNDLE_PREFIX).\(name)Tests",
//            deploymentTarget: deploymentTarget,
//            infoPlist: .default,
//            sources: ["Application/\(name)/Tests/**"],
//            dependencies: []
//        )
//
//
//
//
//
//        let targets: [Target] = [
//            mainTarget,
//            testTarget
//        ]
//
//        return Project(
//            name: name,
//            organizationName: "YEOBOYA.CORP.",
//            packages: [],
//            targets: targets
//        )
//    }
//
//    public static func framework( name: String, packages: [Package] = [], dependencies: [TargetDependency] = [] ) -> Project {
//
//        var deploymentTarget: DeploymentTarget = .iOS(targetVersion: "13.0", devices: [.iphone, .ipad])
//        let mainTarget: Target = Target(
//            name: name,
//            platform: .iOS,
//            product: .framework,
//            bundleId: "\(BUNDLE_PREFIX).\(name)",
//            deploymentTarget: deploymentTarget,
//            infoPlist: .file(path: .relativeToRoot("Supporting Files/Info.plist")),
//            sources: ["Sources/**"],
//            resources: ["Resources/**"],
//            dependencies: dependencies
//        )
//
//        let testTarget: Target = Target(
//            name: "\(name)Tests",
//            platform: .iOS,
//            product: .unitTests,
//            bundleId: "\(BUNDLE_PREFIX).\(name)Tests",
//            deploymentTarget: deploymentTarget,
//            infoPlist: .default,
//            sources: ["Tests/**"],
//            dependencies: []
//        )
//
//        let targets: [Target] = [
//            mainTarget,
//            testTarget
//        ]
//
//        return Project(
//            name: name,
//            organizationName: "YEOBOYA.CORP.",
//            packages: [],
//            targets: targets
//        )
//    }
//}
