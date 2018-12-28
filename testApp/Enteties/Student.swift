import Foundation

class Student {
    private var totalMoney: Int
    private var totalBear: Int
    private var buhichedAmount: Int
    
    var id: Int
    
    let beerLocker = NSRecursiveLock()
    let moneyLocker = NSRecursiveLock()
    
    init(totalMoney: Int, totalBear: Int, buhichedAmount: Int, id: Int) {
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.buhichedAmount = buhichedAmount
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
    
    func getBuhichedAmount() -> Int {
        return QueueHelper.synchronized(lockable: beerLocker) {
            return buhichedAmount
        }
    }
    
    func drinkBeer(with student: Student) {
        QueueHelper.synchronizedWithoutDeadlock(mainLock: beerLocker, secondaryLock: student.beerLocker) {
            self.decreaseBeeer(amount: StudentAmountSettings.buhichedAmount)
            self.increaseBuhichedBeer(amount: StudentAmountSettings.buhichedAmount)
            
            student.decreaseBeeer(amount: StudentAmountSettings.buhichedAmount)
            student.increaseBuhichedBeer(amount: StudentAmountSettings.buhichedAmount)
            print("\(self.getName()) (Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) drinking. ")
        }
    }
    
    func sellBeer(to student: Student) {
        QueueHelper.synchronizedWithoutDeadlock(mainLock: beerLocker, secondaryLock: student.beerLocker) {
            self.decreaseBeeer(amount: StudentAmountSettings.soldBeer)
            student.putBeer(amount: StudentAmountSettings.soldBeer)
            print("\(self.getName())(Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) and \(student.getName())(Amount of beer = \(student.totalBear), Amount of money = \(student.totalMoney)) swap beer.")
        }
        
        
        QueueHelper.synchronizedWithoutDeadlock(mainLock: moneyLocker, secondaryLock: student.moneyLocker) {
            self.putMoney(amount: StudentAmountSettings.costBeer)
            student.decreaseMoney(amount: StudentAmountSettings.costBeer)
            print("\(self.getName())(Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) and \(student.getName())(Amount of beer = \(student.totalBear), Amount of money = \(student.totalMoney)) swap money.")
        }
    }
    
    func donateBeer(to student: Student) {
        QueueHelper.synchronizedWithoutDeadlock(mainLock: beerLocker, secondaryLock: student.beerLocker) {
            self.decreaseBeeer(amount: StudentAmountSettings.giftBeer)
            student.putBeer(amount: StudentAmountSettings.giftBeer)
            print("\(self.getName())(Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)) and \(student.getName())(Amount of beer = \(student.totalBear), Amount of money = \(student.totalMoney)) donate beer.")
        }
    }
    
    internal func putBeer(amount: Int) {
        self.totalBear += amount
        print("\(self.getName()) get beer from rector. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
    
    internal func putMoney(amount: Int) {
        self.totalMoney += amount
        print("\(self.getName()) get money from rector. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
    private func decreaseMoney(amount: Int) {
        self.totalMoney -= amount
        print("\(self.getName()) decrease money. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
    private func decreaseBeeer(amount: Int) {
        self.totalBear -= amount
        print("\(self.getName()) decrease beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
    
    private func increaseBuhichedBeer(amount: Int) {
        self.buhichedAmount += amount
        print("\(self.getName()) increase buhiched beer. Amount of beer = \(self.totalBear), Amount of money = \(self.totalMoney)")
    }
}

extension Student: UniversityEntety {
    func getName() -> String {
        return "Student # \(self.id)"
    }
}

extension Student: Equatable {
    
    func equalTo(rhs: Student) -> Bool {
        return self.id == rhs.id
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id
    }
}
