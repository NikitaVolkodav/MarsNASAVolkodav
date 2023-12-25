import Foundation

final class HistoryService {
    static let shared = HistoryService()
    private let userDefault = UserDefaults.standard
    private let keyFilterData = KeyContainer.filterData
    
    var filterRecordHistoryData:[FilterModel]{
        get{
            if let data = userDefault.value(forKey: keyFilterData) as? Data {
                return try! PropertyListDecoder().decode([FilterModel].self, from: data)
            } else {
                return [FilterModel]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                userDefault.set(data, forKey: keyFilterData)
            }
        }
    }
    
    func saveHistoryFilterData(rover: String, camera: String, date: String) {
        let newData = FilterModel(rover: rover, camera: camera, date: date)
        filterRecordHistoryData.append(newData)
    }
    
    func remove(at index: Int) {
        var historyData = filterRecordHistoryData
        guard index < historyData.count else {
            return
        }
        historyData.remove(at: index)
        filterRecordHistoryData = historyData
    }
}
