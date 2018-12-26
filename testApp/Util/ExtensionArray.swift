import Foundation

extension Array {
    
    func randomItem() -> Element? {
        let lock = NSLock()
        lock.lock()
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        let element = self[index]
        lock.unlock()
        return element
    }
    
}
