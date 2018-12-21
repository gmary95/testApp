struct KindRector: Rector {
    private var totalMoney: Int
    private var totalBear: Int
    private var id: Int64
    
    init(totalMoney: Int, totalBear: Int, id: Int64) {
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.id = id
    }
    
    func getName() -> String {
        return "KindRector # \(self.id)"
    }
    
    mutating func donateBeer(student: inout  Student) {
        self.totalBear -= RectorSettings.giftBeer
        student.getBeer(amount: RectorSettings.giftBeer)
    }
    
    mutating func donateMoney(student: inout  Student) {
        self.totalMoney -= RectorSettings.giftCash
        student.getMoney(amount: RectorSettings.giftCash)
    }
}
