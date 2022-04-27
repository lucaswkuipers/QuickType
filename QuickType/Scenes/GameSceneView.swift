import SpriteKit

protocol GameSceneProtocol: SKScene {
    func didChangeText(to text: String)
}

final class GameSceneView: SKView {
    var gameScene: GameSceneProtocol? {
        didSet {
            presentScene(gameScene)
        }
    }

    init() {
        super.init(frame: .zero)
        setupPreferences()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupPreferences() {
        ignoresSiblingOrder = true

        #if DEBUG
        showsDrawCount = true
        showsFPS = true
        showsNodeCount = true
        showsFields = true
        showsPhysics = true
        showsQuadCount = true
        #endif
    }
}

extension GameSceneView: GameSceneViewProtocol {
    func didChangeText(to text: String) {
        gameScene?.didChangeText(to: text)
    }
}
