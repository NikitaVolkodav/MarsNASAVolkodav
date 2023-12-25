import UIKit

final class ValueLabel: UILabel {
    private var labelText = ""

    required init(labelText: String) {
        super.init(frame: .zero)
        self.labelText = labelText
        self.setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "SFProDisplay-Bold", size: 17)
        textColor = UIColor(named: "layerOne")
        text = labelText
    }
}
