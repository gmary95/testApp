struct EvilRector: Rector {
    private var id: Int64
    
    init(id: Int64) {
        self.id = id
    }
    
    func getName() -> String {
        return "EvilRector # \(self.id)"
    }
    
    func swapStudent(dormitories: [Dormitory]) {
        if var dormitoryFrom: Dormitory = dormitories.randomElement() {
            var dormitoryTo = dormitoryFrom
            while dormitoryTo == dormitoryFrom {
                if let dormitory = dormitories.randomElement() {
                    dormitoryTo = dormitory
                }
            }
            if let student = dormitoryFrom.studentArray.randomElement() {
                dormitoryFrom.removeStudent(student: student)
                dormitoryTo.addStudent(student: student)
            }
        }
    }
}
