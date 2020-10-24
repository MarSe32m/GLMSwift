// Sorry for my mathematical background!
// | m11 m12 |
// | m21 m22 |

public typealias mat2i = Matrix2<Int>
public typealias mat2u = Matrix2<UInt>
public typealias mat2d = Matrix2<Double>
public typealias mat2f = Matrix2<Float>
public typealias mat2  = mat2f

/// Object that represents a 2 by 2 matrix
/// The matrix is COLUMN-major, so passing this to the shader is done with the transpose parameter set to GL_FALSE
public struct Matrix2<T>: CustomStringConvertible, Equatable where T: Numeric, T: SIMDScalar {
    public private(set) var elements: [T] = Array<T>(repeating: 0, count: 4)

    public var m11: T
    public var m21: T

    public var m12: T
    public var m22: T

    public var description: String {
        return """
         __________________________
        (\(m11)    \(m12))
        (\(m21)    \(m22))
         ~~~~~~~~~~~~~~~~~~~~~~~~~~
        """
    }

    public var transpose: Matrix2<T> {
        return Matrix2<T>(m11, m12,
                          m21, m22)
    }

    public var determinant: T {
        m11 * m22 - m12 * m21
    }

    public init() {
        m11 = 1
        m12 = 0
        m21 = 0
        m22 = 1
    }

    public init(_ diagonal: T) {
        m11 = diagonal
        m12 = 0
        m21 = 0
        m22 = diagonal
    }

    public init(_ array: [T]) {
        precondition(array.count == 4, "Wrong amount of elements")
        m11 = array[0]
        m12 = array[1]
        m21 = array[2]
        m22 = array[3]
    }

    public init(_ m11: T, _ m12: T,
                _ m21: T, _ m22: T) {
        self.m11 = m11
        self.m12 = m12
        self.m21 = m21
        self.m22 = m22
    }
    
    public subscript(m: Int, n: Int) -> T {
        get {
            switch (m, n) {
                case (1, 1): return m11
                case (1, 2): return m12
                case (2, 1): return m21
                case (2, 2): return m22
                case (_, _): preconditionFailure("Index out of bounds, m: \(m), n: \(n)")
            }
        }
        set {
            switch (m, n) {
                case (1, 1): m11 = newValue
                case (1, 2): m12 = newValue
                case (2, 1): m21 = newValue
                case (2, 2): m22 = newValue
                case (_, _): preconditionFailure("Index out of bounds, m: \(m), n: \(n)")
            }
        }
    }

    public static func +(lhs: Matrix2<T>, rhs: Matrix2<T>) -> Matrix2<T> {
        var result = Matrix2<T>()
        result.m11 = lhs.m11 + rhs.m11
        result.m12 = lhs.m12 + rhs.m12
        result.m21 = lhs.m21 + rhs.m21
        result.m22 = lhs.m22 + rhs.m22
        return result
    }

    public static func +=(lhs: inout Matrix2<T>, rhs: Matrix2<T>) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Matrix2<T>, rhs: Matrix2<T>) -> Matrix2<T> {
        var result = Matrix2<T>()
        result.m11 = lhs.m11 - rhs.m11
        result.m12 = lhs.m12 - rhs.m12
        result.m21 = lhs.m21 - rhs.m21
        result.m22 = lhs.m22 - rhs.m22
        return result
    }

    public static func -=(lhs: inout Matrix2<T>, rhs: Matrix2<T>) {
        lhs = lhs - rhs
    }

    public static prefix func -(matrix: Matrix2<T>) -> Matrix2<T> {
        -1 * matrix
    }

    public static func *(lhs: T, rhs: Matrix2<T>) -> Matrix2<T> {
        var result = Matrix2<T>()
        result.m11 = lhs * rhs.m11
        result.m12 = lhs * rhs.m12
        result.m21 = lhs * rhs.m21
        result.m22 = lhs * rhs.m22
        return result
    }

    public static func *(lhs: Matrix2<T>, rhs: T) -> Matrix2<T> {
        var result = Matrix2<T>()
        result.m11 = lhs.m11 * rhs
        result.m12 = lhs.m12 * rhs
        result.m21 = lhs.m21 * rhs
        result.m22 = lhs.m22 * rhs
        return result
    }

    public static func *=(lhs: inout Matrix2<T>, rhs: T) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix2<T>, rhs: Matrix2<T>) -> Matrix2<T> {
        var result = Matrix2<T>()
        result.m11 = lhs.m11 * rhs.m11 + lhs.m12 * rhs.m21
        result.m12 = lhs.m11 * rhs.m12 + lhs.m12 * rhs.m22
        result.m21 = lhs.m21 * rhs.m11 + lhs.m22 * rhs.m21
        result.m22 = lhs.m21 * rhs.m12 + lhs.m22 * rhs.m22
        return result
    }

    public static func *=(lhs: inout Matrix2<T>, rhs: Matrix2<T>) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix2<T>, rhs: Vector2<T>) -> Vector2<T> {
        Vector2<T>(lhs.m11 * rhs.x + lhs.m12 * rhs.y, lhs.m21 * rhs.x + lhs.m22 * rhs.y)
    }

    public static func *(lhs: Vector2<T>, rhs: Matrix2<T>) -> Vector2<T> {
        Vector2<T>(lhs.x * rhs.m11 + lhs.y * rhs.m21, lhs.x * rhs.m12 + lhs.y * rhs.m22)
    }
}

public extension Matrix2 where T: BinaryFloatingPoint {
    var inverse: Matrix2<T> {
        let invDet = 1 / determinant
        return Matrix2<T>(m22 * invDet, -m12 * invDet,
                          -m21 * invDet, m11 * invDet)
    }

    static func /(lhs: Matrix2<T>, rhs: T) -> Matrix2<T> {
        let invRhs = 1 / rhs
        return Matrix2<T>(lhs.m11 * invRhs, lhs.m12 * invRhs, 
                          lhs.m21 * invRhs, lhs.m22 * invRhs)
    }

    static func /=(lhs: inout Matrix2<T>, rhs: T) {
        lhs = lhs / rhs
    }
}

public extension Matrix2 where T: BinaryInteger {
    var inverse: Matrix2<T> {
        let invDet = 1 / Double(determinant)
        return Matrix2<T>(T(Double(m22) * invDet), T(-Double(m12) * invDet),
                          T(-Double(m21) * invDet), T(Double(m11) * invDet))
    }

    static func /<U: BinaryFloatingPoint>(lhs: Matrix2<T>, rhs: U) -> Matrix2<T> {
        let invRhs = 1 / rhs
        return Matrix2<T>(T(U(lhs.m11) * invRhs), T(U(lhs.m12) * invRhs),
                          T(U(lhs.m21) * invRhs), T(U(lhs.m22) * invRhs))
    }

    static func /=<U: BinaryFloatingPoint>(lhs: inout Matrix2<T>, rhs: U) {
        lhs = lhs / rhs
    }
}