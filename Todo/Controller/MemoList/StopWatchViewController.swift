import UIKit

class StopWatchViewController: UIViewController {
    
    let memoManager = MemoUserDatas.shared
    
    weak var delegate: WatchDelegate?
    
    lazy var todoTimer: StopWatchView = {
        let t = StopWatchView()
        t.pauseAtion.addTarget(self, action: #selector(pauseAtcion), for: .touchUpInside)
        t.okAtion.addTarget(self, action: #selector(startAtcion), for: .touchUpInside)
        return t
    }()
    
    var memo: MemoData?
    var memoIndex: Int?
    var timeString: String = ""
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = todoTimer
        setupTimer()
        
    }
    
    func setupTimer() {
        if let memoTime = self.memo?.time {
              let timeComponents = memoTime.split(separator: ":").compactMap { Int($0) }
              if timeComponents.count == 3 {
                  let hoursInSeconds = timeComponents[0] * 3600
                  let minutesInSeconds = timeComponents[1] * 60
                  let seconds = timeComponents[2]
                  count = hoursInSeconds + minutesInSeconds + seconds
                  print(count)
              }
          }
        
        self.todoTimer.watchLabel.text = memo?.time
        self.timeString = memo!.time
        
    }
    
    @objc func startAtcion() {
        print(timerCounting)
        if (timerCounting) {
            timerCounting = false
            timer.invalidate() // 타이머 멈춤
            todoTimer.okAtion.setTitle("START", for: .normal)
            todoTimer.watchLabel.textColor = .white
        } else {
            timerCounting = true
            todoTimer.okAtion.setTitle("PAUSE", for: .normal)
            todoTimer.watchLabel.textColor = .green
            timer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        self.memoManager.updateData(number: self.memoIndex, time: self.timeString, oldMemo: self.memo)
        self.delegate?.tableViewUpdate()
    }
    
    @objc func pauseAtcion() {
        
            let alert = UIAlertController(title: "Reset Timer?", message: nil , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "CNACLE", style: .cancel, handler: { (_) in
                // 취소시 행동
            }))
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
                self.count = 0
                self.timerCounting = false
                self.timer.invalidate()
                self.todoTimer.watchLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
                self.timeString = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
                self.todoTimer.okAtion.setTitle("START", for: .normal)
                self.todoTimer.watchLabel.textColor = .white
                self.memoManager.updateData(number: self.memoIndex, time: self.timeString, oldMemo: self.memo)
                self.delegate?.tableViewUpdate()
            }))
            self.present(alert, animated: true, completion: nil)
    }
    
    @objc func timerCounter() {
        count += 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        todoTimer.watchLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
        // 1초인경우 1 / 3600 = 0, (((1 % 3600) = 1) / 60) == 0, (1 % 3600 = 1) % 60 = 1
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    
    
}



