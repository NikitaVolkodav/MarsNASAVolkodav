import UIKit

final class PhotoViewController: UIViewController {
    
    private let contentView = PhotoContentView()
    var selectedImage: UIImage?
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActionCloseButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let selectedImage = selectedImage else { return }
        contentView.setPhotoImageView(image: selectedImage)
    }
    
    private func addActionCloseButton() {
        contentView.setCloseButtonAction { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
}
