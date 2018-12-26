import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    var actionCount: Int64 = 0
    var dormitoryArray: SynchronizedArray<Dormitory> = SynchronizedArray<Dormitory>()
    var queueArray: [DispatchQueue] = []
    var kindRector: KindRector!
    let evilRector: EvilRector! = EvilRector(id: 0)
    let granny = Granny()
    
    let randomHelper = RandomHelper()
    private let lock = NSLock()
    let semaphore = DispatchSemaphore(value: 1)
    var isStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startBuhich(_ sender: UIButton) {
        if !isStart {
            startButton.setTitle("Stop", for: .normal)
            isStart = true
            kindRector = KindRector(totalMoney: ModelSettings.initKindRectorCash, totalBear: ModelSettings.initKindRectorBeer, id: 0)
            dormitoryArray = SynchronizedArray<Dormitory>()
            for i in 0 ..< ModelSettings.numberOfDormitory {
                var studentArray: [Student] = []
                for j in 0 ..< ModelSettings.dormitoryStudentCapacity {
                    let idStudent = (i * 10) + j
                    studentArray += [Student(totalMoney: ModelSettings.initStudentCash, totalBear: ModelSettings.initStudentBeer, buhichedAmount: 0, id: idStudent)]
                }
                dormitoryArray += [Dormitory(studentArray: SynchronizedArray<Student>(studentArray), id: i)]
            }
            queueArray = []
            for i in 0 ..< ThreadSettings.threadCount {
                queueArray.append(DispatchQueue(label: "com.noosphere.testApp.queue#\(i)", attributes: .concurrent))
            }
            
            granny.calculateBeerAndMoney(dormitories: dormitoryArray, kindRector: kindRector)
            
            for i in 0 ..< ThreadSettings.threadCount {
                queueArray[i].async {[weak self] in
                    while self?.isStart == true {
                        //                    for _ in 0 ..< 10 {
                        self?.chooseAction(on: self?.randomHelper.getRandomNumber(from: 1 ... 6))
                    }
                }
            }
        } else {
            startButton.setTitle("Start", for: .normal)
            isStart = false
            self.chooseAction(on: 6)
        }
    }
    
    func chooseAction(on position: Int?) {
        switch position {
        case 1:
            let dormitory: Dormitory? = self.dormitoryArray.randomItem()
            QueueHelper.synchronized(lockable: lock) {
                if let student = dormitory?.getStudent().randomItem() {
                    student.sellBeer()
                }
            }
            QueueHelper.synchronized(lockable: lock) {
                if let student = dormitory?.getStudent().randomItem() {
                    student.buyBeer()
                }
            }
        case 2:
            QueueHelper.synchronized(lockable: lock) {
                if let dormitory: Dormitory = self.dormitoryArray.randomItem() {
                    if let student1 = dormitory.getStudent().randomItem(), let student2 = dormitory.getStudent().randomItem() {
                        student1.drinkBeer()
                        student2.drinkBeer()
                    }
                }
            }
        case 3:
            QueueHelper.synchronized(lockable: lock) {
                if let dormitory: Dormitory = dormitoryArray.randomItem() {
                    if let student = dormitory.getStudent().randomItem() {
                        self.kindRector.donateMoney()
                        student.putMoney(amount: RectorSettings.giftCash)
                    }
                }
            }
        case 4:
            QueueHelper.synchronized(lockable: lock) {
                if let dormitory: Dormitory = dormitoryArray.randomItem() {
                    if let student = dormitory.getStudent().randomItem() {
                        self.kindRector.donateBeer()
                        student.putBeer(amount: RectorSettings.giftBeer)
                    }
                }
            }
        case 5:
            self.evilRector.swapStudent(dormitories: self.dormitoryArray)
        case 6:
            semaphore.wait()
            self.granny.calculateBeerAndMoney(dormitories: self.dormitoryArray, kindRector: self.kindRector)
            semaphore.signal()
        default:
            break
        }
    }
}

