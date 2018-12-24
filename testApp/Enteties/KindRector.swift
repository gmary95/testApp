import Foundation

class KindRector: Rector {
    private var totalMoney: Int
    private var totalBear: Int
    private var id: Int
    
    private let lock = NSLock()
    
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
    
    func donateBeer(dormitoryArray: inout SynchronizedArray<Dormitory>) {
        QueueHelper.synchronized(lockable: lock) {
            if let dormitory: Dormitory = dormitoryArray.randomItem() {
                if let student = dormitory.studentArray.randomItem() {
                    self.totalBear -= RectorSettings.giftBeer
                    student.putBeer(amount: RectorSettings.giftBeer)
                    print("\(self.getName()) donate beer \(student.getName()). Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
                }
            }
        }
    }
    
    func donateMoney(dormitoryArray: inout SynchronizedArray<Dormitory>) {
        QueueHelper.synchronized(lockable: lock) {
            if let dormitory: Dormitory = dormitoryArray.randomItem() {
                if let student = dormitory.studentArray.randomItem() {
                    self.totalMoney -= RectorSettings.giftCash
                    student.putMoney(amount: RectorSettings.giftCash)
                    print("\(self.getName()) donate cash \(student.getName()). Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
                }
            }
        }
    }
}
