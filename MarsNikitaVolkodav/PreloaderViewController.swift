import UIKit
import Lottie

final class PreloaderViewController: UIViewController {
            
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var loaderView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationIconView()
        configurationLoaderView()
        
#warning("поставить 5 секунд")
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction() {
        let mainViewController = MainViewController()
        mainViewController.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(mainViewController, animated: true)
        loaderView.stop()
    }
    
//    @objc func timerAction() {
//        // Выполняется через 5 секунд
//        let newViewController = MainViewController()
//
//        // Создаем новый UINavigationController с NewViewController в качестве rootViewController
//        let newNavigationController = UINavigationController(rootViewController: newViewController)
//
//        // Заменяем текущий UINavigationController на новый
//        UIApplication.shared.windows.first?.rootViewController = newNavigationController
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
    
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
        #warning("Почитать как работает loaderView")
        loaderView.play()
    }
}
