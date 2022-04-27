import UIKit

extension UIView {
    enum Side {
        case top
        case left
        case bottom
        case right
    }

    func pin(to view: UIView, offset: Double = 0) -> [NSLayoutConstraint] {
        return [
            pin(.top, to: view, offset: offset),
            pin(.left, to: view, offset: offset),
            pin(.bottom, to: view, offset: offset),
            pin(.right, to: view, offset: offset)
        ]
    }

    func pinSafe(_ side: Side, offset: Double = 0) -> NSLayoutConstraint {
        switch side {
        case .top:
            return topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: offset)
        case .left:
            return leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: offset)
        case .bottom:
            return bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -offset)
        case .right:
            return rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -offset)
        }
    }

    func pin(_ side: Side, to view: UIView, offset: Double = 0) -> NSLayoutConstraint {
        switch side {
        case .top:
            return pinTop(to: view, offset: offset)
        case .left:
            return pinLeft(to: view, offset: offset)
        case .bottom:
            return pinBottom(to: view, offset: offset)
        case .right:
            return pinRight(to: view, offset: offset)
        }
    }

    func pinTop(
        to view: UIView,
        offset: Double = 0
    ) -> NSLayoutConstraint {
        return topAnchor.constraint(equalTo: view.topAnchor, constant: offset)
    }

    func pinLeft(
        to view: UIView,
        offset: Double = 0
    ) -> NSLayoutConstraint {
        return leftAnchor.constraint(equalTo: view.leftAnchor, constant: offset)
    }

    func pinBottom(
        to view: UIView,
        offset: Double = 0
    ) -> NSLayoutConstraint {
        return bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset)
    }

    func pinRight(
        to view: UIView,
        offset: Double = 0
    ) -> NSLayoutConstraint {
        return rightAnchor.constraint(equalTo: view.rightAnchor, constant: -offset)
    }
}
