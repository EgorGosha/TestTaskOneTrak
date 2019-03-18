import UIKit

class StepsTableViewCell: UITableViewCell {
    
    let lineWalk = UIView(frame: .zero)
    let lineAerobic = UIView(frame: .zero)
    let lineRun = UIView(frame: .zero)
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var walkCountLabel: UILabel!
    @IBOutlet weak var aerobicCountLabel: UILabel!
    @IBOutlet weak var runCountLabel: UILabel!
    
    var day: DayObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(lineWalk)
        self.addSubview(lineAerobic)
        self.addSubview(lineRun)
      
        self.lineWalk.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        self.lineAerobic.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        self.lineRun.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
       
        self.lineWalk.frame.size.height = 10
        self.lineAerobic.frame.size.height = 10
        self.lineRun.frame.size.height = 10
    }

    
    func fill(day: DayObject) {
        self.day = day
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = formatter.string(from: day.date)
        
        self.stepsCountLabel.text = "\(day.aerobic + day.run + day.walk)"
        self.walkCountLabel.text = "\(day.walk)"
        self.aerobicCountLabel.text = "\(day.aerobic)"
        self.runCountLabel.text = "\(day.run)"
        self.updateLines()
    }
    
    
    func updateLines() {
        
        let stepSum = day.aerobic + day.run + day.walk
        let cellWidth = bounds.width
        let space: CGFloat = 8
        let inset: CGFloat = 16
        //минус отступы
        let linesWidth = cellWidth - inset * 2 - space * 2
        let oneStepWidth = linesWidth / CGFloat(stepSum)
        
        let walkWidth = CGFloat(day.walk) * oneStepWidth
        let aerobicWidth = CGFloat(day.aerobic) * oneStepWidth
        let runWidth = CGFloat(day.run) * oneStepWidth
        
        self.lineWalk.frame.size.width = walkWidth
        self.lineAerobic.frame.size.width = aerobicWidth
        self.lineRun.frame.size.width = runWidth

        let yPosition = self.dateLabel.frame.maxY + 6
        
        self.lineWalk.frame.origin.y = yPosition
        self.lineAerobic.frame.origin.y = yPosition
        self.lineRun.frame.origin.y = yPosition
       
        //ratio
        
        let walkX: CGFloat = 16
        let aerobicX = walkX + walkWidth + space
        let runX = walkX + walkWidth + aerobicWidth + 2 * space
        
        self.lineWalk.frame.origin.x = walkX
        self.lineAerobic.frame.origin.x = aerobicX
        self.lineRun.frame.origin.x = runX
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateLines()
    }
}
