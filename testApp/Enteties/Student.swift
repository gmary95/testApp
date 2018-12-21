struct Student: Equatable {
    private var totalMoney: Int
    private var totalBear: Int
    private var buhichedAmount: Int
    private var id: Int64
    
    init(totalMoney: Int, totalBear: Int, buhichedAmount: Int, id: Int64) {
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.buhichedAmount = buhichedAmount
        self.id = id
    }
    
    func getName() -> String {
        return "Student # \(self.id)"
    }
    
    mutating func sellBeer() {
        self.totalBear -= StudentAmountSettings.soldBeer
        self.totalMoney += StudentAmountSettings.costBeer
    }
    
    mutating func buyBeer() {
        self.totalBear += StudentAmountSettings.soldBeer
        self.totalMoney -= StudentAmountSettings.costBeer
    }
    
    mutating func getBeer(amount: Int) {
        self.totalBear += amount
    }
    
    mutating func getMoney(amount: Int) {
        self.totalMoney += amount
    }
    
    func equalTo(rhs: Student) -> Bool {
        return self.id == rhs.id
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id
    }
}
