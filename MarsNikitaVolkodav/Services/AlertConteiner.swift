import UIKit

struct AlertConteiner {
    
    static func showAlertSaveFilters(_ self: UIViewController ) {
        let alertController = UIAlertController(title: "Save Filters", message: "The current filters and the date you have chosen can be saved to the filter history.", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlertMenuFilter(_ self: UIViewController ) {
        let alertController = UIAlertController(title: "Menu Filter", message: "", preferredStyle: .actionSheet)
        let useAction = UIAlertAction(title: "Use", style: .default, handler: nil)
        let deletelAction = UIAlertAction(title: "Delete", style: .destructive, handler: nil)
        let cancellAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(useAction)
        alertController.addAction(deletelAction)
        alertController.addAction(cancellAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
