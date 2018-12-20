struct KindRector: Rector {
    private var totalMoney: Int
    private var totalBear: Int
    
    init(totalMoney: Int, totalBear: Int) {
        self.totalMoney = totalMoney
        self.totalBear = totalBear
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
