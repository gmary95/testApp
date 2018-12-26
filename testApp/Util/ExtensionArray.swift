import Foundation

extension Array {
    
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        let element = self[index]
        return element
    }
    
}
