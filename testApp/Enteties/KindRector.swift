import Foundation

class KindRector: Rector {
    
    private var totalMoney: Int
    private var totalBear: Int
    private var id: Int
    
    let beerLocker = NSRecursiveLock()
    let moneyLocker = NSRecursiveLock()
    
    init(totalMoney: Int, totalBear: Int, id: Int) {
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.id = id
    }
    
    func getBeer() -> Int {
        return QueueHelper.synchronized(lockable: beerLocker) {
            return totalBear
        }
    }
    
    func getMoney() -> Int {
        return QueueHelper.synchronized(lockable: beerLocker) {
            return totalMoney
        }
    }
    
    func donateBeer(to student: Student) {
        QueueHelper.synchronized(lockable: beerLocker) {
            QueueHelper.synchronized(lockable: student.beerLocker) {
                self.decreaseBeeer(amount: RectorSettings.giftBeer)
                student.putBeer(amount: RectorSettings.giftBeer)
                print("\(self.getName()) donate beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
            }
        }
    }
    
    func donateMoney(to student: Student) {
        QueueHelper.synchronized(lockable: moneyLocker) {
            QueueHelper.synchronized(lockable: student.beerLocker) {
                self.decreaseMoney(amount: RectorSettings.giftCash)
                student.putMoney(amount: RectorSettings.giftCash)
                print("\(self.getName()) donate cash. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
            }
        }
    }
    
    private func decreaseMoney(amount: Int) {
        self.totalMoney -= amount
        print("\(self.getName()) decrease money. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
    private func decreaseBeeer(amount: Int) {
        self.totalBear -= amount
        print("\(self.getName()) decrease beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
}

extension KindRector: UniversityEntety {
    func getName() -> String {
        return "KindRector # \(self.id)"
    }
}
