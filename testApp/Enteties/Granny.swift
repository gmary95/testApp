import Foundation

class Granny {
    private let lock = NSLock()
    
    func calculateBeerAndMoney(dormitories: SynchronizedArray<Dormitory>, kindRector: KindRector) {
        QueueHelper.synchronized(lockable: lock) {
            let dormitoriesArray = dormitories
                .flatMap { $0 }
            let rector = kindRector
            //            var sumOfDormitorysBeer = 0
            //            var sumOfDormitorysMoney = 0
            //            var sumOfBuhichedBeer = 0
            
            //        for i in 0 ..< doZZ
            //            if let dormitory = dormitoriesArray[i] {
            //                print(" count \(dormitory.studentArray.count)")
            //                for j in 0 ..< dormitory.studentArray.count {
            //                    if let student = dormitory.studentArray[j] {
            //                        sumOfDormitorysBeer += student.getBeer()
            //                        sumOfDormitorysMoney += student.getMoney()
            //                        sumOfBuhichedBeer += student.getBuhichedAmount()
            //                    }
            //                }
            //            }
            //            }
            let sumOfDormitorysBeer = dormitoriesArray
                .map({$0.studentArray.enumerated()
                    .map({ (arg0) -> Int in
                        
                        let (i, elem) = arg0
                        print(i)
                        return elem.getBeer()
                    })
                })
                .compactMap { $0 }
                .flatMap { $0 }
                .reduce(0, +)
            
            let sumOfDormitorysMoney = dormitoriesArray
                .map({$0.studentArray.enumerated()
                    .map({ (arg0) -> Int in
                        
                        let (i, elem) = arg0
                        print(i)
                        return elem.getMoney()
                    })
                })
                .compactMap { $0 }
                .flatMap { $0 }
                .reduce(0, +)
            
            let sumOfBuhichedBeer = dormitoriesArray
                .map({$0.studentArray.enumerated()
                    .map({ (arg0) -> Int in
                        
                        let (i, elem) = arg0
                        print(i)
                        return elem.getBuhichedAmount()
                    })
                })
                .compactMap { $0 }
                .flatMap { $0 }
                .reduce(0, +)
            
            let sumOfRectorsBeer = rector.getBeer()
            let sumOfRectorsMoney = rector.getMoney()
            
            let sumOfBeer = sumOfDormitorysBeer + sumOfRectorsBeer + sumOfBuhichedBeer
            let sumOfMoney = sumOfDormitorysMoney + sumOfRectorsMoney
            
            print("Granny amount of beer = \(sumOfBeer), Amount of money = \(sumOfMoney)")
        }
    }
}
