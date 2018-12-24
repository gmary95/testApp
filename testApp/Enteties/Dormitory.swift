import Foundation

class Dormitory: Equatable {
    var studentArray: SynchronizedArray<Student>
    private var id: Int
    
    private let lock = NSLock()
    
    init(studentArray: SynchronizedArray<Student>, id: Int) {
        self.studentArray = studentArray
        self.id = id
    }
    
    func getName() -> String {
        return "Dormitory # \(self.id)"
    }
    
    func equalTo(rhs: Dormitory) -> Bool {
        return self.id == rhs.id
    }
    
    static func == (lhs: Dormitory, rhs: Dormitory) -> Bool {
        return lhs.id == rhs.id
    }
    
    func removeStudent(student: Student) {
        QueueHelper.synchronized(lockable: lock) {
            studentArray.remove(where: { (elem) -> Bool in
                return elem == student
            })
//            let newArray = studentArray.filter { $0 != student }
//            studentArray = SynchronizedArray<Student>(newArray)
        }
    }
    
    func addStudent(student: Student) {
        studentArray.append(student)
    }
}
