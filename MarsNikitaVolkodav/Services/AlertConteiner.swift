import UIKit

struct AlertConteiner {
    
    static func showAlertSaveFilters(_ viewController: UIViewController, completion: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: "Save Filters", message: "The current filters and the date you have chosen can be saved to the filter history.", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            completion(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            completion(action)
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }

    static func showAlertMenuFilter(_ viewController: UIViewController, completion: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: "Menu Filter", message: "", preferredStyle: .actionSheet)

        let useAction = UIAlertAction(title: "Use", style: .default) { action in
            completion(action)
        }

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            completion(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            completion(action)
        }

        alertController.addAction(useAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true, completion: nil)
    }

}
