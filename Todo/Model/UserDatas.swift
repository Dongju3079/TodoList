import Foundation

class MemoUserDatas {
    static let shared = MemoUserDatas()
    
    private let userdata = UserDefaults.standard
    
    var saveMemoList: [MemoData] = []
    
    var categoryList: [String] = ["+"]
    
    var completeList: [MemoData] = []
    
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
    
    func updateData(number: Int?, time: String, oldMemo: MemoData?) {
        var newMemo = MemoData()
        guard let oldMemo = oldMemo else { return }
        newMemo.category = oldMemo.category
        newMemo.date = oldMemo.date
        newMemo.memoText = oldMemo.memoText
        newMemo.time = time
        saveMemoList.remove(at: number!)
        saveMemoList.insert(newMemo, at: number!)
        self.saveMemoData()
    }
    
    func completeData(memo: MemoData, index: Int) {
        self.saveMemoList.remove(at: index)
        self.completeList.insert(memo, at: 0)
        saveCompleteMemoData()
    }
    
    func saveCompleteMemoData() {
        if let data = try? JSONEncoder().encode(completeList) {
            UserDefaults.standard.set(data, forKey: "completeMemoList")
        }
    }
    
    func readCompleteMemoData() {
        if let data = UserDefaults.standard.data(forKey: "completeMemoList") {
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
    
    func recoveryData() {
        
    }
}
