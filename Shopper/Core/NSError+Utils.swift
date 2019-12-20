import Foundation

extension NSError {
    convenience init(error: String) {
        self.init(domain: error, code: 0, userInfo: nil)
    }
}
