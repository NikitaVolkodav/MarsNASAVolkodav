import UIKit

final class CameraContentView: UIView {
    
    private let backgroundView = UIView()
    private let closeButton = CloseButton()
    private let cameraLabel = TitlePickerLabel(labelText: "Camera")
    private let doneButton = DoneButton()
    private let pickerView = UIPickerView()
    
    private let cameraData = CameraData()
    
    private var closeButtonAction: (() -> Void)?
    private var doneButtonAction: (() -> Void)?
    
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
    
    private func addSubviews() {
        addSubview(backgroundView)
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(cameraLabel)
        backgroundView.addSubview(doneButton)
        backgroundView.addSubview(pickerView)
    }
    
    // MARK: - OpenActions
    func setCloseButtonAction(_ action: (() -> Void)?) {
        closeButtonAction = action
    }
    
    func setDoneButtonAction(_ action: (() -> Void)?) {
        doneButtonAction = action
    }
    
    func getSelectedCamera() -> String {
        let selectedValue = cameraData.cameraData[pickerView.selectedRow(inComponent: 0)]
        return selectedValue.abbreviation
    }
}

// MARK: - SetupButtonTargets
private extension CameraContentView {
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
private extension CameraContentView {
    func setupConfiguration() {
        configurationBackgroundView()
        configurationPickerView()
    }
    
    func configurationBackgroundView() {
        backgroundView.backgroundColor = UIColor(named: "backgroundOne")
        backgroundView.layer.cornerRadius = 50
        backgroundView.layer.shadowColor = UIColor(named: "layerOne")?.cgColor
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundView.layer.shadowRadius = 5
    }
    
    func configurationPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
}
// MARK: - UpdateConstraints
private extension CameraContentView {
    func setupConstraints() {
        updateBackgroundViewConstraints()
        updateCloseButtonConstraints()
        updateCameraLabelConstraints()
        updateDoneButtonConstraints()
        updatePickerViewConstraints()
    }
    
    func updateBackgroundViewConstraints(){
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor ),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 6),
            backgroundView.heightAnchor.constraint(equalToConstant: 312)
        ])
    }
    
    func updateCloseButtonConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
        ])
    }
    
    func updateCameraLabelConstraints() {
        NSLayoutConstraint.activate([
            cameraLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            cameraLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cameraLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func updateDoneButtonConstraints() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
        ])
    }
    
    func updatePickerViewConstraints() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: cameraLabel.bottomAnchor, constant: 24),
            pickerView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 28),
            pickerView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -28)
        ])
    }
}

extension CameraContentView: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cameraData.cameraData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cameraData.cameraData[row].name
    }
}
