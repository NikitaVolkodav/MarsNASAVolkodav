import UIKit

final class PhotoViewController: UIViewController {
    
    private let contentView = PhotoContentView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActionCloseButton()
    }
    
    private func addActionCloseButton() {
        contentView.setCloseButtonAction { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
}
