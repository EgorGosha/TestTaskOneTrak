import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var didAnimate = false
    
    var days = [DayObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Steps"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        self.getData()
      
    }
    
    func getData() {
        let urlString = "https://intern-f6251.firebaseio.com/intern/metric.json"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    return
                }
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any] {
                            for object in json {
                                if let object = object as? [String: Any] {
                                    let date: TimeInterval = object["date"] as! TimeInterval
                                    let aerobic: Int = object["aerobic"] as! Int
                                    let run: Int = object["run"] as! Int
                                    let walk: Int = object["walk"] as! Int
                                    let day = DayObject(date: date, aerobic: aerobic, run: run, walk: walk)
                                    self.days.append(day)
                                }
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                //анимируем зведочку если нужно
                                self.animateStarIfNeeded()
                            }
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
    }
    
    func animateStarIfNeeded() {
        for cell in tableView.visibleCells {
            //берем ячейку которая в которой зведочка из видимых ячеек таблицы
            if let cell = cell as? GoalTableViewCell {
                if days.count > 0 {
                    //берем первый день (можно взять последний – days[days.count - 1])
                    let firstDay = days[0]
                    //считаем сумму
                    let daySum = firstDay.aerobic + firstDay.run + firstDay.walk
                    //если она больше 1000
                    if daySum > 1000 {
                        //если ещё не было анимации, то делаем её
                        if !didAnimate {
                            cell.animate()
                            //после выполнения анимации ставим флаг didAnimate = true, чтобы не было повторения анимации
                            self.didAnimate = true
                        }
                    }
                }
                break
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //количество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.days.count
        }
        if section == 1 {
            return 1
        }
        return 0
    }
    
    //тип ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let day = self.days[indexPath.item]
            let cell = tableView.dequeueReusableCell(withIdentifier: "StepsTableViewCell", for: indexPath) as! StepsTableViewCell
            cell.fill(day: day)
            return cell
        }
        // вторая ячейка
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell", for: indexPath) as! GoalTableViewCell
            return cell
        }
        fatalError()
    }
    
    //высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }
        if indexPath.section == 1 {
            return 44
        }
        return 0
    }
}
