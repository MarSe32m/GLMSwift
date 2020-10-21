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
    public var m11: T
    public var m12: T
    public var m13: T
    public var m21: T
    public var m22: T
    public var m23: T
    public var m31: T
    public var m32: T
    public var m33: T

    public var description: String {
        return """
         __________________________
        (\(m11)    \(m12)     \(m13))
        (\(m21)    \(m22)     \(m23))
        (\(m31)    \(m32)     \(m33))
         ~~~~~~~~~~~~~~~~~~~~~~~~~~
        """
    }

    public var transpose: Matrix3<T> {
        return Matrix3<T>(m11, m12, m13,
                          m21, m22, m23,
                          m31, m32, m33)
    }

    public var determinant: T {
        let d00: T = m11 * (m22 * m33 - m23 * m32)
        let d01: T = m12 * (m23 * m31 - m21 * m33)
        let d02: T = m13 * (m21 * m32 - m22 * m31)
        return d00 + d01 + d02
    }

    public init() {
        self.m11 = 1
        self.m12 = 0
        self.m13 = 0
        self.m21 = 0
        self.m22 = 1
        self.m23 = 0
        self.m31 = 0
        self.m32 = 0
        self.m33 = 1
    }

    public init(_ diagonal: T) {
        self.m11 = diagonal
        self.m12 = 0
        self.m13 = 0
        self.m21 = 0
        self.m22 = diagonal
        self.m23 = 0
        self.m31 = 0
        self.m32 = 0
        self.m33 = diagonal
    }

    public init(_ array: [T]) {
        precondition(array.count == 9, "Wrong amount of elements")
        self.m11 = array[0]
        self.m12 = array[1]
        self.m13 = array[2]
        self.m21 = array[3]
        self.m22 = array[4]
        self.m23 = array[5]
        self.m31 = array[6]
        self.m32 = array[7]
        self.m33 = array[8]
    }

    public init(_ m11: T, _ m12: T, _ m13: T,
                _ m21: T, _ m22: T, _ m23: T,
                _ m31: T, _ m32: T, _ m33: T) {
        self.m11 = m11
        self.m12 = m11
        self.m13 = m11
        self.m21 = m11
        self.m22 = m11
        self.m23 = m11
        self.m31 = m11
        self.m32 = m11
        self.m33 = m11
    }
    
    public subscript(m: Int, n: Int) -> T {
        get {
            switch (m, n) {
                case (1, 1): return m11
                case (1, 2): return m12
                case (1, 3): return m13
                case (2, 1): return m21
                case (2, 2): return m22
                case (2, 3): return m23
                case (3, 1): return m31
                case (3, 2): return m32
                case (3, 3): return m33
                case (_, _): preconditionFailure("Index out of bounds, m: \(m), n: \(n)")
            }
        }
        set {
            switch (m, n) {
                case (1, 1): m11 = newValue
                case (1, 2): m12 = newValue
                case (1, 3): m13 = newValue
                case (2, 1): m21 = newValue
                case (2, 2): m22 = newValue
                case (2, 3): m23 = newValue
                case (3, 1): m31 = newValue
                case (3, 2): m32 = newValue
                case (3, 3): m33 = newValue
                case (_, _): preconditionFailure("Index out of bounds, m: \(m), n: \(n)")
            }
        }
    }

    public static func +(lhs: Matrix3<T>, rhs: Matrix3<T>) -> Matrix3<T> {
        var result = Matrix3<T>(0)
        result.m11 = lhs.m11 + rhs.m11 
        result.m12 = lhs.m12 + rhs.m12
        result.m13 = lhs.m13 + rhs.m13
        result.m21 = lhs.m21 + rhs.m21
        result.m22 = lhs.m22 + rhs.m22
        result.m23 = lhs.m23 + rhs.m23
        result.m31 = lhs.m31 + rhs.m31
        result.m32 = lhs.m32 + rhs.m32
        result.m33 = lhs.m33 + rhs.m33
        return result
    }

    public static func +=(lhs: inout Matrix3<T>, rhs: Matrix3<T>) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Matrix3<T>, rhs: Matrix3<T>) -> Matrix3<T> {
        var result = Matrix3<T>(0)
        result.m11 = lhs.m11 - rhs.m11 
        result.m12 = lhs.m12 - rhs.m12
        result.m13 = lhs.m13 - rhs.m13
        result.m21 = lhs.m21 - rhs.m21
        result.m22 = lhs.m22 - rhs.m22
        result.m23 = lhs.m23 - rhs.m23
        result.m31 = lhs.m31 - rhs.m31
        result.m32 = lhs.m32 - rhs.m32
        result.m33 = lhs.m33 - rhs.m33
        return result
    }

    public static func -=(lhs: inout Matrix3<T>, rhs: Matrix3<T>) {
        lhs = lhs - rhs
    }

    public static prefix func -(matrix: Matrix3<T>) -> Matrix3<T> {
        -1 * matrix
    }

    public static func *(lhs: T, rhs: Matrix3<T>) -> Matrix3<T> {
        var result = Matrix3<T>(0)
        result.m11 = lhs * rhs.m11 
        result.m12 = lhs * rhs.m12
        result.m13 = lhs * rhs.m13
        result.m21 = lhs * rhs.m21
        result.m22 = lhs * rhs.m22
        result.m23 = lhs * rhs.m23
        result.m31 = lhs * rhs.m31
        result.m32 = lhs * rhs.m32
        result.m33 = lhs * rhs.m33
        return result
    }

    public static func *(lhs: Matrix3<T>, rhs: T) -> Matrix3<T> {
        var result = Matrix3<T>(0)
        result.m11 = lhs.m11 * rhs 
        result.m12 = lhs.m12 * rhs
        result.m13 = lhs.m13 * rhs
        result.m21 = lhs.m21 * rhs
        result.m22 = lhs.m22 * rhs
        result.m23 = lhs.m23 * rhs
        result.m31 = lhs.m31 * rhs
        result.m32 = lhs.m32 * rhs
        result.m33 = lhs.m33 * rhs
        return result
    }

    @inline(__always)
    public static func *=(lhs: inout Matrix3<T>, rhs: T) {
        lhs = lhs * rhs
    }

    @inline(__always)
    public static func *(lhs: Matrix3<T>, rhs: Matrix3<T>) -> Matrix3<T> {
        var result = Matrix3<T>(0)
        result.m11  = lhs.m11 * rhs.m11 
        result.m11 += lhs.m12 * rhs.m21 
        result.m11 += lhs.m13 * rhs.m31

        result.m12  = lhs.m11 * rhs.m12 
        result.m12 += lhs.m12 * rhs.m22 
        result.m12 += lhs.m13 * rhs.m32
        
        result.m13  = lhs.m11 * rhs.m13 
        result.m13 += lhs.m12 * rhs.m23 
        result.m13 += lhs.m13 * rhs.m33
        
        result.m21  = lhs.m21 * rhs.m11 
        result.m21 += lhs.m22 * rhs.m21  
        result.m21 += lhs.m23 * rhs.m31

        result.m22  = lhs.m21 * rhs.m12 
        result.m22 += lhs.m22 * rhs.m22 
        result.m22 += lhs.m23 * rhs.m32

        result.m23  = lhs.m21 * rhs.m13 
        result.m23 += lhs.m22 * rhs.m23 
        result.m23 += lhs.m23 * rhs.m33

        result.m31  = lhs.m31 * rhs.m11 
        result.m31 += lhs.m32 * rhs.m21  
        result.m31 += lhs.m33 * rhs.m31

        result.m32  = lhs.m31 * rhs.m12 
        result.m32 += lhs.m32 * rhs.m22 
        result.m32 += lhs.m33 * rhs.m32

        result.m33  = lhs.m31 * rhs.m13 
        result.m33 += lhs.m32 * rhs.m23 
        result.m33 += lhs.m33 * rhs.m33
        return result
    }

    public static func *=(lhs: inout Matrix3<T>, rhs: Matrix3<T>) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix3<T>, rhs: Vector3<T>) -> Vector3<T> {
        var result = Vector3<T>()
        result.x  = lhs.m11 * rhs.x 
        result.x += lhs.m12 * rhs.y 
        result.x += lhs.m13 * rhs.z 

        result.y  = lhs.m21 * rhs.x 
        result.y += lhs.m22 * rhs.y 
        result.y += lhs.m23 * rhs.z

        result.z = lhs.m31 * rhs.x 
        result.z += lhs.m32 * rhs.y 
        result.z += lhs.m33 * rhs.z
        return result
    }

    public static func *(lhs: Vector3<T>, rhs: Matrix3<T>) -> Vector3<T> {
        var result = Vector3<T>()
        result.x = lhs.x * rhs.m11 
        result.x += lhs.y * rhs.m21
        result.x += lhs.z * rhs.m31

        result.y = lhs.x * rhs.m12
        result.y += lhs.y * rhs.m22
        result.y += lhs.z * rhs.m32

        result.z = lhs.x * rhs.m13
        result.z += lhs.y * rhs.m23
        result.z += lhs.z * rhs.m33
        return result
    }
}

public extension Matrix3 where T: BinaryFloatingPoint {
    var inverse: Matrix3<T> {
        let invDet = 1 / determinant
        var inverse = Matrix3<T>()
        inverse.m11 = (m22 * m33 - m23 * m32) * invDet
        inverse.m12 = (m13 * m32 - m12 * m33) * invDet
        inverse.m13 = (m12 * m23 - m13 * m22) * invDet
        
        inverse.m21 = (m23 * m31 - m21 * m33) * invDet
        inverse.m22 = (m11 * m33 - m13 * m31) * invDet
        inverse.m23 = (m13 * m21 - m11 * m23) * invDet
        
        inverse.m31 = (m21 * m32 - m22 * m31) * invDet
        inverse.m32 = (m12 * m31 - m11 * m32) * invDet
        inverse.m33 = (m11 * m22 - m12 * m21) * invDet
        return inverse
    }

    static func /(lhs: Matrix3<T>, rhs: T) -> Matrix3<T> {
        let invRhs = 1 / rhs
        return Matrix3<T>(lhs.m11 * invRhs, lhs.m12 * invRhs, lhs.m13 * invRhs,
                          lhs.m21 * invRhs, lhs.m22 * invRhs, lhs.m23 * invRhs,
                          lhs.m31 * invRhs, lhs.m32 * invRhs, lhs.m33 * invRhs)
    }

    static func /=(lhs: inout Matrix3<T>, rhs: T) {
        lhs = lhs / rhs
    }
}

public extension Matrix3 where T: BinaryInteger {
    var inverse: Matrix3<T> {
        let invDet = 1 / determinant
        var inverse = Matrix3<T>()
        inverse.m11 = T(Double(m22 * m33 - m23 * m32) * Double(invDet))
        inverse.m12 = T(Double(m13 * m32 - m12 * m33) * Double(invDet))
        inverse.m13 = T(Double(m12 * m23 - m13 * m22) * Double(invDet))
        inverse.m21 = T(Double(m23 * m31 - m21 * m33) * Double(invDet))
        inverse.m22 = T(Double(m11 * m33 - m13 * m31) * Double(invDet))
        inverse.m23 = T(Double(m13 * m21 - m11 * m23) * Double(invDet))
        inverse.m31 = T(Double(m21 * m32 - m22 * m31) * Double(invDet))
        inverse.m32 = T(Double(m12 * m31 - m11 * m32) * Double(invDet))
        inverse.m33 = T(Double(m11 * m22 - m12 * m21) * Double(invDet))
        return inverse
    }

    static func /<U: BinaryFloatingPoint>(lhs: Matrix3<T>, rhs: U) -> Matrix3<T> {
        let invRhs = 1 / rhs
        return Matrix3<T>(T(U(lhs.m11) * invRhs), T(U(lhs.m12) * invRhs), T(U(lhs.m13) * invRhs),
                   T(U(lhs.m21) * invRhs), T(U(lhs.m22) * invRhs), T(U(lhs.m23) * invRhs),
                   T(U(lhs.m31) * invRhs), T(U(lhs.m32) * invRhs), T(U(lhs.m33) * invRhs))
    }

    static func /=<U: BinaryFloatingPoint>(lhs: inout Matrix3<T>, rhs: U) {
        lhs = lhs / rhs
    }
}