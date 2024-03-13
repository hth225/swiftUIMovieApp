import ProjectDescription

let project = Project(
    name: "SwiftUIMovieApp",
    targets: [
        .target(
            name: "SwiftUIMovieApp",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.SwiftUIMovieApp",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["SwiftUIMovieApp/Sources/**"],
            resources: ["SwiftUIMovieApp/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "SwiftUIMovieAppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.SwiftUIMovieAppTests",
            infoPlist: .default,
            sources: ["SwiftUIMovieApp/Tests/**"],
            resources: [],
            dependencies: [.target(name: "SwiftUIMovieApp")]
        ),
    ]
)
