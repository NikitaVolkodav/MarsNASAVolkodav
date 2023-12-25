import UIKit

final class TitlePickerLabel: UILabel {
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
        font = UIFont(name: "SFProDisplay-Bold", size: 22)
        textColor = UIColor(named: "layerOne")
        backgroundColor = .clear
        text = labelText
    }
}
