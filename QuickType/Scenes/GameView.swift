import SpriteKit

protocol GameSceneViewProtocol: SKView {
    func didChangeText(to text: String)
}

final class GameView: UIView {
    var bottomViewBottomConstraint = NSLayoutConstraint()
    var sceneView: GameSceneViewProtocol = GameSceneView() {
        didSet {
            setupViewStyle()
            setupViewHierarchy()
            setupViewConstraints()

            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

            wordInputTextField.delegate = self
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            bottomViewBottomConstraint.constant = -keyboardHeight
            print(keyboardHeight)
            print("keyboardWillShow, height \(keyboardHeight)")
        }
    }

    @objc private func keyboardWillHide() {
        print("keyboardWillHide")
        bottomViewBottomConstraint.constant = 0
    }

    private let wordInputTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        return textField
    }()

    private func setupViewStyle() {
        backgroundColor = .systemPink
    }

    private func setupViewHierarchy() {
        addSubview(sceneView)
        addSubview(wordInputTextField)
    }

    private func setupViewConstraints() {
        prepareSubviewsForConstraints()

        bottomViewBottomConstraint = wordInputTextField.bottomAnchor.constraint(equalTo: bottomAnchor)

        activateConstraints([
            sceneView.topAnchor.constraint(equalTo: topAnchor),
            sceneView.leftAnchor.constraint(equalTo: leftAnchor),
            sceneView.rightAnchor.constraint(equalTo: rightAnchor),

            wordInputTextField.topAnchor.constraint(equalTo: sceneView.bottomAnchor),
            bottomViewBottomConstraint,
            wordInputTextField.leftAnchor.constraint(equalTo: leftAnchor),
            wordInputTextField.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
}

extension GameView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("Did change selection \(String(describing: textField.text))")
        sceneView.didChangeText(to: textField.text ?? "")
    }
}

extension GameView: GameSceneDelegate {
    func didFindMatch() {
        wordInputTextField.text = ""
    }
}
