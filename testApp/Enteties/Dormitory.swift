import Foundation

class Dormitory: Equatable {
    private var studentArray: SynchronizedArray<Student>
    var id: Int
    
    init(studentArray: SynchronizedArray<Student>, id: Int) {
        self.studentArray = studentArray
        self.id = id
    }
    
    func getName() -> String {
        return "Dormitory # \(self.id)"
    }
    
    func getStudent() -> SynchronizedArray<Student> {
        var result = SynchronizedArray<Student>()
        result = studentArray
        return result
    }
    
    func equalTo(rhs: Dormitory) -> Bool {
        return self.id == rhs.id
    }
    
    static func == (lhs: Dormitory, rhs: Dormitory) -> Bool {
        return lhs.id == rhs.id
    }
    
    func removeStudent(student: Student) {
        self.studentArray.remove(where: { (elem) -> Bool in
            return elem == student
        })
    }
    
    func addStudent(student: Student) {
        self.studentArray.append(student)
    }
}
