import UIKit
import CoreData

public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func createFilter(rover: String, camera: String, date: Date) {
        guard let filterEntityDescription = NSEntityDescription.entity(forEntityName: "Filters", in: context) else { return }
        let filter = Filters(entity: filterEntityDescription, insertInto: context)
        filter.rover = rover
        filter.camera = camera
        filter.date = date
        
        appDelegate.saveContext()
    }
    
    public func fetchFilters() -> [Filters] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Filters")
        do {
            return try context.fetch(fetchRequest) as! [Filters]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func deleteFilter(_ filterModel: Filters) {
        context.delete(filterModel)
        appDelegate.saveContext()
    }
}
