import UIKit

final class MainViewController: UIViewController {
    
    private let customNavigationBar = CustomNavigationView()
    private let historyButton = UIButton()
    private let mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConfiguration()
        setupConstraints()
        setActionForButtons()
    }
    
    private func addSubviews() {
        view.addSubview(customNavigationBar)
        view.addSubview(mainCollectionView)
        mainCollectionView.addSubview(historyButton)
    }
}
// MARK: - Delegates
extension MainViewController: SelectedDateDelegate {
    func selectedDate(_ date: Date) {
        customNavigationBar.setDateLabel(date: date)
    }
}

extension MainViewController: SelectedCameraDelegate {
    func selectedCamera(_ camera: String) {
        customNavigationBar.setCameraButtonTitle(title: camera)
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.reuseIdentifier, for: indexPath) as? MainCell else { return UICollectionViewCell() }
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension MainViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoViewController = PhotoViewController()
            photoViewController.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(photoViewController, animated: true)
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 10)
    }
}
// MARK: - Set Action For Buttons
private extension MainViewController {
    func setActionForButtons() {
        addActionCpuButton()
        addActionCameraButton()
        addActionPlusButton()
        addActionCalendarButton()
    }
    
    func addActionCpuButton() {
        customNavigationBar.setCpuButtonAction { [weak self] in
            //            guard let self = self else { return } тут правильно!
            guard let _ = self else { return }
            print("Cpu")
        }
    }
    
    func addActionCameraButton() {
        customNavigationBar.setCameraButtonAction { [weak self] in
            guard let self = self else { return }
            let cameraVC = CameraViewController()
            cameraVC.modalTransitionStyle = .crossDissolve
            cameraVC.modalPresentationStyle =  .overCurrentContext
            cameraVC.selectedCameraDelegate = self
            self.navigationController?.present(cameraVC, animated: true)
        }
    }
    
    func addActionPlusButton() {
        customNavigationBar.setPlusButtonAction { [weak self] in
            guard let self = self else { return }
            AlertConteiner.showAlertSaveFilters(self) { action in
                if action.title == "Save" {
                    let cameraButtonText = self.customNavigationBar.getCameraButtonTitle()
                    let dateLabelText = self.customNavigationBar.getDateLabelText()
                    HistoryService.shared.saveHistoryFilterData(rover: "Curiosity", camera: cameraButtonText, date: dateLabelText)
                }
            }
        }
    }
    
    func addActionCalendarButton() {
        customNavigationBar.setCalendarButtonAction { [weak self] in
            guard let self = self else { return }
            let dateVC = DateViewController()
            dateVC.selectedDateDelegate = self
            dateVC.modalTransitionStyle = .flipHorizontal
            dateVC.modalPresentationStyle =  .overCurrentContext
            self.navigationController?.present(dateVC, animated: true)
            
            let dimmingView = UIView(frame: self.view.bounds)
            dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            dimmingView.tag = 123
            self.view.addSubview(dimmingView)
        }
    }
}
// MARK: - ConfigurationUI
private extension MainViewController {
    func setupConfiguration() {
        configurationHistoryButton()
        configurationMainCollectionView()
    }
    
    func configurationHistoryButton() {
        let historyImage = UIImage(named: "history")
        historyButton.setImage(historyImage, for: .normal)
        historyButton.backgroundColor = UIColor(named: "accentOne")
        historyButton.layer.cornerRadius = 35
        historyButton.addTarget(self, action: #selector(actionHistoryButton), for: .touchUpInside)
    }
    
    @objc func actionHistoryButton() {
        let historyVC = HistoryViewController()
        historyVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
    func configurationMainCollectionView() {
        mainCollectionView.backgroundColor = UIColor(named: "backgroundOne")
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
    }
}

// MARK: - UpdateConstraints
private extension MainViewController {
    func setupConstraints() {
        updateHistoryButtonConstraints()
        updateMainCollectionViewConstraints()
    }
    
    func updateHistoryButtonConstraints() {
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            historyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            historyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            historyButton.heightAnchor.constraint(equalToConstant: 70),
            historyButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func updateMainCollectionViewConstraints() {
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 202),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
