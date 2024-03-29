import Foundation

public protocol KHashable: Hashable {
    func hashCode() -> Int32
}
public extension KHashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashCode())
    }
}
public protocol KStringable: CustomStringConvertible {
    func toString() -> String
}
public extension KStringable {
    var description: String {
        return toString()
    }
}