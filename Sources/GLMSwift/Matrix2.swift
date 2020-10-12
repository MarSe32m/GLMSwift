// Sorry for my mathematical background!
// | m11 m12 |
// | m21 m22 |

public typealias mat2i = Matrix2<Int>
public typealias mat2u = Matrix2<UInt>
public typealias mat2d = Matrix2<Double>
public typealias mat2f = Matrix2<Float>
public typealias mat2  = mat2f

/// Object that represents a 2 by 2 matrix
/// The matrix is ROW-major, so passing this to the shader is done with the transpose parameter set to GL_TRUE
public struct Matrix2<T>: CustomStringConvertible, Equatable where T: Numeric, T: SIMDScalar {
    public private(set) var elements: [T] = Array<T>(repeating: 0, count: 4)

    public var description: String {
        return """
         __________________________
        (\(elements[0])    \(elements[1]))
        (\(elements[2])    \(elements[3]))
         ~~~~~~~~~~~~~~~~~~~~~~~~~~
        """
    }

    public var transpose: Matrix2<T> {
        return Matrix2<T>([elements[0], elements[1],
                        elements[2], elements[3]])
    }

    public var determinant: T {
        elements[0] * elements[3] - elements[1] * elements[2]
    }

    public init() {
        elements = [1, 0,
                    0, 1]
    }

    public init(_ diagonal: T) {
        elements = [diagonal, 0,
                    0, diagonal]
    }

    public init(_ elements: [T]) {
        precondition(elements.count == 4, "Wrong amount of elements")
        self.elements = elements
    }

    public init(_ m11: T, _ m12: T,
                _ m21: T, _ m22: T) {
        self.elements = [m11, m12,
                         m21, m22]
    }
    
    public subscript(m: Int, n: Int) -> T {
        get {
            precondition(n >= 0 && n < 2 && m >= 0 && m < 2, "Out of bounds")
            return elements[n + m * 2]
        }
        set {
            precondition(n >= 0 && n < 2 && m >= 0 && m < 2, "Out of bounds")
            elements[n + m * 2] = newValue
        }
    }

    public static func +(lhs: Matrix2<T>, rhs: Matrix2<T>) -> Matrix2<T> {
        var result = Matrix2<T>(0)
        for i in 0 ..< 2 * 2 {
            result.elements[i] = lhs.elements[i] + rhs.elements[i]
        }
        return result
    }

    public static func +=(lhs: inout Matrix2<T>, rhs: Matrix2<T>) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Matrix2<T>, rhs: Matrix2<T>) -> Matrix2<T> {
        var result = Matrix2<T>(0)
        for i in 0 ..< 2 * 2 {
            result.elements[i] = lhs.elements[i] - rhs.elements[i]
        }
        return result
    }

    public static func -=(lhs: inout Matrix2<T>, rhs: Matrix2<T>) {
        lhs = lhs - rhs
    }

    public static prefix func -(matrix: Matrix2<T>) -> Matrix2<T> {
        -1 * matrix
    }

    public static func *(lhs: T, rhs: Matrix2<T>) -> Matrix2<T> {
        return Matrix2<T>(rhs.elements.map { $0 * lhs })
    }

    public static func *(lhs: Matrix2<T>, rhs: T) -> Matrix2<T> {
        return Matrix2<T>(lhs.elements.map { $0 * rhs })
    }

    public static func *=(lhs: inout Matrix2<T>, rhs: T) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix2<T>, rhs: Matrix2<T>) -> Matrix2<T> {
        var result = Matrix2<T>(0)
        for i in 0..<2 {
            for j in 0..<2 {
                for k in 0..<2 {
                    result.elements[i * 2 + j] += lhs.elements[i * 2 + k] * rhs.elements[k * 2 + j]
                }
            }
        }
        return result
    }

    public static func *=(lhs: inout Matrix2<T>, rhs: Matrix2<T>) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix2<T>, rhs: Vector2<T>) -> Vector2<T> {
        return Vector2<T>(lhs.elements[0] * rhs.x + lhs.elements[1] * rhs.y,
                                lhs.elements[4] * rhs.x + lhs.elements[5] * rhs.y)
    }

    public static func *(lhs: Vector2<T>, rhs: Matrix2<T>) -> Vector2<T> {
        return Vector2<T>(lhs.x * rhs.elements[0] + lhs.y * rhs.elements[2],
                                lhs.x * rhs.elements[1] + lhs.y * rhs.elements[3])
    }
}

public extension Matrix2 where T: BinaryFloatingPoint {
    var inverse: Matrix2<T> {
        let invDet = 1 / determinant
        return Matrix2<T>(elements[3] * invDet, -elements[1] * invDet,
                          -elements[2] * invDet, elements[0] * invDet)
    }

    static func /(lhs: Matrix2<T>, rhs: T) -> Matrix2<T> {
        Matrix2<T>(lhs.elements.map{$0 / rhs})
    }

    static func /=(lhs: inout Matrix2<T>, rhs: T) {
        lhs = lhs / rhs
    }
}

public extension Matrix2 where T: BinaryInteger {
    var inverse: Matrix2<T> {
        let invDet = 1 / Double(determinant)
        return Matrix2<T>(T(Double(elements[3]) * invDet), T(-Double(elements[1]) * invDet),
                          T(-Double(elements[2]) * invDet), T(Double(elements[0]) * invDet))
    }

    static func /<U: BinaryFloatingPoint>(lhs: Matrix2<T>, rhs: U) -> Matrix2<T> {
        Matrix2<T>(lhs.elements.map{ T(U($0) / rhs)})
    }

    static func /=<U: BinaryFloatingPoint>(lhs: inout Matrix2<T>, rhs: U) {
        lhs = lhs / rhs
    }
}