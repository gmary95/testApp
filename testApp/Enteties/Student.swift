class Student: Equatable {
    private var totalMoney: Int
    private var totalBear: Int
    private var buhichedAmount: Int
    private var id: Int
    
    init(totalMoney: Int, totalBear: Int, buhichedAmount: Int, id: Int) {
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.buhichedAmount = buhichedAmount
        self.id = id
    }
    
    func getName() -> String {
        return "Student # \(self.id)"
    }
    
    func getBeer() -> Int {
        return totalBear
    }
    
    func getMoney() -> Int {
        return totalMoney
    }
    
    func getBuhichedAmount() -> Int {
        return buhichedAmount
    }
    
    func drinkBeer(with student: inout Student) {
        self.totalBear -= StudentAmountSettings.buhichedAmount
        self.buhichedAmount += StudentAmountSettings.buhichedAmount
        student.totalBear -= StudentAmountSettings.buhichedAmount
        student.buhichedAmount += StudentAmountSettings.buhichedAmount
        print("\(self.getName()) and \(student.getName()) drinking")
    }
    
    func sellBeer() {
        self.totalBear -= StudentAmountSettings.soldBeer
        self.totalMoney += StudentAmountSettings.costBeer
        print("\(self.getName()) sold beer")
    }
    
    func buyBeer() {
        self.totalBear += StudentAmountSettings.soldBeer
        self.totalMoney -= StudentAmountSettings.costBeer
        print("\(self.getName()) bougth beer")
    }
    
    func putBeer(amount: Int) {
        self.totalBear += amount
        print("\(self.getName()) get beer from rector")
    }
    
    func putMoney(amount: Int) {
        self.totalMoney += amount
        print("\(self.getName()) get money from rector")
    }
    
    func equalTo(rhs: Student) -> Bool {
        return self.id == rhs.id
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id
    }
}
