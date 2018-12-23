class Granny {
    func calculateBeerAndMoney(dormitories: [Dormitory], kindRector: KindRector) -> (Int, Int) {
        var sumOfDormitorysBeer = 0
        var sumOfDormitorysMoney = 0
        var sumOfBuhichedBeer = 0
        dormitories.forEach {
            $0.studentArray.forEach {
                sumOfDormitorysBeer = $0.getBeer()
                sumOfDormitorysMoney = $0.getMoney()
                sumOfBuhichedBeer = $0.getBuhichedAmount()
            }
        }
        
        let sumOfRectorsBeer = kindRector.getBeer()
        let sumOfRectorsMoney = kindRector.getMoney()
        
        let sumOfBeer = sumOfDormitorysBeer + sumOfRectorsBeer + sumOfBuhichedBeer
        let sumOfMoney = sumOfDormitorysMoney + sumOfRectorsMoney
        
        return (sumOfBeer, sumOfMoney)
    }
}
