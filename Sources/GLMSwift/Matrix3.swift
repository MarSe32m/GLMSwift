// Sorry for my mathematical background!
// | m11 m12 m13 |
// | m21 m22 m23 |
// | m31 m32 m33 |

public typealias mat3i = Matrix3<Int>
public typealias mat3u = Matrix3<UInt>
public typealias mat3d = Matrix3<Double>
public typealias mat3f = Matrix3<Float>
public typealias mat3  = mat3f

/// Object that represents a 3 by 3 matrix
/// The matrix is ROW-major, so passing this to the shader is done with the transpose parameter set to GL_TRUE
public struct Matrix3<T>: CustomStringConvertible, Equatable where T: Numeric, T: SIMDScalar {
    public private(set) var elements: [T] = Array<T>(repeating: 0, count: 9)

    public var description: String {
        return """
         __________________________
        (\(elements[0])    \(elements[1])     \(elements[2]))
        (\(elements[3])    \(elements[4])     \(elements[5]))
        (\(elements[6])    \(elements[7])     \(elements[8]))
         ~~~~~~~~~~~~~~~~~~~~~~~~~~
        """
    }

    public var transpose: Matrix3<T> {
        return Matrix3<T>([elements[0], elements[3], elements[6],
                        elements[1], elements[4], elements[7],
                        elements[2], elements[5], elements[8]])
    }

    public var determinant: T {
        let d00: T = elements[0] * (elements[4] * elements[8] - elements[5] * elements[7])
        let d01: T = elements[1] * (elements[5] * elements[6] - elements[3] * elements[8])
        let d02: T = elements[2] * (elements[3] * elements[7] - elements[4] * elements[6])
        return d00 + d01 + d02
    }

    public init() {
        elements = [1, 0, 0,
                    0, 1, 0,
                    0, 0, 1]
    }

    public init(_ diagonal: T) {
        elements = [diagonal, 0, 0,
                    0, diagonal, 0,
                    0, 0, diagonal]
    }

    public init(_ elements: [T]) {
        precondition(elements.count == 9, "Wrong amount of elements")
        self.elements = elements
    }

    public init(_ m11: T, _ m12: T, _ m13: T,
                _ m21: T, _ m22: T, _ m23: T,
                _ m31: T, _ m32: T, _ m33: T) {
        self.elements = [m11, m12, m13,
                         m21, m22, m23,
                         m31, m32, m33]
    }
    
    public subscript(m: Int, n: Int) -> T {
        get {
            precondition(n >= 0 && n < 3 && m >= 0 && m < 3, "Out of bounds")
            return elements[n + m * 3]
        }
        set {
            precondition(n >= 0 && n < 3 && m >= 0 && m < 3, "Out of bounds")
            elements[n + m * 3] = newValue
        }
    }

    public static func +(lhs: Matrix3<T>, rhs: Matrix3<T>) -> Matrix3<T> {
        var result = Matrix3<T>(0)
        for i in 0 ..< 3 * 3 {
            result.elements[i] = lhs.elements[i] + rhs.elements[i]
        }
        return result
    }

    public static func +=(lhs: inout Matrix3<T>, rhs: Matrix3<T>) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Matrix3<T>, rhs: Matrix3<T>) -> Matrix3<T> {
        var result = Matrix3<T>(0)
        for i in 0 ..< 3 * 3 {
            result.elements[i] = lhs.elements[i] - rhs.elements[i]
        }
        return result
    }

    public static func -=(lhs: inout Matrix3<T>, rhs: Matrix3<T>) {
        lhs = lhs - rhs
    }

    public static prefix func -(matrix: Matrix3<T>) -> Matrix3<T> {
        -1 * matrix
    }

    public static func *(lhs: T, rhs: Matrix3<T>) -> Matrix3<T> {
        return Matrix3<T>(rhs.elements.map { $0 * lhs })
    }

    public static func *(lhs: Matrix3<T>, rhs: T) -> Matrix3<T> {
        return Matrix3<T>(lhs.elements.map { $0 * rhs })
    }

    public static func *=(lhs: inout Matrix3<T>, rhs: T) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix3<T>, rhs: Matrix3<T>) -> Matrix3<T> {
        var result = Matrix3<T>(0)
        for i in 0..<3 {
            for j in 0..<3 {
                for k in 0..<3 {
                    result.elements[i * 3 + j] += lhs.elements[i * 3 + k] * rhs.elements[k * 3 + j]
                }
            }
        }
        return result
    }

    public static func *=(lhs: inout Matrix3<T>, rhs: Matrix3<T>) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix3<T>, rhs: Vector3<T>) -> Vector3<T> {
        var result = Vector3<T>()
        result.x  = lhs.elements[0] * rhs.x 
        result.x += lhs.elements[1] * rhs.y 
        result.x += lhs.elements[2] * rhs.z 

        result.y  = lhs.elements[4] * rhs.x 
        result.y += lhs.elements[5] * rhs.y 
        result.y += lhs.elements[6] * rhs.z

        result.z = lhs.elements[8] * rhs.x 
        result.z += lhs.elements[9] * rhs.y 
        result.z += lhs.elements[10] * rhs.z
        return result
    }

    public static func *(lhs: Vector3<T>, rhs: Matrix3<T>) -> Vector3<T> {
        var result = Vector3<T>()
        result.x = lhs.x * rhs.elements[0] 
        result.x += lhs.y * rhs.elements[3]
        result.x += lhs.z * rhs.elements[6]

        result.y = lhs.x * rhs.elements[1]
        result.y += lhs.y * rhs.elements[4]
        result.y += lhs.z * rhs.elements[7]

        result.z = lhs.x * rhs.elements[2]
        result.z += lhs.y * rhs.elements[5]
        result.z += lhs.z * rhs.elements[8]
        return result
    }
}

public extension Matrix3 where T: BinaryFloatingPoint {
    var inverse: Matrix3<T> {
        var inverse = Matrix3<T>()
        inverse.elements[0] = elements[4] * elements[8] - elements[5] * elements[7]
        inverse.elements[1] = elements[2] * elements[7] - elements[1] * elements[8]
        inverse.elements[2] = elements[1] * elements[5] - elements[2] * elements[4]
        
        inverse.elements[3] = elements[5] * elements[6] - elements[3] * elements[8]
        inverse.elements[4] = elements[0] * elements[8] - elements[2] * elements[6]
        inverse.elements[5] = elements[2] * elements[3] - elements[0] * elements[5]
        
        inverse.elements[6] = elements[3] * elements[7] - elements[4] * elements[6]
        inverse.elements[7] = elements[1] * elements[6] - elements[0] * elements[7]
        inverse.elements[8] = elements[0] * elements[4] - elements[1] * elements[3]
        return inverse / determinant
    }

    static func /(lhs: Matrix3<T>, rhs: T) -> Matrix3<T> {
        let inverseRhs = 1 / rhs
        return Matrix3<T>(lhs.elements.map{$0 * inverseRhs})
    }

    static func /=(lhs: inout Matrix3<T>, rhs: T) {
        lhs = lhs / rhs
    }
}

public extension Matrix3 where T: BinaryInteger {
    var inverse: Matrix3<T> {
        var inverse = Matrix3<T>()
        inverse.elements[0] = elements[4] * elements[8] - elements[5] * elements[7]
        inverse.elements[1] = elements[2] * elements[7] - elements[1] * elements[8]
        inverse.elements[2] = elements[1] * elements[5] - elements[2] * elements[4]
        
        inverse.elements[3] = elements[5] * elements[6] - elements[3] * elements[8]
        inverse.elements[4] = elements[0] * elements[8] - elements[2] * elements[6]
        inverse.elements[5] = elements[2] * elements[3] - elements[0] * elements[5]

        inverse.elements[6] = elements[3] * elements[7] - elements[4] * elements[6]
        inverse.elements[7] = elements[1] * elements[6] - elements[0] * elements[7]
        inverse.elements[8] = elements[0] * elements[4] - elements[1] * elements[3]
        return inverse / Double(determinant)
    }

    static func /<U: BinaryFloatingPoint>(lhs: Matrix3<T>, rhs: U) -> Matrix3<T> {
        let inverseRhs = 1 / rhs
        return Matrix3<T>(lhs.elements.map{ T(U($0) * inverseRhs)})
    }

    static func /=<U: BinaryFloatingPoint>(lhs: inout Matrix3<T>, rhs: U) {
        lhs = lhs / rhs
    }
}