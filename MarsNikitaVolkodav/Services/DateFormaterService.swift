import Foundation

final class DateFormaterService {
    
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    } //"June 6, 2019"
}
