import UIKit

final class MainCell: UICollectionViewCell {
    static let reuseIdentifier = "MainCell"
    
    private let marsImage = UIImageView()
    private let roverLabel = InfoLabel(labelText: "Rover:")
    private let cameraLabel = InfoLabel(labelText: "Camera:")
    private let dateLabel = InfoLabel(labelText: "Date:")
    
    private let roverStackView = UIStackView()
    private let cameraStackView = UIStackView()
    private let dateStackView = UIStackView()
    
    let roverValueLabel = ValueLabel(labelText: "Curiosity")
    let cameraValueLabel = ValueLabel()
    let dateValueLabel = ValueLabel(labelText: "Date")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        addSubviews()
        updateUIConstraints()
        setConfigurations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMarsImage(image: UIImage) {
        marsImage.image = image
    }
    
    private func addSubviews() {
        contentView.addSubview(marsImage)
        contentView.addSubview(roverStackView)
        contentView.addSubview(cameraStackView)
        contentView.addSubview(dateStackView)
        
        roverStackView.addArrangedSubview(roverLabel)
        roverStackView.addArrangedSubview(roverValueLabel)
        
        cameraStackView.addArrangedSubview(cameraLabel)
        cameraStackView.addArrangedSubview(cameraValueLabel)
        
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dateValueLabel)
    }
    
    private func setupCell() {
        backgroundColor = UIColor(named: "backgroundOne")
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.cornerRadius = 30
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
    }
    
    private func setConfigurations() {
        marsImage.contentMode = .scaleAspectFill
        marsImage.layer.cornerRadius = 20
        marsImage.clipsToBounds = true
        
        cameraValueLabel.numberOfLines = 0
        cameraValueLabel.lineBreakMode = .byWordWrapping
        
        cameraStackView.alignment = .top
        cameraStackView.distribution = .fill
        
        roverStackView.spacing = 6
        cameraStackView.spacing = 6
        dateStackView.spacing = 6
    }
    
    private func updateUIConstraints() {
        marsImage.translatesAutoresizingMaskIntoConstraints = false
        roverStackView.translatesAutoresizingMaskIntoConstraints = false
        cameraStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            marsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            marsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            marsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            marsImage.widthAnchor.constraint(equalToConstant: 130),
            
            roverStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            roverStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            cameraStackView.topAnchor.constraint(equalTo: roverStackView.bottomAnchor, constant: 6),
            cameraStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cameraStackView.trailingAnchor.constraint(equalTo: marsImage.leadingAnchor, constant: -10),
            
            
            dateStackView.topAnchor.constraint(equalTo: cameraStackView.bottomAnchor, constant: 6),
            dateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
}
