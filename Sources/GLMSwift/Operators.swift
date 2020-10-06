

// Arithmetic Operators

public prefix func ++<T: MatrixType>(v: inout T) -> T {
    v = v + 1
    return v
}

public postfix func ++<T: MatrixType>(v: inout T) -> T {
    let r = v
    v = v + 1
    return r
}

public prefix func --<T: MatrixType>(v: inout T) -> T {
    v = v - 1
    return v
}

public postfix func --<T: MatrixType>(v: inout T) -> T {
    let r = v
    v = v - 1
    return r
}

public func +<T: MatrixType>(x1: T, x2: T) -> T {
    
    return T(x1, x2, +)
}

public func +=<T: MatrixType>(x1: inout T, x2: T) {
    x1 = x1 + x2
}

public func +<T: MatrixType>(s: T.Element, x: T) -> T {
    return T(s, x, +)
}

public func +<T: MatrixType>(x: T, s: T.Element) -> T {
    return T(x, s, +)
}

public func +=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x + s
}

public func -<T: MatrixType>(x1: T, x2: T) -> T {
    
    return T(x1, x2, -)
}

public func -=<T: MatrixType>(x1: inout T, x2: T) {
    x1 = x1 - x2
}

public func -<T: MatrixType>(s: T.Element, x: T) -> T {
    return T(s, x, -)
}

public func -<T: MatrixType>(x: T, s: T.Element) -> T {
    return T(x, s, -)
}

public func -=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x - s
}

public func *<T: MatrixType>(s: T.Element, x: T) -> T {
    
    return T(s, x, *)
}

public func *<T: MatrixType>(x: T, s: T.Element) -> T {
    
    return T(x, s, *)
}

public func *=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x * s
}

public func /<T: MatrixType>(s: T.Element, x: T) -> T {
    return T(s, x, /)
}

public func /<T: MatrixType>(x: T, s: T.Element) -> T {
    return T(x, s, /)
}

public func /=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x / s
}

public func %<T: MatrixType>(x1: T, x2: T) -> T {
    return T(x1, x2, %)
}

public func %=<T: MatrixType>(x1: inout T, x2: T) {
    x1 = x1 % x2
}

public func %<T: MatrixType>(s: T.Element, x: T) -> T {
    return T(s, x, %)
}

public func %<T: MatrixType>(x: T, s: T.Element) -> T {
    return T(x, s, %)
}

public func %=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x % s
}

// Unchecked Integer Operators

public func &+<T: MatrixType>(v1: T, v2: T) -> T where T.Element: FixedWidthInteger {
    
    return T(v1, v2, &+)
}

public func &+<T: MatrixType>(s: T.Element, v: T) -> T where T.Element: FixedWidthInteger {
    return T(s, v, &+)
}

public func &+<T: MatrixType>(v: T, s: T.Element) -> T where T.Element: FixedWidthInteger {
    return T(v, s, &+)
}

public func &-<T: MatrixType>(v1: T, v2: T) -> T where T.Element: FixedWidthInteger {
    
    return T(v1, v2, &-)
}

public func &-<T: MatrixType>(s: T.Element, v: T) -> T where T.Element: FixedWidthInteger {
    return T(s, v, &-)
}

public func &-<T: MatrixType>(v: T, s: T.Element) -> T where T.Element: FixedWidthInteger {
    return T(v, s, &-)
}

public func &*<T: MatrixType>(v1: T, v2: T) -> T where T.Element: FixedWidthInteger {
    
    return T(v1, v2, &*)
}

public func &*<T: MatrixType>(s: T.Element, v: T) -> T where T.Element: FixedWidthInteger {
    
    return T(s, v, &*)
}

public func &*<T: MatrixType>(v: T, s: T.Element) -> T where T.Element: FixedWidthInteger {
    
    return T(v, s, &*)
}

public func << <T: MatrixType>(v: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(v, s, <<)
}

public func <<= <T: MatrixType>(v: inout T, s: T.Element) where T.Element: BitsOperationsType {
    v = v << s
}

public func >> <T: MatrixType>(v: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(v, s, <<)
}

public func >>= <T: MatrixType>(v: inout T, s: T.Element) where T.Element: BitsOperationsType {
    v = v >> s
}

public func &<T: MatrixType>(x1: T, x2: T) -> T where T.Element: BitsOperationsType {
    return T(x1, x2, &)
}

public func &=<T: MatrixType>(x1: inout T, x2: T) where T.Element: BitsOperationsType {
    x1 = x1 & x2
}

public func &<T: MatrixType>(s: T.Element, x: T) -> T where T.Element: BitsOperationsType {
    return T(s, x, &)
}

public func &<T: MatrixType>(x: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(x, s, &)
}

public func &=<T: MatrixType>(x: inout T, s: T.Element) where T.Element: BitsOperationsType {
    x = x & s
}

public func |<T: MatrixType>(x1: T, x2: T) -> T where T.Element: BitsOperationsType {
    return T(x1, x2, |)
}

public func |=<T: MatrixType>(x1: inout T, x2: T) where T.Element: BitsOperationsType {
    x1 = x1 | x2
}

public func |<T: MatrixType>(s: T.Element, x: T) -> T where T.Element: BitsOperationsType {
    return T(s, x, |)
}

public func |<T: MatrixType>(x: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(x, s, |)
}

public func |=<T: MatrixType>(x: inout T, s: T.Element) where T.Element: BitsOperationsType {
    x = x | s
}

public func ^<T: MatrixType>(v1: T, v2: T) -> T where T.Element: BitsOperationsType {
    return T(v1, v2, ^)
}

public func ^=<T: MatrixType>(x1: inout T, x2: T) where T.Element: BitsOperationsType {
    x1 = x1 ^ x2
}

public func ^<T: MatrixType>(s: T.Element, x: T) -> T where T.Element: BitsOperationsType {
    return T(s, x, ^)
}

public func ^<T: MatrixType>(x: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(x, s, ^)
}

public func ^=<T: MatrixType>(x: inout T, s: T.Element) where T.Element: BitsOperationsType {
    x = x ^ s
}

public prefix func ~<T: MatrixType>(v: T) -> T where T.Element: BitsOperationsType {
    return T(v, ~)
}

// Signed Numbers Only

public prefix func +<T: MatrixType>(v: T) -> T where T.Element: SignedNumeric {
    return v
}

public prefix func -<T: MatrixType>(x: T) -> T where T.Element: SignedNumeric {
    
    return T(x, -)
}

// Vector Multiply and Divide

public func *<T: VectorType>(v1: T, v2: T) -> T {
    
    return T(v1, v2, *)
}

public func *=<T: VectorType>(v1: inout T, v2: T) {
    v1 = v1 * v2
}

public func /<T: VectorType>(v1: T, v2: T) -> T {
    
    return T(v1, v2, /)
}

public func /=<T: VectorType>(v1: inout T, v2: T) {
    v1 = v1 / v2
}
