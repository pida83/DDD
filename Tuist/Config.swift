import ProjectDescription

let config = Config(
    swiftVersion: "5.5.0",
    plugins: [
        .local(path: .relativeToManifest("../../Plugins/CloneProject")),
    ],
    generationOptions: .options(
        
    )
)
