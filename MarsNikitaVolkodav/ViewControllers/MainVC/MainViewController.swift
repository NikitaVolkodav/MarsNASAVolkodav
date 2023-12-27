import UIKit

final class MainViewController: UIViewController {
    
    private let mainNavigationBarView = MainNavigationBarView()
    private let historyButton = UIButton()
    private let mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    private let imageCacheService = ImageCacheService()
    
    private let dateFormaterService = DateFormaterService()
    private let abbreviationServiceMarsCamera = AbbreviationServiceMarsCamera()
    
    private var nasaModel: NASAModel?
    private var checkURL : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConfiguration()
        setupConstraints()
        setActionForButtons()
    }
    
    private func fetchDataCamera(camera: String) {
        networkManager.searchImagesCamera(camera: camera) { [weak self] model, _ in
            guard let self = self, let model = model else { return }
            self.nasaModel = model
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
    
    private func fetchDataDate(date: String) {
        networkManager.searchImagesEarthDate(earthDate: date) { [weak self] model, _ in
            guard let self = self, let model = model else { return }
            self.nasaModel = model
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(mainNavigationBarView)
        view.addSubview(mainCollectionView)
        mainCollectionView.addSubview(historyButton)
    }
}
// MARK: - Delegates
extension MainViewController: SelectedDateDelegate {
    func selectedDate(_ date: Date) {
        mainNavigationBarView.selectedDate = date
        mainNavigationBarView.setDateLabel()
        
        let stringDate = dateFormaterService.formatDateToStringForNetwork(date)
        fetchDataDate(date: stringDate)
        
    }
}

extension MainViewController: SelectedCameraDelegate {
    func selectedCamera(_ camera: String) {
        mainNavigationBarView.setCameraButtonTitle(title: camera)
        fetchDataCamera(camera: camera)
    }
}

extension MainViewController: SelectedCpuDelegate {
    func selectedCpu(_ cpu: String) {
        mainNavigationBarView.setCpuButtonTitle(title: cpu)
    }
}

extension MainViewController: SelectedHistoryCell {
    func selectedHistoryCell(camera: String, earthDate: Date) {
        let selectedCamera = abbreviationServiceMarsCamera.getAbbreviation(for: camera)
        let selectedEarthDate = dateFormaterService.formatDateToStringForNetwork(earthDate)
        
        mainNavigationBarView.selectedDate = earthDate
        mainNavigationBarView.setDateLabel()
        mainNavigationBarView.setCameraButtonTitle(title: selectedCamera)
        
        networkManager.searchImages(withCamera: selectedCamera, andEarthDate: selectedEarthDate) { [weak self] model, _ in
            guard let self = self, let model = model else { return }
            self.nasaModel = model
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nasaModel?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.reuseIdentifier, for: indexPath) as? MainCell else { return UICollectionViewCell() }
        cell.cameraValueLabel.text = nasaModel?.photos[indexPath.row].camera.fullName
        cell.dateValueLabel.text = dateFormaterService.formatStringDateToString(nasaModel?.photos[indexPath.row].earthDate ?? "")
        
        self.checkURL = nasaModel?.photos[indexPath.row].imgSrc
        if let imageURLString = nasaModel?.photos[indexPath.row].imgSrc,
           let imageURL = URL(string: imageURLString),
           self.checkURL == imageURLString {
            imageCacheService.getImage(from: imageURL) { image in
                DispatchQueue.main.async {
                    cell.setMarsImage(image: image ?? UIImage())
                }
            }
        }
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension MainViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let nasaModelImage = nasaModel?.photos[indexPath.row].imgSrc,
              let webformatURL = URL(string: nasaModelImage) else { return }
        imageCacheService.getImage(from: webformatURL) { image in
            guard let image = image else { return }
            DispatchQueue.main.async { [self] in
                let photoViewController = PhotoViewController()
                photoViewController.navigationItem.hidesBackButton = true
                photoViewController.selectedImage = image
                self.navigationController?.pushViewController(photoViewController, animated: true)
            }
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
        mainNavigationBarView.setCpuButtonAction { [weak self] in
            guard let _ = self else { return}
//            guard let self = self else { return }
        }
    }
    
    func addActionCameraButton() {
        mainNavigationBarView.setCameraButtonAction { [weak self] in
            guard let self = self else { return }
            let cameraVC = CameraViewController()
            cameraVC.modalTransitionStyle = .crossDissolve
            cameraVC.modalPresentationStyle =  .overCurrentContext
            cameraVC.selectedCameraDelegate = self
            self.navigationController?.present(cameraVC, animated: true)
        }
    }
    
    func addActionPlusButton() {
        mainNavigationBarView.setPlusButtonAction { [weak self] in
            guard let self = self else { return }
            AlertConteiner.showAlertSaveFilters(self) { action in
                if action.title == "Save" {
                    let cameraButtonText = self.mainNavigationBarView.getCameraButtonTitle()
                    let selectedDate = self.mainNavigationBarView.selectedDate ?? Date()
                    
                    CoreDataManager.shared.createFilter(rover: "Curiosity", camera: cameraButtonText, date: selectedDate)
                }
            }
        }
    }
    
    func addActionCalendarButton() {
        mainNavigationBarView.setCalendarButtonAction { [weak self] in
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
        historyVC.selectedHistoryCell = self
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
