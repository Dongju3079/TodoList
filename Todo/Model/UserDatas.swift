import Foundation

class MemoUserDatas {
    static let shared = MemoUserDatas()
    
    private let userdata = UserDefaults.standard
    
    var saveMemoList: [MemoData] = []
    
    var categoryList: [String] = []
    
    private init() {}
    
    
    // MARK: - SETUP DATA
    
    func saveMemoData() {
        if let data = try? JSONEncoder().encode(saveMemoList) {
            UserDefaults.standard.set(data, forKey: "memoList")
        }
    }
    
    func readMemoData() {
        if let data = UserDefaults.standard.data(forKey: "memoList") {
            if let readData = try? JSONDecoder().decode([MemoData].self, from: data) {
                saveMemoList = readData
            }
        }
    }
    
    func saveCategory() {
        UserDefaults.standard.set(self.categoryList, forKey: "categoryList")
    }
    
    func readCategory() {
        guard let categorys = UserDefaults.standard.array(forKey: "categoryList") as? [String] else { return }
        categoryList = categorys
    }
    
    func updateData() {
        
    }
    
    func completeData() {
        
    }
    
    func recoveryData() {
        
    }
}
