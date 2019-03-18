import UIKit

class GoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var star: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //изначально прячем звездочку
        self.star.isHidden = true
    }
    
    func animate() {
        print("🚀 animation")
        //показываем звездочку
        self.star.isHidden = false
        //делаем звездочку меньше
        self.star.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        //делаем анимацию увеличения, задержка 0.1
        UIView.animate(withDuration: 0.45, delay: 0.1, animations: {
            self.star.transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { complete in
            //делаем анимаю уменьшения
            UIView.animate(withDuration: 0.3, animations: {
                self.star.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { _ in
                //возвращаем к исходному размеру здездочку даже если анимация не закончилась
                self.star.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
}
