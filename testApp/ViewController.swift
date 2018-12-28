import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    var actionCount: Int64 = 0
    var dormitoryArray: SynchronizedArray<Dormitory> = SynchronizedArray<Dormitory>()
    var universityLiveQueue: DispatchQueue!
    var kindRector: KindRector!
    let evilRector: EvilRector! = EvilRector(id: 0)
    let granny = Granny()
    var actions: [() -> Void]!
    
    private let queue = DispatchQueue(label: "com.noosphere.testApp.syncStudent", attributes: .concurrent)
    private let randomHelper = RandomHelper()
    private let dormitoryLocker = NSRecursiveLock()
    private var isStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actions = [
        {
            self.makeSomeActionWithTwoRandomStudentsFromOneDormitory { (student1, student2) in
                student1.sellBeer(to: student2)
            }
            },
        {
            self.makeSomeActionWithTwoRandomStudentsFromOneDormitory { (student1, student2) in
                student1.donateBeer(to: student2)
            }
            },
        {
            self.makeSomeActionWithTwoRandomStudentsFromOneDormitory { (student1, student2) in
                student1.drinkBeer(with: student2)
            }
            },
        self.f1(act: self.kindRector.donateMoney),
        self.f1(act: self.kindRector.donateBeer),
        self.f2(act: self.evilRector.swapStudent),
        self.f3
        ]
    }
    
    @IBAction func startBuhich(_ sender: UIButton) {
        if !isStart {
            startButton.setTitle("Stop", for: .normal)
            isStart = true
            
            initializeAllEnteties()
            
            granny.calculateBeerAndMoney(queueForWorkWithStudent: queue, dormitoryLocker: dormitoryLocker, dormitories: dormitoryArray, kindRector: kindRector)
            (0 ..< ThreadSettings.threadCount).forEach { _ in
                universityLiveQueue.async {[weak self] in
                    while self?.isStart == true {
                        self?.makeRandomAction()
                    }
                }
            }
        } else {
            startButton.setTitle("Start", for: .normal)
            isStart = false
            
            f3()
        }
    }
    
    private func initializeAllEnteties() {
        kindRector = KindRector(totalMoney: InitialSettings.initKindRectorCash, totalBear: InitialSettings.initKindRectorBeer, id: 0)
        dormitoryArray = SynchronizedArray<Dormitory>()
        for i in 0 ..< InitialSettings.numberOfDormitory {
            var studentArray: [Student] = []
            for j in 0 ..< InitialSettings.dormitoryStudentCapacity {
                let idStudent = (i * 10) + j
                studentArray += [Student(totalMoney: InitialSettings.initStudentCash, totalBear: InitialSettings.initStudentBeer, buhichedAmount: 0, id: idStudent)]
            }
            dormitoryArray += [Dormitory(studentArray: SynchronizedArray<Student>(studentArray), id: i)]
        }
        universityLiveQueue = DispatchQueue(label: "com.noosphere.testApp.universityLiveQueue", attributes: .concurrent)
    }
    
    private func makeRandomAction() {
        if let randomAction = actions.randomItem() {
            randomAction()
        }
    }
    
    private func makeSomeActionWithTwoRandomStudentsFromOneDormitory(action: @escaping (Student, Student) -> Void) {
        if let dormitory: Dormitory = self.dormitoryArray.randomItem() {
            var studentsInDormitory: SynchronizedArray<Student> = SynchronizedArray<Student>()
            QueueHelper.synchronized(lockable: dormitoryLocker) {
                studentsInDormitory = SynchronizedArray<Student>(dormitory.getStudent().flatMap{$0})
            }
            if let student1 = studentsInDormitory.randomItem(), let student2 = studentsInDormitory.randomItem() {
                queue.sync {
                    action(student1, student2)
                }
            }
        }
    }
    
    private func makeSomeActionWithKindRectorAndrandomStudent(action: (Student) -> Void) {
        if let dormitory: Dormitory = dormitoryArray.randomItem() {
            if let student = dormitory.getStudent().randomItem() {
                queue.sync {
                    action(student)
                }
            }
        }
    }
    
    private func makeSomeActionWithEvilRectorAndrandomStudent(action: (SynchronizedArray<Dormitory>) -> Void) {
        QueueHelper.synchronized(lockable: dormitoryLocker) {
            queue.sync {
                action(self.dormitoryArray)
            }
        }
    }
    
    private func f1(act: @escaping (Student) -> Void) -> (() -> Void) {
        return {[weak self] in
            self?.makeSomeActionWithKindRectorAndrandomStudent { (student) in
                act(student)
            }
        }
    }
    
    private func f2(act: @escaping (SynchronizedArray<Dormitory>) -> Void) -> (() -> Void) {
        return {[weak self] in
            self?.makeSomeActionWithEvilRectorAndrandomStudent { (dormitoryArray) in
                act(dormitoryArray)
            }
        }
    }
    
    private func f3() {
        self.granny.calculateBeerAndMoney(queueForWorkWithStudent: queue, dormitoryLocker: self.dormitoryLocker, dormitories: self.dormitoryArray, kindRector: self.kindRector)
    }
}

