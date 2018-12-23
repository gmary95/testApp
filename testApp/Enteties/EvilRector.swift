class EvilRector: Rector {
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func getName() -> String {
        return "EvilRector # \(self.id)"
    }
    
    func swapStudent(dormitories: [Dormitory]) { //TODO: - change id of Student
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
                print("\(self.getName()) swap \(student.getName()) from \(dormitoryFrom.getName()) to \(dormitoryTo.getName())")
            }
        }
    }
}
