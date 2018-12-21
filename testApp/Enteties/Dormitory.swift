struct Dormitory: Equatable {
    var studentArray: [Student]
    private var id: Int64
    
    init(studentArray: [Student], id: Int64) {
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
    
    mutating func removeStudent(student: Student) {
        var i = 0
        studentArray.forEach {
            if $0 == student {
                self.studentArray.remove(at: i)
            }
            i += 1
        }
    }
    
    mutating func addStudent(student: Student) {
        studentArray.append(student)
    }
}
