import Foundation

class Granny {
    
    func calculateBeerAndMoney(queueForWorkWithStudent: DispatchQueue,dormitoryLocker: NSRecursiveLock, dormitories: SynchronizedArray<Dormitory>, kindRector: KindRector) {
        print("start")
        
        
        queueForWorkWithStudent.async(flags: .barrier) {
            let someArray = dormitories.flatMap{Array<Student>($0.getStudent().flatMap{Student(totalMoney: Int($0.getMoney()), totalBear: Int($0.getBeer()), buhichedAmount: Int($0.getBuhichedAmount()), id: $0.id)})}
            
            let sumOfRectorsBeer = Int(kindRector.getBeer())
            let sumOfRectorsMoney = Int(kindRector.getMoney())
            
            queueForWorkWithStudent.async {
                print("rector beer \(sumOfRectorsBeer)")
                print("rector beer \(sumOfRectorsMoney)")
                
                print("start calc beer")
                let sumOfDormitorysBeer = someArray
                    .map({$0.enumerated()
                        .map({ (i, elem) -> Int in
                            print("\(i) \(elem.id)")
                            return elem.getBeer()
                        })
                    })
                    .compactMap { $0 }
                    .flatMap { $0 }
                    .reduce(0, +)
                print("stop calc beer \(sumOfDormitorysBeer)")
                
                print("start calc money")
                let sumOfDormitorysMoney = someArray
                    .map({$0.enumerated()
                        .map({ (i, elem) -> Int in
                            print("\(i) \(elem.id)")
                            return elem.getMoney()
                        })
                    })
                    .compactMap { $0 }
                    .flatMap { $0 }
                    .reduce(0, +)
                print("stop calc money \(sumOfDormitorysMoney)")
                
                print("start calc buchich")
                let sumOfBuhichedBeer = someArray
                    .map({$0.enumerated()
                        .map({ (i, elem) -> Int in
                            print("\(i) \(elem.id)")
                            return elem.getBuhichedAmount()
                        })
                    })
                    .compactMap { $0 }
                    .flatMap { $0 }
                    .reduce(0, +)
                print("stop calc buchich \(sumOfBuhichedBeer)")
                
                
                
                let sumOfBeer = sumOfDormitorysBeer + sumOfRectorsBeer + sumOfBuhichedBeer
                let sumOfMoney = sumOfDormitorysMoney + sumOfRectorsMoney
                print("stop")
                
                print("Granny amount of beer = \(sumOfBeer), Amount of money = \(sumOfMoney)")
            }
        }
    }
}
