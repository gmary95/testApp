import Foundation

class KindRector: Rector {
    
    private var totalMoney: Int
    private var totalBear: Int
    private var id: Int
    
    private let lock = NSLock()
    
    init(totalMoney: Int, totalBear: Int, id: Int) {
        lock.lock()
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.id = id
        lock.unlock()
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
    
    func donateBeer() {
        QueueHelper.synchronized(lockable: lock) {
            self.totalBear -= RectorSettings.giftBeer
            print("\(self.getName()) donate beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        }
    }
    
    func donateMoney() {
        QueueHelper.synchronized(lockable: lock) {
            self.totalMoney -= RectorSettings.giftCash
            print("\(self.getName()) donate cash. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        }
    }
}
