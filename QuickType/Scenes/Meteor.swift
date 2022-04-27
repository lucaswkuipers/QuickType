import SpriteKit

struct Meteor {
    let word: String
    let node: MeteorNode
}

final class MeteorNode: SKSpriteNode {
    private let offset = 10.0
    private(set) var isAlive = true
    private let fallingSpeed = 100.0

    init(word: String) {
        let texture = SKTexture(imageNamed: "")
        super.init(texture: texture, color: .white, size: texture.size())
        setScale(0.1)
        position = Device.randomPositionAtTop(offset: frame.height.half)
        run(SKAction.move(to: CGPoint(x: position.x, y: 0), duration: (Device.height + frame.height.half) / fallingSpeed))
        guard let fire = SKEmitterNode(fileNamed: "FireTrail.sks") else { return }
        addChild(fire)
        fire.setScale(15)
        fire.zPosition = -1
        addChild(label)
        label.text = word
    }

    let label: SKLabelNode = {
        let label = SKLabelNode()
        label.zPosition = 100
        label.fontSize = 500
        label.fontColor = .red
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func hasCollided() -> Bool {
        return position.y <= frame.height.half && isAlive
    }

    func explode() {
        isAlive = false
        guard let explosionEmitter = SKEmitterNode(fileNamed: "Explosion.sks") else { return }
        addChild(explosionEmitter)
        explosionEmitter.setScale(15)
        let remove = SKAction.removeFromParent()
        let wait = SKAction.wait(forDuration: 0.55)
        let sequence = SKAction.sequence([wait, remove])
        run(sequence)
    }
}
