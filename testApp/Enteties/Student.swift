import Foundation

class Student: Equatable {
    private var totalMoney: Int
    private var totalBear: Int
    private var buhichedAmount: Int
    var id: Int
    
    let locker = NSLock()
    let moneyLocker = NSLock()
    
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
        locker.lock()
        var result: Int = 0
        result = totalBear
        locker.unlock()
        return result
    }
    
    func getMoney() -> Int {
        moneyLocker.lock()
        var result: Int = 0
        result = totalMoney
        moneyLocker.unlock()
        return result
    }
    
    func getBuhichedAmount() -> Int {
        locker.lock()
        var result: Int = 0
        result = buhichedAmount
        locker.unlock()
        return result
    }
    
    func drinkBeer(with student: Student) {
        locker.lock()
        student.locker.lock()
        self.decreaseBeeer(amount: StudentAmountSettings.buhichedAmount)
        self.increaseBuhichedBeer(amount: StudentAmountSettings.buhichedAmount)
        
        student.decreaseBeeer(amount: StudentAmountSettings.buhichedAmount)
        student.increaseBuhichedBeer(amount: StudentAmountSettings.buhichedAmount)
        print("\(self.getName()) (Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) drinking. ")
        student.locker.unlock()
        locker.unlock()
    }
    
    func sellBeer(to student: Student) {
        locker.lock()
        student.locker.lock()
        self.totalBear -= StudentAmountSettings.soldBeer
        student.putBeer(amount: StudentAmountSettings.soldBeer)
        print("\(self.getName())(Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) and \(student.getName())(Amount of beer = \(student.totalBear), Amount of money = \(student.totalMoney)) swap beer.")
        student.locker.unlock()
        locker.unlock()

        
        moneyLocker.lock()
        student.moneyLocker.lock()
        self.totalMoney += StudentAmountSettings.costBeer
        student.putMoney(amount: StudentAmountSettings.costBeer)
        print("\(self.getName())(Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) and \(student.getName())(Amount of beer = \(student.totalBear), Amount of money = \(student.totalMoney)) swap money.")
        student.moneyLocker.unlock()
        moneyLocker.unlock()
    }
    
    func donateBeer(to student: Student) {
        locker.lock()
        student.locker.lock()
        self.decreaseBeeer(amount: StudentAmountSettings.giftBeer)
        student.putBeer(amount: StudentAmountSettings.giftBeer)
        print("\(self.getName())(Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) and \(student.getName())(Amount of beer = \(student.totalBear), Amount of money = \(student.totalMoney)) donate beer.")
        student.locker.unlock()
        locker.unlock()
    }
    
    internal func putBeer(amount: Int) {
        self.totalBear += amount
        print("\(self.getName()) get beer from rector. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
    
    internal func putMoney(amount: Int) {
        self.totalMoney += amount
        print("\(self.getName()) get money from rector. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
    
    private func decreaseBeeer(amount: Int) {
        self.totalBear -= amount
        print("\(self.getName()) decrease beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
    
    private func increaseBuhichedBeer(amount: Int) {
        self.buhichedAmount += amount
        print("\(self.getName()) increase buhiched beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
    
    func equalTo(rhs: Student) -> Bool {
        return self.id == rhs.id
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id
    }
}
