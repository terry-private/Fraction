import Foundation

public protocol Fractional: Equatable, Comparable {
    var fraction: Fraction { get }
}

extension Int: Fractional {
    public var fraction: Fraction {
        return Fraction(self)
    }
}
