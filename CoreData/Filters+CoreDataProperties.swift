import Foundation
import CoreData

@objc(Filters)
public class Filters: NSManagedObject { }

extension Filters {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Filters> {
        return NSFetchRequest<Filters>(entityName: "Filters")
    }

    @NSManaged public var rover: String?
    @NSManaged public var camera: String?
    @NSManaged public var date: Date?

}

extension Filters : Identifiable { }
