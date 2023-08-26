import Foundation

class MemoUserDatas {
    static let shared = MemoUserDatas()
    
    private let userdata = UserDefaults.standard
    
    private var saveMemoList: [MemoData] = []
    
    private init() {}
    
    
    // MARK: - SETUP DATA

    func encodeData(memoList: [MemoData]) {
        if let data = try? JSONEncoder().encode(memoList) {
            UserDefaults.standard.set(data, forKey: "memoList")
        }
    }
    
    func decodeData(saveMemoData: Data) {
        if let data = UserDefaults.standard.data(forKey: "memoList") {
            if let readData = try? JSONDecoder().decode([MemoData].self, from: saveMemoData) {
                saveMemoList = readData
            }
        }
    }
    
    func updateData() {
        
    }
    
    func completeData() {
        
    }
    
    func recoveryData() {
        
    }
}
