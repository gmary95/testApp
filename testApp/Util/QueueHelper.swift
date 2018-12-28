import Foundation

class QueueHelper {
    
    static public func synchronized<L: NSLocking, T: Any>(lockable: L, criticalSection: () -> T) -> T {
        lockable.lock()
        let result = criticalSection()
        lockable.unlock()
        return result
    }
    
    static public func synchronizedWithoutDeadlock<L: NSRecursiveLock>(mainLock: L, secondaryLock: L, criticalSection: () -> ()) {
            mainLock.lock()
            while !secondaryLock.try() {
                mainLock.unlock()
                mainLock.lock()
            }
            criticalSection()
            secondaryLock.unlock()
            mainLock.unlock()
    }
}
