import UIKit

final class PhotoContentView: UIView {
    
    private let photoImageView = UIImageView()
    private let closeButton = UIButton()
    
    private var closeButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "layerOne")
        addSubviews()
        setupConfiguration()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(photoImageView)
        addSubview(closeButton)
    }
    
    // MARK: - OpenActions
    func setCloseButtonAction(_ action: (() -> Void)?) {
        closeButtonAction = action
    }
    
    func setPhotoImageView(image: UIImage) {
        photoImageView.image = image
    }
}
// MARK: - ConfigurationUI
private extension PhotoContentView {
    func setupConfiguration() {
        configurationCloseButton()
        configurationPhotoImageView()
    }
    
    func configurationPhotoImageView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
    }
    
    func configurationCloseButton() {
        let closeImage = UIImage(named: "closeWhite")
        closeButton.setImage(closeImage, for: .normal)
        closeButton.addTarget(self, action: #selector(actionCloseButton), for: .touchUpInside)
    }
    
    @objc func actionCloseButton() {
        closeButtonAction?()
    }
}
// MARK: - UpdateConstraints
private extension PhotoContentView {
    func setupConstraints() {
        updatePhotoImageViewConstraints()
        updateCloseButtonConstraints()
    }
    
    func updatePhotoImageViewConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 393)
        ])
    }
    
    func updateCloseButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
}
