import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var actionCountTextField: UITextField!
    
    var actionCount: Int64 = 0
    var dormitoryArray: [Dormitory] = []
    var queueArray: [DispatchQueue] = []
    let kindRector: KindRector = KindRector(totalMoney: ModelSettings.initKindRectorCash, totalBear: ModelSettings.initKindRectorBeer, id: 0)
    let evilRector: EvilRector = EvilRector(id: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionCountTextField.text = actionCount.description
    }

    @IBAction func startBuhich(_ sender: UIButton) {
        actionCount = Int64(actionCountTextField.text ?? "0")!
        print(actionCount)
        if actionCount > 0 {
            let studentArray = Array<Student>(repeating: Student(totalMoney: ModelSettings.initStudentCash, totalBear: ModelSettings.initStudentBeer, buhichedAmount: 0, id: 0), count: ModelSettings.dormitoryStudentCapacity)
            dormitoryArray = Array<Dormitory>(repeating: Dormitory(studentArray: studentArray, id: 0), count: ModelSettings.numberOfDormitory)
            queueArray = []
            for i in 0 ..< ThreadSettings.threadCount {
                queueArray.append(DispatchQueue(label: "com.noosphere.testApp.queue#\(i)"))
            }
            
            for i in 0 ..< ThreadSettings.threadCount {
                queueArray[i].async {[weak self] in
                    for _ in 0 ..< self!.actionCount {
//                        self.dormitoryArray[0].studentArray[0].sellBeer()
                        print("\(i)")
                    }
                }
            }
        }
    }
    
}

