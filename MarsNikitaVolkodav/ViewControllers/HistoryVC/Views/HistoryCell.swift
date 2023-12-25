import UIKit

final class HistoryCell: UICollectionViewCell {
    static let reuseIdentifier = "HistoryCell"
    
    private let orangeLine = UIView()
    private let filtersLabel = UILabel()
    
    private let roverLabel = InfoLabel(labelText: "Rover:")
    private let cameraLabel = InfoLabel(labelText: "Camera:")
    private let dateLabel = InfoLabel(labelText: "Date:")
    
    var roverValueLabel = ValueLabel(labelText: "Curiosity")
    var cameraValueLabel = ValueLabel(labelText: "Front Hazard Avoidance Camera")
    var dateValueLabel = ValueLabel(labelText: "June 6, 2019")
    
    private let roverStackView = UIStackView()
    private let cameraStackView = UIStackView()
    private let dateStackView = UIStackView()
    
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
    
    private func addSubviews() {
        contentView.addSubview(orangeLine)
        contentView.addSubview(filtersLabel)
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
        orangeLine.backgroundColor = UIColor(named: "accentOne")
        filtersLabel.textColor = UIColor(named: "accentOne")
        filtersLabel.text = "Filters"
        filtersLabel.font = UIFont(name: "SFProDisplay-Bold", size: 22)
        roverStackView.spacing = 6
        cameraStackView.spacing = 6
        dateStackView.spacing = 6
    }
    
    private func updateUIConstraints() {
        filtersLabel.translatesAutoresizingMaskIntoConstraints = false
        orangeLine.translatesAutoresizingMaskIntoConstraints = false
        roverStackView.translatesAutoresizingMaskIntoConstraints = false
        cameraStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                        
            filtersLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            filtersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            filtersLabel.widthAnchor.constraint(equalToConstant: 64),
            
            orangeLine.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            orangeLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            orangeLine.trailingAnchor.constraint(equalTo: filtersLabel.leadingAnchor, constant: -6),
            orangeLine.heightAnchor.constraint(equalToConstant: 1),
            
            roverStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44),
            roverStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            cameraStackView.topAnchor.constraint(equalTo: roverStackView.bottomAnchor, constant: 6),
            cameraStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            dateStackView.topAnchor.constraint(equalTo: cameraStackView.bottomAnchor, constant: 6),
            dateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
}
