import Foundation

protocol SelectedDateDelegate: AnyObject {
    func selectedDate(_ date: Date)
}

protocol SelectedCameraDelegate: AnyObject {
    func selectedCamera(_ camera: String)
}
