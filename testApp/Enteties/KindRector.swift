class KindRector: Rector {
    private var totalMoney: Int
    private var totalBear: Int
    private var id: Int
    
    init(totalMoney: Int, totalBear: Int, id: Int) {
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.id = id
    }
    
    func getName() -> String {
        return "KindRector # \(self.id)"
    }
    
    func getBeer() -> Int {
        return totalBear
    }
    
    func getMoney() -> Int {
        return totalMoney
    }
    
    func donateBeer(student: inout  Student) {
        self.totalBear -= RectorSettings.giftBeer
        student.putBeer(amount: RectorSettings.giftBeer)
        print("\(self.getName()) donate beer \(student.getName())")
    }
    
    func donateMoney(student: inout  Student) {
        self.totalMoney -= RectorSettings.giftCash
        student.putMoney(amount: RectorSettings.giftCash)
        print("\(self.getName()) donate cash \(student.getName())")
    }
}
