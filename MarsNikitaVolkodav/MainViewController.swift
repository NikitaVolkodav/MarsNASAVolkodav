import UIKit

final class MainViewController: UIViewController {
    
    private let customNavigationBar = CustomNavigationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setActionForButtons()
        view.addSubview(customNavigationBar)
        
    }
    
    private func setActionForButtons() {
        addActionCpuButton()
        addActionCameraButton()
        addActionPlusButton()
        addActionCalendarButton()
    }
    
    private func addActionCpuButton() {
        customNavigationBar.setCpuButtonAction { [weak self] in
//            guard let self = self else { return } тут правильно!
            guard let _ = self else { return }
            print("Cpu")
        }
    }
    
    private func addActionCameraButton() {
        customNavigationBar.setCameraButtonAction { [weak self] in
            guard let _ = self else { return }
            print("Camera")
        }
    }
    
    private func addActionPlusButton() {
        customNavigationBar.setPlusButtonAction { [weak self] in
            guard let _ = self else { return }
            print("Plus")
        }
    }
    
    private func addActionCalendarButton() {
        customNavigationBar.setCalendarButtonAction { [weak self] in
            guard let _ = self else { return }
            print("Calendar")
        }
    }
    
}
