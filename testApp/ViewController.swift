import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var actionCountTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    var actionCount: Int64 = 0
    var dormitoryArray: [Dormitory] = []
    var queueArray: [DispatchQueue] = []
    var kindRector: KindRector = KindRector(totalMoney: ModelSettings.initKindRectorCash, totalBear: ModelSettings.initKindRectorBeer, id: 0)
    let evilRector: EvilRector = EvilRector(id: 0)
    let granny = Granny()
    
    let randomHelper = RandomHelper()
    var isStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionCountTextField.text = actionCount.description
    }
    
    @IBAction func startBuhich(_ sender: UIButton) {
        if !isStart {
            actionCount = Int64(actionCountTextField.text ?? "0")!
            if actionCount > 0 {
                startButton.setTitle("Stop", for: .normal)
                isStart = true
                dormitoryArray = []
                for i in 0 ..< ModelSettings.numberOfDormitory {
                    var studentArray: [Student] = []
                    for j in 0 ..< ModelSettings.dormitoryStudentCapacity {
                        let idStudent = (i * 10) + j
                        studentArray += [Student(totalMoney: ModelSettings.initStudentCash, totalBear: ModelSettings.initStudentBeer, buhichedAmount: 0, id: idStudent)]
                    }
                    dormitoryArray += [Dormitory(studentArray: studentArray, id: i)]
                }
                queueArray = []
                for i in 0 ..< ThreadSettings.threadCount {
                    queueArray.append(DispatchQueue(label: "com.noosphere.testApp.queue#\(i)"))
                }
                
                let (sumOfBeer, sumOfMoney) = granny.calculateBeerAndMoney(dormitories: dormitoryArray, kindRector: kindRector)
                print("amount of beer = \(sumOfBeer), amount of money = \(sumOfMoney)")
                
                for i in 0 ..< ThreadSettings.threadCount {
                    queueArray[i].async {[weak self] in
//                        while self?.isStart == true {
                        for _ in 0 ..< 2 {
                            self?.chooseAction(on: self?.randomHelper.getRandomNumber(from: 1 ... 5))
                        }
                    }
                }
            }
        } else {
            startButton.setTitle("Start", for: .normal)
            isStart = false
            let (sumOfBeer, sumOfMoney) = granny.calculateBeerAndMoney(dormitories: dormitoryArray, kindRector: kindRector)
            print("amount of beer = \(sumOfBeer), amount of money = \(sumOfMoney)")
        }
    }
    
    func chooseAction(on position: Int?) {
        switch position {
        case 1:
            if let dormitory: Dormitory = self.dormitoryArray.randomElement() {
                if var student1 = dormitory.studentArray.randomElement(), var student2 = dormitory.studentArray.randomElement() {
                    student1.sellBeer()
                    student2.buyBeer()
                }
            }
        case 2:
            if let dormitory: Dormitory = self.dormitoryArray.randomElement() {
                if var student1 = dormitory.studentArray.randomElement(), var student2 = dormitory.studentArray.randomElement() {
                    student1.drinkBeer(with: &student2)
                }
            }
        case 3:
            if let dormitory: Dormitory = self.dormitoryArray.randomElement() {
                if var student = dormitory.studentArray.randomElement() {
                    self.kindRector.donateMoney(student: &student)
                }
            }
        case 4:
            if let dormitory: Dormitory = self.dormitoryArray.randomElement() {
                if var student = dormitory.studentArray.randomElement() {
                    self.kindRector.donateBeer(student: &student)
                }
            }
        case 5:
            self.evilRector.swapStudent(dormitories: self.dormitoryArray)
        default:
            break
        }
    }
}

