import UIKit

final class DateContentView: UIView {
    
    private let backgroundView = UIView()
    private let closeButton = CloseButton()
    private let dateLabel = TitlePickerLabel(labelText: "Date")
    private let doneButton = DoneButton()
    private let datePicker = UIDatePicker()
    
    private var closeButtonAction: (() -> Void)?
    private var doneButtonAction: (() -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        addSubviews()
        setupConstraints()
        setupButtonTargets()
    }
    
    private func addSubviews() {
        addSubview(backgroundView)
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(dateLabel)
        backgroundView.addSubview(doneButton)
        backgroundView.addSubview(datePicker)
    }
    
    // MARK: - Open Action
    func setCloseButtonAction(_ action: (() -> Void)?) {
        closeButtonAction = action
    }
    
    func setDoneButtonAction(_ action: (() -> Void)?) {
        doneButtonAction = action
    }
    
    func getSelectedDate() -> Date {
        return datePicker.date
    }
}

// MARK: - SetupButtonTargets
private extension DateContentView {
    func setupButtonTargets() {
        addTargetsForButtons()
    }
    
    @objc func actionCloseButton() {
        closeButtonAction?()
    }
    
    @objc func actionDoneButton() {
        doneButtonAction?()
    }
    
    func addTargetsForButtons() {
        closeButton.addTarget(self, action: #selector(actionCloseButton), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(actionDoneButton), for: .touchUpInside)
    }
}

// MARK: - ConfigurationUI
private extension DateContentView {
    func setupConfiguration() {
        configurationBackgroundView()
        configurationDatePicker()
    }
    
    func configurationBackgroundView() {
        backgroundView.backgroundColor = UIColor(named: "backgroundOne")
        backgroundView.layer.cornerRadius = 50
    }
    
    func configurationDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en")
        datePicker.maximumDate = Date()
        datePicker.tintColor = .black
    }
}
// MARK: - UpdateConstraints
private extension DateContentView {
    func setupConstraints() {
        updateBackgroundViewConstraints()
        updateCloseButtonConstraints()
        updateDateLabelConstraints()
        updateDoneButtonConstraints()
        updateDatePickerConstraints()
    }
    
    func updateBackgroundViewConstraints(){
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            backgroundView.heightAnchor.constraint(equalToConstant: 312)
        ])
    }
    
    func updateCloseButtonConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
        ])
    }
    
    func updateDateLabelConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            dateLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func updateDoneButtonConstraints() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
        ])
    }
    
    func updateDatePickerConstraints() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            datePicker.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 28),
            datePicker.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -28)
        ])
    }
}
