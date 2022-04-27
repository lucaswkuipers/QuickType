import SpriteKit

protocol GameSceneDelegate {
    func didFindMatch()
}

final class GameScene: SKScene {
    var gameDelegate: GameSceneDelegate?

    var meteors: [Meteor] = []
    var currentTime = TimeInterval()
    var lastTimeSpawned = TimeInterval()

    override func update(_ currentTime: TimeInterval) {
        self.currentTime = currentTime

        meteors = meteors.filter { $0.node.inParentHierarchy(self) }

        spawnMeteorIfNeeded()
        destroyCollidingMeteorsIfNeeded()

    }

    private func spawnMeteorIfNeeded() {
        guard meteors.count < 5,
              currentTime - lastTimeSpawned > 3 else { return }
        addMeteor()
    }

    private func destroyCollidingMeteorsIfNeeded() {
        for meteor in meteors {
            guard meteor.node.hasCollided() else { continue }
            meteor.node.explode()
        }
    }

    private func addMeteor() {
        guard let word = ["test", "meteor", "lucas"].randomElement() else { return }
        let node = MeteorNode(word: word)
        let meteor = Meteor(
            word: word,
            node: node
        )
        meteors.append(meteor)
        addChild(node)
        lastTimeSpawned = currentTime
    }
}

extension GameScene: GameSceneProtocol {

    func didChangeText(to text: String) {
        let matchingMeteors = meteors.filter { $0.word.lowercased() == text.lowercased() }
        matchingMeteors.forEach { $0.node.explode() }

        if !matchingMeteors.isEmpty {
            print("There is a match!")
            gameDelegate?.didFindMatch()
        }
    }
}
