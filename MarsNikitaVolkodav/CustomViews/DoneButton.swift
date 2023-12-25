import UIKit

final class DoneButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        let closeImage = UIImage(named: "done")
        translatesAutoresizingMaskIntoConstraints = false
        setImage(closeImage, for: .normal)
        frame = CGRect(x: 0, y: 0, width: 44, height: 44)
    }
}
