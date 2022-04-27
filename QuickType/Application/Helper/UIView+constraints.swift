import UIKit

extension UIView {
    func prepareSubviewsForConstraints() {
        subviews.forEach { $0.prepareForConstraints() }
    }

    func prepareForConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
