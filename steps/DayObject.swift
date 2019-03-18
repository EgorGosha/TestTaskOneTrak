import Foundation

class DayObject {
    
    let date: Date
    let aerobic: Int
    let run: Int
    let walk: Int
   
  
    init(date: TimeInterval, aerobic: Int, run: Int, walk: Int) {
        self.aerobic = aerobic
        self.run = run
        self.walk = walk
        self.date = Date(timeIntervalSince1970: date/1000)
   
    }
}
