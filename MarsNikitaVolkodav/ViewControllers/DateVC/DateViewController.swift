import UIKit

import UIKit

final class DateViewController: UIViewController {
    
    private let contentView = DateContentView()
    
    weak var selectedDateDelegate: SelectedDateDelegate?
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActionForButtons()
    }
    
    private func removeDimmingView() {
        if let dimmingView = presentingViewController?.view.viewWithTag(123) {
            dimmingView.removeFromSuperview()
        }
    }
}
// MARK: - Set Action For Buttons
private extension DateViewController {
    private func setActionForButtons() {
        addActionCloseButton()
        addActionDoneButton()
    }
    
    private func addActionCloseButton() {
        contentView.setCloseButtonAction { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            self.removeDimmingView()
        }
    }
    
    private func addActionDoneButton() {
        contentView.setDoneButtonAction { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            self.removeDimmingView()
            let selectedDate = self.contentView.getSelectedDate()
            selectedDateDelegate?.selectedDate(selectedDate)
        }
    }
}
