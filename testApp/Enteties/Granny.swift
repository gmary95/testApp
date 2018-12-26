import Foundation

class Granny {
    
    func calculateBeerAndMoney(dormitories: SynchronizedArray<Dormitory>, kindRector: KindRector) {
        QueueHelper.synchronized(lockable: QueueHelper.lock) {
            print("start")
            
            let someArray: [[Student]] = dormitories.flatMap{Array<Student>($0.getStudent().flatMap{Student(totalMoney: Int($0.getMoney()), totalBear: Int($0.getBeer()), buhichedAmount: Int($0.getBuhichedAmount()), id: $0.id)})}
            let rector = KindRector(totalMoney: Int(kindRector.getMoney()), totalBear: Int(kindRector.getBeer()), id: 0)
            print(Unmanaged.passUnretained(rector).toOpaque())
            print(Unmanaged.passUnretained(kindRector).toOpaque())
            
            print("start calc beer")
            let sumOfDormitorysBeer = someArray
                .map({$0.enumerated()
                    .map({ (arg0) -> Int in
                        
                        let (i, elem) = arg0
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
                    .map({ (arg0) -> Int in
                        
                        let (i, elem) = arg0
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
                    .map({ (arg0) -> Int in
                        
                        let (i, elem) = arg0
                        print("\(i) \(elem.id)")
                        return elem.getBuhichedAmount()
                    })
                })
                .compactMap { $0 }
                .flatMap { $0 }
                .reduce(0, +)
            print("stop calc buchich \(sumOfBuhichedBeer)")
            
            let sumOfRectorsBeer = rector.getBeer()
            print("rector beer \(sumOfRectorsBeer)")
            let sumOfRectorsMoney = rector.getMoney()
            print("rector beer \(sumOfRectorsMoney)")
            
            let sumOfBeer = sumOfDormitorysBeer + sumOfRectorsBeer + sumOfBuhichedBeer
            let sumOfMoney = sumOfDormitorysMoney + sumOfRectorsMoney
            print("stop")
            
            print("Granny amount of beer = \(sumOfBeer), Amount of money = \(sumOfMoney)")
        }
    }
}
