import Foundation

class Student: Equatable {
    private var totalMoney: Int
    private var totalBear: Int
    private var buhichedAmount: Int
    private var id: Int
    
    private let lock = NSLock()
    
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
        QueueHelper.synchronized(lockable: lock) {
            self.totalBear -= StudentAmountSettings.buhichedAmount
            self.buhichedAmount += StudentAmountSettings.buhichedAmount
            student.totalBear -= StudentAmountSettings.buhichedAmount
            student.buhichedAmount += StudentAmountSettings.buhichedAmount
            print("\(self.getName()) (Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) and \(student.getName()) (Amount of beer = \(student.totalBear), Amount of money = \(student.totalMoney)) drinking. ")
        }
        
    }
    
    func sellBeer() {
        QueueHelper.synchronized(lockable: lock) {
            self.totalBear -= StudentAmountSettings.soldBeer
            self.totalMoney += StudentAmountSettings.costBeer
            print("\(self.getName()) sold beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        }
    }
    
    func buyBeer() {
        QueueHelper.synchronized(lockable: lock) {
            self.totalBear += StudentAmountSettings.soldBeer
            self.totalMoney -= StudentAmountSettings.costBeer
            print("\(self.getName()) bougth beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        }
    }
    
    func putBeer(amount: Int) {
        QueueHelper.synchronized(lockable: lock) {
            self.totalBear += amount
            print("\(self.getName()) get beer from rector. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
        }
    }
    
    func putMoney(amount: Int) {
        QueueHelper.synchronized(lockable: lock) {
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
