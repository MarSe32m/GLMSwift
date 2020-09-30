extension Double {
    public var i: Complex<Double> {
        return Complex<Double> (0, self)
    }
}

extension Float {
    public var i: Complex<Float> {
        return Complex<Float> (0, self)
    }
}

public struct Complex<T: FloatingPointArithmeticType>: MatrixType, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, ExpressibleByArrayLiteral {
    public typealias Element = T

    public var real: T
    public var imag: T

    public var elements: [Element] {
        return [real, imag]
    }

    public func makeIterator() -> IndexingIterator<Array<Element>> {
        return elements.makeIterator()
    }

    public subscript(index: Int) -> T {
        get {
            switch(index) {
            case 0: return real
            case 1: return imag
            default: preconditionFailure("Complex index out of range")
            }
        }
        set {
            switch(index) {
            case 0: real = newValue
            case 1: imag = newValue
            default: preconditionFailure("Complex index out of range")
            }
        }
    }

    public var debugDescription: String {
        if imag < 0 {
            return String(describing: type(of: self)) + "(\(real)\(imag)i)"
        } else {
            return String(describing: type(of: self)) + "(\(real)+\(imag)i)"
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(GLMSwift.hash(real.hashValue, imag.hashValue))
    }

    public init() {
        self.real = 0
        self.imag = 0
    }

    public init(_ array: [T]) {
        precondition(array.count == 2, "Complex requires a 2-element array")
        self.real = array[0]
        self.imag = array[1]
    }

    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }

    public init(integerLiteral value: IntegerLiteralType) {
        self.real = T(value)
        self.imag = 0
    }

    public init(floatLiteral value: FloatLiteralType) {
        self.real = T(value)
        self.imag = 0
    }

    public init(_ real: T = 0, _ imag: T = 0) {
        self.real = real
        self.imag = imag
    }

    public init(_ x: Complex<Double>) {
        self.real = T(x.real)
        self.imag = T(x.imag)
    }

    public init(_ x: Complex<Float>) {
        self.real = T(x.real)
        self.imag = T(x.imag)
    }

    // Init from polar components
    public init(rho: T, theta: T) {
        self.real = rho * GLMSwift.SGLcos(theta)
        self.imag = rho * GLMSwift.SGLsin(theta)
    }

    public var abs: T {
        return GLMSwift.SGLsqrt(real * real + imag * imag)
    }

    public var arg: T {
        return GLMSwift.SGLatan(imag, real)
    }

    public var norm: T {
        let a = abs
        return a * a
    }

    public var conj: Complex<T> {
        return Complex<T>(real, -imag)
    }

    public init (_ x: Complex<T>, _ op:(_:T) -> T) {
        self.real = op(x[0])
        self.imag = op(x[1])
    }

    public init (_ s: T, _ x: Complex<T>, _ op:(_:T, _:T) -> T) {
        self.real = op(s, x[0])
        self.imag = op(s, x[1])
    }

    public init (_ x: Complex<T>, _ s: T, _ op:(_:T, _:T) -> T) {
        self.real = op(x[0], s)
        self.imag = op(x[1], s)
    }

    public init (_ x1: Complex<T>, _ x2: Complex<T>, _ op:(_:T, _:T) -> T) {
        self.real = op(x1[0], x2[0])
        self.imag = op(x1[1], x2[1])
    }

    public static func == (x: Complex<T>, y: Complex<T>) -> Bool {
        return x.real == y.real && x.imag == y.imag
    }

    public static func *(x1: Complex<T>, x2: Complex<T>) -> Complex<T> {
        return Complex<T>(
            x1.real * x2.real - x1.imag * x2.imag,
            x1.imag * x2.real + x1.real * x2.imag
        )
    }

    public static func /(x1: Complex<T>, x2: Complex<T>) -> Complex<T> {
        let cd: T = x2.real * x2.real + x2.imag * x2.imag
        let r: T = x1.real * x2.real + x1.imag * x2.imag
        let i: T = x1.imag * x2.real - x1.real * x2.imag
        return Complex<T>(r / cd, i / cd)
    }

    public static func /(x1: Complex<T>, x2: T) -> Complex<T> {
        return Complex<T>(
            x1.real / x2,
            x1.imag / x2
        )
    }

    public static func /(x1: T, x2: Complex<T>) -> Complex<T> {
        let cd = x2.real * x2.real + x2.imag * x2.imag
        return Complex<T>(
            (x1 * x2.real) / cd,
            (-x1 * x2.imag) / cd
        )
    }
}
