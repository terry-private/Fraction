import Foundation

public struct Fraction: Sendable, Hashable, Codable {
    private static let maxExponent = 16 // Int.maxは18桁だがn * 10^17だとはみ出る可能性があるので一桁下げる
    public private(set) var numerator: Int
    public private(set) var denominator: Int {
        // 分母に値をセットすることと割り算をすることを同義と考えて分母に値をセットするタイミングで0値エラーを検出します。
        didSet{
            precondition(denominator != .zero, "Division by 0")
        }
    }
}

// MARK: - init
public extension Fraction {
    init(_ numerator: Int, _ denominator: Int = 1) {
        let negativeSign = numerator * denominator >= 0 ? 1 : -1
        self.numerator = abs(numerator) * negativeSign
        self.denominator = abs(denominator)
        approx()
    }

    // Intの最大可能な桁数-1で丸める
    init(_ decimal: Decimal) {
        let log10: Int
        let strings = abs(decimal).description.split(separator: ".")
        if strings.count == 2 {
            log10 = max(0, strings[1].count - (strings[0].count-1))
        } else {
            log10 = 0
        }
        denominator = Int(pow(10, max(0, Double(min(Self.maxExponent, log10)))))
        numerator = Int((decimal * Decimal(denominator)).description.split(separator: ".")[0])!
        approx()
    }
}

// MARK: - Conversion to other numeric types
public extension Fraction {
    var double: Double {
        return Double(numerator) / Double(denominator)
    }
    
    var decimal: Decimal {
        return Decimal(numerator) / Decimal(denominator)
    }
    
    /// Greater than or equal to 1
    var wholePart: Int {
        return numerator / denominator
    }
    
    /// Less than 1
    var fractionalPart: Fraction {
        Fraction(numerator % denominator, denominator)
    }
}

// MARK: - 各種演算
public extension Fraction {
    // MARK: +
    static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        let newNumerator = lhs.numerator * rhs.denominator + rhs.numerator * lhs.denominator
        let newDenominator = lhs.denominator * rhs.denominator
        return Fraction(newNumerator, newDenominator)
    }
    static func + (lhs: Fraction, rhs: some Fractional) -> Fraction {
        return lhs + rhs.fraction
    }
    static func + (lhs: some Fractional, rhs: Fraction) -> Fraction {
        return lhs.fraction + rhs
    }
    
    // MARK: -
    static func - (lhs: Fraction, rhs: Fraction) -> Fraction {
        let newNumerator = lhs.numerator * rhs.denominator - rhs.numerator * lhs.denominator
        let newDenominator = lhs.denominator * rhs.denominator
        return Fraction(newNumerator, newDenominator)
    }
    static func - (lhs: Fraction, rhs: some Fractional) -> Fraction {
        return lhs - rhs.fraction
    }
    static func - (lhs: some Fractional, rhs: Fraction) -> Fraction {
        return lhs.fraction - rhs
    }
    
    // MARK: *
    static func * (lhs: Fraction, rhs: Fraction) -> Fraction {
        let newNumerator = lhs.numerator * rhs.numerator
        let newDenominator = lhs.denominator * rhs.denominator
        return Fraction(newNumerator, newDenominator)
    }
    static func * (lhs: Fraction, rhs: some Fractional) -> Fraction {
        return lhs * rhs.fraction
    }
    static func * (lhs: some Fractional, rhs: Fraction) -> Fraction {
        return lhs.fraction * rhs
    }
    
    // MARK: /
    static func / (lhs: Fraction, rhs: Fraction) -> Fraction {
        let newNumerator = lhs.numerator * rhs.denominator
        let newDenominator = lhs.denominator * rhs.numerator
        return Fraction(newNumerator, newDenominator)
    }
    static func / (lhs: Fraction, rhs: some Fractional) -> Fraction {
        return lhs / rhs.fraction
    }
    static func / (lhs: some Fractional, rhs: Fraction) -> Fraction {
        return lhs.fraction / rhs
    }
}

// MARK: - Comparable
extension Fraction: Comparable {
    public static func < (lhs: Fraction, rhs: Fraction) -> Bool {
        return (lhs - rhs).numerator < 0
    }
}

// MARK: - Equatable
extension Fraction: Equatable {
    public static func == (lhs: Fraction, rhs: Fraction) -> Bool {
        return (lhs - rhs).numerator == 0
    }
}

// MARK: - CustomStringConvertible
extension Fraction: CustomStringConvertible {
    public var description: String {
        if denominator == 1 {
            return String(numerator)
        }
        return "\(numerator)/\(denominator)"
    }
}

// MARK: - Internal method
extension Fraction {
    /// 約分
    mutating func approx() {
        if numerator == 0 { return }
        let gcd = gcd(abs(numerator), denominator)
        numerator /= gcd
        denominator /= gcd
    }
}

/// ユークリッドの互除法を使った最大公約数
func gcd(_ lhs: Int, _ rhs: Int) -> Int {
    rhs == 0 ? lhs : gcd(rhs, lhs % rhs)
}
