import UIKit

final class HistoryNavigationView: UIView {
    
    private let titleHistoryLabel = NavigationTitleLabel(labelText: "History")
    private let backButton = UIButton()
    
    private var backButtonAction: (() -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        addSubviews()
        setupConstraints()
    }
    
    override func updateConstraints(){
        super.updateConstraints()
        updateSelfConstraints()
    }
    
    private func addSubviews() {
        addSubview(titleHistoryLabel)
        addSubview(backButton)
    }
    
    // MARK: - Open Action
    func setBackButtonAction(_ action: (() -> Void)?) {
        backButtonAction = action
    }
}
// MARK: - ConfigurationUI
private extension HistoryNavigationView {
    func setupConfiguration() {
        configurationSelfView()
        configurationBackButton()
    }
    
    func configurationSelfView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "accentOne")
    }
    
    func configurationBackButton() {
        let backImage = UIImage(named: "back")
        backButton.setImage(backImage, for: .normal)
        backButton.backgroundColor = .clear
        backButton.addTarget(self, action: #selector(actionBackButton), for: .touchUpInside)
    }
    
    @objc func actionBackButton() {
        backButtonAction?()
    }
}
// MARK: - UpdateConstraints
private extension HistoryNavigationView {
    func setupConstraints() {
        updateTitleHistoryLabelConstraints()
        updateBackButtonConstraints()
    }
    
    func updateSelfConstraints() {
        
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            heightAnchor.constraint(equalToConstant: 132),
            widthAnchor.constraint(equalTo: superview.widthAnchor)
        ])
    }
    
    func updateTitleHistoryLabelConstraints() {
        NSLayoutConstraint.activate([
            titleHistoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleHistoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -21),
            titleHistoryLabel.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
    
    func updateBackButtonConstraints() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -21),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            backButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
}
