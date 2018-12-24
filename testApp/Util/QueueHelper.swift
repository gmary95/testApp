import Foundation

class QueueHelper {
    private let lock = NSLock()
    
    static public func synchronized<L: NSLocking>(lockable: L, criticalSection: () -> ()) {
        lockable.lock()
        criticalSection()
        lockable.unlock()
    }
}
