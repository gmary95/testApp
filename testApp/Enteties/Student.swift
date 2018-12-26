import Foundation

class Student: Equatable {
    private var totalMoney: Int
    private var totalBear: Int
    private var buhichedAmount: Int
    var id: Int
    
    fileprivate let queue = DispatchQueue(label: "com.noosphere.testApp.SynchronizedStudent", attributes: .concurrent)
    
    init(totalMoney: Int, totalBear: Int, buhichedAmount: Int, id: Int) {
        QueueHelper.lock.lock()
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.buhichedAmount = buhichedAmount
        self.id = id
        QueueHelper.lock.unlock()
    }
    
    func getName() -> String {
        return "Student # \(self.id)"
    }
    
    func getBeer() -> Int {
        var result: Int = 0
        queue.sync {
            result = totalBear
        }
        return result
    }
    
    func getMoney() -> Int {
        var result: Int = 0
        queue.sync {
            result = totalMoney
        }
        return result
    }
    
    func getBuhichedAmount() -> Int {
        var result: Int = 0
        queue.sync {
            result = buhichedAmount
        }
        return result
    }
    
    func drinkBeer() {
        queue.async(flags: .barrier) {
            self.totalBear -= StudentAmountSettings.buhichedAmount
            self.buhichedAmount += StudentAmountSettings.buhichedAmount
            print("\(self.getName()) (Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) drinking. ")
        }
        
    }
    
    func sellBeer() {
        queue.async(flags: .barrier) {
            self.totalBear -= StudentAmountSettings.soldBeer
            self.totalMoney += StudentAmountSettings.costBeer
            print("\(self.getName()) sold beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        }
    }
    
    func buyBeer() {
        queue.async(flags: .barrier) {
            self.totalBear += StudentAmountSettings.soldBeer
            self.totalMoney -= StudentAmountSettings.costBeer
            print("\(self.getName()) bougth beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        }
    }
    
    func putBeer(amount: Int) {
       queue.async(flags: .barrier) {
            self.totalBear += amount
            print("\(self.getName()) get beer from rector. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        }
    }
    
    func putMoney(amount: Int) {
        queue.async(flags: .barrier) {
            self.totalMoney += amount
            print("\(self.getName()) get money from rector. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        }
    }
    
    func equalTo(rhs: Student) -> Bool {
        return self.id == rhs.id
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id
    }
}
