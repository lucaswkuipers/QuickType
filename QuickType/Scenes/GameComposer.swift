import SpriteKit

enum GameComposer {
    static func makeScene() -> UIViewController {
        let scene = GameScene(size: Device.size)
        let view = GameView()
        let sceneView = GameSceneView()
        let viewController = GenericViewController(with: view)

        view.sceneView = sceneView
        sceneView.gameScene = scene
        scene.gameDelegate = view

        return viewController
    }
}
