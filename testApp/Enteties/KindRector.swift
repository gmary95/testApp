import Foundation

class KindRector: Rector {
    
    private var totalMoney: Int
    private var totalBear: Int
    private var id: Int
    
    private let beerLocker = NSLock()
    private let moneyLocker = NSLock()
    
    init(totalMoney: Int, totalBear: Int, id: Int) {
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.id = id
    }
    
    func getName() -> String {
        return "KindRector # \(self.id)"
    }
    
    func getBeer() -> Int {
        beerLocker.lock()
        let result = totalBear
        beerLocker.unlock()
        return result
    }
    
    func getMoney() -> Int {
        moneyLocker.lock()
        let result = totalMoney
        moneyLocker.unlock()
        return result
    }
    
    func donateBeer(to student: Student) {
        beerLocker.lock()
        student.beerLocker.lock()
        self.totalBear -= RectorSettings.giftBeer
        student.putBeer(amount: RectorSettings.giftBeer)
        print("\(self.getName()) donate beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        student.beerLocker.unlock()
        beerLocker.unlock()
    }
    
    func donateMoney(to student: Student) {
        moneyLocker.lock()
        student.moneyLocker.lock()
        self.totalMoney -= RectorSettings.giftCash
        student.putMoney(amount: RectorSettings.giftCash)
        print("\(self.getName()) donate cash. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        student.moneyLocker.unlock()
        moneyLocker.unlock()
    }
}
