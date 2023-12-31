import UIKit

final class MainNavigationBarView: UIView {
    
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
    
    private let dateFormaterService = DateFormaterService()
    
    var selectedDate: Date? = Date()
    
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
    // MARK: - Open Action for Date Label
    func setDateLabel() {
        let dateToString = dateFormaterService.formatDateToString(selectedDate ?? Date())
        dateLabel.text = dateToString
    }
    
    func getDateLabelText() -> String {
        return dateLabel.text ?? ""
    }
    // MARK: - Open Action for camera Filter Button
    
    func getCameraButtonTitle() -> String {
        
        guard let buttonText = cameraFilterButton.titleLabel?.text else {
             return ""
         }
        
        switch buttonText {
        case "All":
            return "All"
        case "FHAZ":
            return "Front Hazard Avoidance Camera"
        case "RHAZ":
            return "Rear Hazard Avoidance Camera"
        case "MAST":
            return "Mast Camera"
        case "CHEMCAM":
            return "Chemistry and Camera Complex"
        case "MAHLI":
            return "Mars Hand Lens Imager"
        case "MARDI":
            return "Mars Descent Imager"
        case "NAVCAM":
            return "Navigation Camera"
        case "PANCAM":
            return "Panoramic Camera"
        default:
            return ""
        }
    }
    // MARK: - Open Action for Camera CPU Buttons
    func setCameraButtonTitle(title: String) {
        cameraFilterButton.setupTitle(title: title)
    }
    
    func setCpuButtonTitle(title: String) {
        cpuFilterButton.setupTitle(title: title)
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
private extension MainNavigationBarView {
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
private extension MainNavigationBarView {
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
        let dateToString = dateFormaterService.formatDateToString(selectedDate ?? Date())
        dateLabel.text = dateToString
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = UIColor(named: "layerOne")
    }
    
    func configurationCpuFilterButton() {
        cpuFilterButton.setupImage(named: "cpu")
        cpuFilterButton.setupTitle(title: "All")
    }
    
    func configurationCameraFilterButton() {
        cameraFilterButton.setupImage(named: "camera")
        cameraFilterButton.setupTitle(title: "MAST")
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
private extension MainNavigationBarView {
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
