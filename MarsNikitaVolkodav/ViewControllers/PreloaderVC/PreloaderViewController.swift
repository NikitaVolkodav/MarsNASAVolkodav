import UIKit
import Lottie

final class PreloaderViewController: UIViewController {
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var loaderView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationIconView()
        configurationLoaderView()
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction() {
        let mainViewController = MainViewController()
        mainViewController.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(mainViewController, animated: true)
        loaderView.stop()
    }
}

private extension PreloaderViewController {
    
    func configurationIconView() {
        iconView.layer.cornerRadius = 30
        iconView.clipsToBounds = true
        iconView.layer.masksToBounds = true
        iconView.layer.shadowOffset = CGSize(width: 2, height: 2)
        iconView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        iconView.layer.shadowOpacity = 1
        iconView.layer.shadowRadius = 1
    }
    
    func configurationLoaderView() {
        loaderView.loopMode = .loop
        loaderView.contentMode = .scaleAspectFill
        loaderView.play()
    }
}
