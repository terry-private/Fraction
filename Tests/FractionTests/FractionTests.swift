import XCTest
@testable import Fraction

final class FractionTests: XCTestCase {
    func testCalculation() {
        XCTAssertEqual(Fraction(1) + Fraction(2), Fraction(3))
        XCTAssertEqual(Fraction(1) + 2, Fraction(3))
        
        XCTAssertEqual(Fraction(1, 2) - Fraction(1, 3), Fraction(1, 6))
        XCTAssertEqual(1 - Fraction(1, 2), Fraction(1, 2))
        
        XCTAssertEqual(Fraction(1, 12) * Fraction(3), Fraction(1, 4))
        XCTAssertEqual(Fraction(1, 12) * 3, Fraction(1, 4))
        
        XCTAssertEqual(Fraction(8) / Fraction(12), Fraction(2, 3))
        XCTAssertEqual(Fraction(8) / 12, Fraction(2, 3))
    }
    
    func testEquatable() {
        XCTAssertTrue(Fraction(1) == Fraction(3, 3))
        XCTAssertTrue(Fraction(3, 3) == Fraction(1))
        XCTAssertFalse(Fraction(1) == Fraction(2, 3))
        XCTAssertFalse(Fraction(2, 3) == Fraction(1))
   }
    
    func testComparable() {
        XCTAssertTrue(Fraction(1) < Fraction(2))
        XCTAssertFalse(Fraction(2) < Fraction(1))
        print(Fraction(1, 4).double)
        print(Fraction(1, 4).decimal)
        print(Fraction(-11, 4).wholePart)
        print(Fraction(-11, 4).fractionalPart)
    }
    
    func testConversionToOtherNumericThpes() {
        let fraction = Fraction(-11, 4)
        XCTAssertEqual(fraction.double, -2.75)
        XCTAssertEqual(fraction.decimal, -2.75)
        XCTAssertEqual(fraction.wholePart, -2)
        XCTAssertEqual(fraction.fractionalPart, Fraction(-3, 4))
        XCTAssertEqual(fraction.wholePart + fraction.fractionalPart, fraction)
    }
}
