class RandomHelper {
    func getRandomNumber(from range: ClosedRange<Int>) -> Int {
        return Int.random(in: range)
    }
}
