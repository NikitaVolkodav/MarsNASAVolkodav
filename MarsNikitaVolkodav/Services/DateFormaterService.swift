import Foundation

final class DateFormaterService {
    
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }//"June 6, 2019"
    
    func formatStringDateToString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM d, yyyy"
            let formattedString = outputFormatter.string(from: date)
            return formattedString
        } else {
            print("Ошибка при преобразовании строки в дату")
            return nil
        }
    }
    
    func formatDateToStringForNetwork(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }//2024-12-26
    
    
}
