import Foundation

protocol SelectedDateDelegate: AnyObject {
    func selectedDate(_ date: Date)
}

protocol SelectedCameraDelegate: AnyObject {
    func selectedCamera(_ camera: String)
}

protocol SelectedCpuDelegate: AnyObject {
    func selectedCpu(_ cpu: String)
}

protocol SelectedHistoryCell: AnyObject {
    func selectedHistoryCell(camera: String, earthDate: Date)
}
