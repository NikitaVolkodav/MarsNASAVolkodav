import UIKit

final class CameraViewController: UIViewController {
    
    private let contentView = CameraContentView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActionForButtons()
    }
}

// MARK: - Set Action For Buttons
private extension CameraViewController {
    private func setActionForButtons() {
        addActionCloseButton()
        addActionDoneButton()
    }
    
    private func addActionCloseButton() {
        contentView.setCloseButtonAction { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }
    
    private func addActionDoneButton() {
        contentView.setDoneButtonAction { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            let selectedCamera = self.contentView.getSelectedCamera()
        }
    }
}
