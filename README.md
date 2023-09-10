# Fraction
Structure representing a fraction

```swift
// init
let f = Fraction(1, 3) // 1/3
let f = 3.fraction // 3/1 ...Int is Fractional
let f = Fraction(3) // 3/1

// auto approx
let f = Fraction(2, 6) // 1/3

// four arithmetic operations
let f = Fraction(1, 4) + Fraction(1, 12) // 1/4 + 1/12 = 1/3
let f = Fraction(1, 2) - Fraction(1, 6) // 1/2 - 1/6 = 1/3
let f = Fraction(1, 2) * Fraction(2, 3) // 1/2 * 2/3 = 1/3 
let f = Fraction(1, 2) / Fraction(3, 2) // 1/2 / 3/2 = 1/3

// operations with Fractional(Int)
let f = 1 - Fraction(2, 3) // 1 - 2/3 = 1/3
let f = 1.fraction / 3 // 1/1 / 3 = 1/3
```
