struct Student {
    private var totalMoney: Int
    private var totalBear: Int
    private var buhichedAmount: Int
    
    init(totalMoney: Int, totalBear: Int, buhichedAmount: Int) {
        self.totalMoney = totalMoney
        self.totalBear = totalBear
        self.buhichedAmount = buhichedAmount
    }
    
    mutating func sellBeer() {
        self.totalBear -= StudentAmountSettings.soldBeer
        self.totalMoney += StudentAmountSettings.costBeer
    }
    
    mutating func buyBeer() {
        self.totalBear += StudentAmountSettings.soldBeer
        self.totalMoney -= StudentAmountSettings.costBeer
    }
    
    
}
