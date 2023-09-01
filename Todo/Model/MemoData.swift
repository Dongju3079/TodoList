
import Foundation


struct MemoData:Codable, Equatable {
    var memoText: String?
    var category: String?
    var time: String = "00:00:00"
    var date: Date?
    
    var dateString: String? {
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "MM.dd"
            guard let date = self.date else { return "" }
            let savedDateString = myFormatter.string(from: date)
            return savedDateString
        }
}


//struct MemoSection:Codable {
//    var category: String?
//}
