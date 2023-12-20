import UIKit

final class CustomFilterButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    private func setupButton() {
        contentHorizontalAlignment = .left
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

        backgroundColor = UIColor(named: "backgroundOne")
        titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 17)
        setTitleColor(UIColor(named: "layerOne"), for: .normal)
        tintColor = .black
        layer.cornerRadius = 10
        
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 1
    }
    
    // MARK: - OpenActions
    func setupImage(named imageName: String) {
        let image = UIImage(named: imageName)
        setImage(image, for: .normal)
    }
    
    func setupTitle(title: String) {
        setTitle(title, for: .normal)
    }
}
