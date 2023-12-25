import UIKit

final class CustomNavigationView: UIView {
    
    private let titleMarsCameraLabel = NavigationTitleLabel(labelText: "MARS.CAMERA")
    private let dateLabel = UILabel()
    private let cpuFilterButton = CustomFilterButton()
    private let cameraFilterButton = CustomFilterButton()
    private let plusButton = UIButton()
    private let calendarButton = UIButton()
    
    private var cpuButtonAction: (() -> Void)?
    private var cameraButtonAction: (() -> Void)?
    private var plusButtonAction: (() -> Void)?
    private var calendarButtonAction: (() -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        addSubviews()
        setupConstraints()
        setupButtonTargets()
    }
    
    override func updateConstraints(){
        super.updateConstraints()
        updateSelfConstraints()
    }
    
    private func addSubviews() {
        addSubview(titleMarsCameraLabel)
        addSubview(dateLabel)
        addSubview(cpuFilterButton)
        addSubview(cameraFilterButton)
        addSubview(plusButton)
        addSubview(calendarButton)
    }
    
    // MARK: - Open Action for Buttons
    func setCpuButtonAction(_ action: (() -> Void)?) {
        cpuButtonAction = action
    }
    
    func setCameraButtonAction(_ action: (() -> Void)?) {
        cameraButtonAction = action
    }
    
    func setPlusButtonAction(_ action: (() -> Void)?) {
        plusButtonAction = action
    }
    
    func setCalendarButtonAction(_ action: (() -> Void)?) {
        calendarButtonAction = action
    }
}
// MARK: - SetupButtonTargets
private extension CustomNavigationView {
    func setupButtonTargets() {
        addTargetsForButtons()
    }
    
    @objc func actionCpuFilterButton() {
        cpuButtonAction?()
    }
    
    @objc func actionCameraFilterButton() {
        cameraButtonAction?()
    }
    
    @objc func actionPlusButton() {
        plusButtonAction?()
    }
    
    @objc func actionCalendarButton() {
        calendarButtonAction?()
    }
    
    
    func addTargetsForButtons() {
        cpuFilterButton.addTarget(self, action: #selector(actionCpuFilterButton), for: .touchUpInside)
        cameraFilterButton.addTarget(self, action: #selector(actionCameraFilterButton), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(actionPlusButton), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(actionCalendarButton), for: .touchUpInside)
    }
}
// MARK: - ConfigurationUI
private extension CustomNavigationView {
    func setupConfiguration() {
        configurationSelfView()
        configurationDateLabel()
        configurationCpuFilterButton()
        configurationCameraFilterButton()
        configurationPlusButton()
        configurationCalendarButton()
    }
    
    func configurationSelfView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "accentOne")
    }
    
    func configurationDateLabel() {
        dateLabel.font = UIFont(name: "SFProDisplay-Bold", size: 17)
        dateLabel.text = "June 6, 2019"
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = UIColor(named: "layerOne")
    }
    
    func configurationCpuFilterButton() {
        cpuFilterButton.setupImage(named: "cpu")
        cpuFilterButton.setupTitle(title: " All")
    }
    
    func configurationCameraFilterButton() {
        cameraFilterButton.setupImage(named: "camera")
        cameraFilterButton.setupTitle(title: " All")
    }
    
    func configurationPlusButton() {
        let plusImage = UIImage(named: "plus")
        plusButton.setImage(plusImage, for: .normal)
        plusButton.contentHorizontalAlignment = .center
        plusButton.backgroundColor = UIColor(named: "backgroundOne")
        plusButton.layer.cornerRadius = 10
    }
    
    func configurationCalendarButton() {
        let calendarImage = UIImage(named: "calendar")
        calendarButton.setImage(calendarImage, for: .normal)
        calendarButton.backgroundColor = .clear
    }
}

// MARK: - UpdateConstraints
private extension CustomNavigationView {
    func setupConstraints() {
        updateTitleMarsCameraLabelConstraints()
        updateDateLabelConstraints()
        updateCpuFilterButtonConstraints()
        updateCameraFilterButtonConstraints()
        updatePlusButtonConstraints()
        updateCalendarButtonConstraints()
    }
    
    func updateSelfConstraints() {
        
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            heightAnchor.constraint(equalToConstant: 202),
            widthAnchor.constraint(equalTo: superview.widthAnchor)
        ])
    }
    
    func updateTitleMarsCameraLabelConstraints() {
        NSLayoutConstraint.activate([
            titleMarsCameraLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            titleMarsCameraLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            titleMarsCameraLabel.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func updateDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleMarsCameraLabel.bottomAnchor, constant: 2),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            dateLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func updateCpuFilterButtonConstraints() {
        cpuFilterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cpuFilterButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 22),
            cpuFilterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            cpuFilterButton.heightAnchor.constraint(equalToConstant: 38),
            cpuFilterButton.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func updateCameraFilterButtonConstraints() {
        cameraFilterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cameraFilterButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 22),
            cameraFilterButton.leadingAnchor.constraint(equalTo: cpuFilterButton.trailingAnchor, constant: 12),
            cameraFilterButton.heightAnchor.constraint(equalToConstant: 38),
            cameraFilterButton.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func updatePlusButtonConstraints() {
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 22),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            plusButton.heightAnchor.constraint(equalToConstant: 38),
            plusButton.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    func updateCalendarButtonConstraints() {
        calendarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            calendarButton.bottomAnchor.constraint(equalTo: plusButton.topAnchor, constant: -32),
            calendarButton.heightAnchor.constraint(equalToConstant: 44),
            calendarButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
}
