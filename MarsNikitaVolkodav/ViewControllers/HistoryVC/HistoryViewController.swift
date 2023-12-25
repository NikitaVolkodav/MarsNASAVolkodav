import UIKit

final class HistoryViewController: UIViewController {
    
    private let historyNavigationView = HistoryNavigationView()
    private let emptyImageView = UIImageView()
    
    private let historyTableView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var yourDataArray = ["1"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(historyNavigationView)
        view.addSubview(emptyImageView)
        view.addSubview(historyTableView)
        setActionForBackButton()
        
        configurationEmptyImageView()
        updateEmptyImageViewConstraints()
        
        configurationHistoryTableView()
        updateHistoryTableViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateImageViewVisibility()
    }
    
    func updateImageViewVisibility() {
        emptyImageView.isHidden = yourDataArray.isEmpty
     }
    
    private func setActionForBackButton() {
        historyNavigationView.setBackButtonAction { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func configurationEmptyImageView() {
        let emptyImage = UIImage(named: "empty")
        emptyImageView.image = emptyImage
        emptyImageView.contentMode = .scaleAspectFit
    }
    
    private func updateEmptyImageViewConstraints() {
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyImageView.heightAnchor.constraint(equalToConstant: 186),
            emptyImageView.widthAnchor.constraint(equalToConstant: 193)
        ])
    }
    
    func configurationHistoryTableView() {
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        historyTableView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.reuseIdentifier)
    }
    
    func updateHistoryTableViewConstraints() {
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 132),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
// MARK: - UICollectionViewDataSource
extension HistoryViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.reuseIdentifier, for: indexPath) as? HistoryCell else { return UICollectionViewCell() }
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension HistoryViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            AlertConteiner.showAlertMenuFilter(self)
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16, height: 136)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 10)
    }
}
