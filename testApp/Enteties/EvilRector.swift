import Foundation

class EvilRector: Rector {
    private var id: Int
    
    private let lock = NSLock()
    
    init(id: Int) {
        self.id = id
    }
    
    func getName() -> String {
        return "EvilRector # \(self.id)"
    }
    
    func swapStudent(dormitories: SynchronizedArray<Dormitory>) { //TODO: - change id of Student
        QueueHelper.synchronized(lockable: lock) {
            if let dormitoryFrom: Dormitory = dormitories.randomItem() {
                var dormitoryTo = dormitoryFrom
                while dormitoryTo == dormitoryFrom {
                    if let dormitory = dormitories.randomItem() {
                        dormitoryTo = dormitory
                    }
                }
                if let student = dormitoryFrom.studentArray.randomItem() {
                    dormitoryFrom.removeStudent(student: student)
                    dormitoryTo.addStudent(student: student)
                    print("\(self.getName()) swap \(student.getName()) from \(dormitoryFrom.getName()) to \(dormitoryTo.getName())")
                }
            }
        }
    }
}
