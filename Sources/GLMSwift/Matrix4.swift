// Sorry for my mathematical background!
// | m11 m12 m13 m14 |
// | m21 m22 m23 m24 |
// | m31 m32 m33 m34 |
// | m41 m42 m43 m44 |

public typealias mat4i = Matrix4<Int>
public typealias mat4u = Matrix4<UInt>
public typealias mat4d = Matrix4<Double>
public typealias mat4f = Matrix4<Float>
public typealias mat4  = mat4f


/// Object that represents a 4 by 4 matrix
/// The matrix is COLUMN-major, so passing this to the shader is done with the transpose parameter set to GL_FALSE
public struct Matrix4<T>: CustomStringConvertible, Equatable where T: Numeric, T: SIMDScalar {
    public var m11: T
    public var m21: T
    public var m31: T
    public var m41: T

    public var m12: T
    public var m22: T
    public var m32: T
    public var m42: T
    
    public var m13: T
    public var m23: T
    public var m33: T
    public var m43: T
    
    public var m14: T
    public var m24: T
    public var m34: T
    public var m44: T

    public var description: String {
        return """
         __________________________
        (\(m11)    \(m12)     \(m13)     \(m14))
        (\(m21)    \(m22)     \(m23)     \(m24))
        (\(m31)    \(m32)     \(m33)     \(m34))
        (\(m41)    \(m42)     \(m43)     \(m44))
         ~~~~~~~~~~~~~~~~~~~~~~~~~~
        """
    }

    public var transpose: Matrix4<T> {
        return Matrix4([m11, m21, m31, m41,
                        m12, m22, m32, m42,
                        m13, m23, m33, m43,
                        m14, m24, m34, m44])
    }

    public var determinant: T {
        let d00: T = m11 * m22 - m21 * m12
        let d01: T = m11 * m23 - m21 * m13
        let d02: T = m11 * m24 - m21 * m14
        let d03: T = m12 * m23 - m22 * m13
        
        let d04: T = m12 * m24 - m22 * m14
        let d05: T = m13 * m24 - m23 * m14
        let d10: T = m31 * m42 - m41 * m32
        let d11: T = m31 * m43 - m41 * m33
        
        let d12: T = m31 * m44 - m41 * m34
        let d13: T = m32 * m43 - m42 * m33
        let d14: T = m32 * m44 - m42 * m34
        let d15: T = m33 * m44 - m43 * m34
        
        var _determinant: T = d00 * d15
        _determinant = _determinant - d01 * d14
        _determinant = _determinant + d02 * d13
        _determinant = _determinant + d03 * d12
        _determinant = _determinant - d04 * d11
        _determinant = _determinant + d05 * d10
        
        return _determinant
    }

    public init() {
        m11 = 1; m12 = 0; m13 = 0; m14 = 0
        m21 = 0; m22 = 1; m23 = 0; m24 = 0
        m31 = 0; m32 = 0; m33 = 1; m34 = 0
        m41 = 0; m42 = 0; m43 = 0; m44 = 1
    }

    public init(_ diagonal: T) {
        m11 = diagonal; m12 = 0; m13 = 0; m14 = 0
        m21 = 0; m22 = diagonal; m23 = 0; m24 = 0
        m31 = 0; m32 = 0; m33 = diagonal; m34 = 0
        m41 = 0; m42 = 0; m43 = 0; m44 = diagonal
    }

    public init(_ array: [T]) {
        precondition(array.count == 16, "Wrong amount of elements")
        m11 = array[0]; m12 = array[1]; m13 = array[2]; m14 = array[3]
        m21 = array[4]; m22 = array[5]; m23 = array[6]; m24 = array[7]
        m31 = array[8]; m32 = array[9]; m33 = array[10]; m34 = array[11]
        m41 = array[12]; m42 = array[13]; m43 = array[14]; m44 = array[15]
    }

    public init(_ m11: T, _ m12: T, _ m13: T, _ m14: T,
                _ m21: T, _ m22: T, _ m23: T, _ m24: T,
                _ m31: T, _ m32: T, _ m33: T, _ m34: T,
                _ m41: T, _ m42: T, _ m43: T, _ m44: T) {
        self.m11 = m11; self.m12 = m12; self.m13 = m13; self.m14 = m14
        self.m21 = m21; self.m22 = m22; self.m23 = m23; self.m24 = m24
        self.m31 = m31; self.m32 = m32; self.m33 = m33; self.m34 = m34
        self.m41 = m41; self.m42 = m42; self.m43 = m43; self.m44 = m44
    }
    
    public subscript(m: Int, n: Int) -> T {
        get {
            switch (m, n) {
                case (1, 1): return m11
                case (1, 2): return m12
                case (1, 3): return m13
                case (1, 4): return m14
                case (2, 1): return m21
                case (2, 2): return m22
                case (2, 3): return m23
                case (2, 4): return m24
                case (3, 1): return m31
                case (3, 2): return m32
                case (3, 3): return m33
                case (3, 4): return m34
                case (4, 1): return m41
                case (4, 2): return m42
                case (4, 3): return m43
                case (4, 4): return m44
                case (_, _): preconditionFailure("Index out of bounds, m: \(m), n: \(n)")
            }
        }
        set {
            switch (m, n) {
                case (1, 1): m11 = newValue
                case (1, 2): m12 = newValue
                case (1, 3): m13 = newValue
                case (1, 4): m14 = newValue
                case (2, 1): m21 = newValue
                case (2, 2): m22 = newValue
                case (2, 3): m23 = newValue
                case (2, 4): m24 = newValue
                case (3, 1): m31 = newValue
                case (3, 2): m32 = newValue
                case (3, 3): m33 = newValue
                case (3, 4): m34 = newValue
                case (4, 1): m41 = newValue
                case (4, 2): m42 = newValue
                case (4, 3): m43 = newValue
                case (4, 4): m44 = newValue
                case (_, _): preconditionFailure("Index out of bounds, m: \(m), n: \(n)")
            }
        }
    }

    public static func +(lhs: Matrix4<T>, rhs: Matrix4<T>) -> Matrix4<T> {
        var result = Matrix4<T>(0)
        result.m11 = lhs.m11 + rhs.m11
        result.m12 = lhs.m12 + rhs.m12
        result.m13 = lhs.m13 + rhs.m13
        result.m14 = lhs.m14 + rhs.m14
        result.m21 = lhs.m21 + rhs.m21
        result.m22 = lhs.m22 + rhs.m22
        result.m23 = lhs.m23 + rhs.m23
        result.m24 = lhs.m24 + rhs.m24
        result.m31 = lhs.m31 + rhs.m31
        result.m32 = lhs.m32 + rhs.m32
        result.m33 = lhs.m33 + rhs.m33
        result.m34 = lhs.m34 + rhs.m34
        result.m41 = lhs.m41 + rhs.m41
        result.m42 = lhs.m42 + rhs.m42
        result.m43 = lhs.m43 + rhs.m43
        result.m44 = lhs.m44 + rhs.m44
        return result
    }

    public static func +=(lhs: inout Matrix4<T>, rhs: Matrix4<T>) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Matrix4<T>, rhs: Matrix4<T>) -> Matrix4<T> {
        var result = Matrix4<T>(0)
        result.m11 = lhs.m11 - rhs.m11
        result.m12 = lhs.m12 - rhs.m12
        result.m13 = lhs.m13 - rhs.m13
        result.m14 = lhs.m14 - rhs.m14
        result.m21 = lhs.m21 - rhs.m21
        result.m22 = lhs.m22 - rhs.m22
        result.m23 = lhs.m23 - rhs.m23
        result.m24 = lhs.m24 - rhs.m24
        result.m31 = lhs.m31 - rhs.m31
        result.m32 = lhs.m32 - rhs.m32
        result.m33 = lhs.m33 - rhs.m33
        result.m34 = lhs.m34 - rhs.m34
        result.m41 = lhs.m41 - rhs.m41
        result.m42 = lhs.m42 - rhs.m42
        result.m43 = lhs.m43 - rhs.m43
        result.m44 = lhs.m44 - rhs.m44
        return result
    }

    public static func -=(lhs: inout Matrix4<T>, rhs: Matrix4<T>) {
        lhs = lhs - rhs
    }

    public static prefix func -(matrix: Matrix4<T>) -> Matrix4<T> {
        -1 * matrix
    }

    public static func *(lhs: T, rhs: Matrix4<T>) -> Matrix4<T> {
        var result = Matrix4<T>(0)
        result.m11 = lhs * rhs.m11
        result.m12 = lhs * rhs.m12
        result.m13 = lhs * rhs.m13
        result.m14 = lhs * rhs.m14
        result.m21 = lhs * rhs.m21
        result.m22 = lhs * rhs.m22
        result.m23 = lhs * rhs.m23
        result.m24 = lhs * rhs.m24
        result.m31 = lhs * rhs.m31
        result.m32 = lhs * rhs.m32
        result.m33 = lhs * rhs.m33
        result.m34 = lhs * rhs.m34
        result.m41 = lhs * rhs.m41
        result.m42 = lhs * rhs.m42
        result.m43 = lhs * rhs.m43
        result.m44 = lhs * rhs.m44
        return result
    }

    public static func *(lhs: Matrix4<T>, rhs: T) -> Matrix4<T> {
        var result = Matrix4<T>(0)
        result.m11 = lhs.m11 * rhs
        result.m12 = lhs.m12 * rhs
        result.m13 = lhs.m13 * rhs
        result.m14 = lhs.m14 * rhs
        result.m21 = lhs.m21 * rhs
        result.m22 = lhs.m22 * rhs
        result.m23 = lhs.m23 * rhs
        result.m24 = lhs.m24 * rhs
        result.m31 = lhs.m31 * rhs
        result.m32 = lhs.m32 * rhs
        result.m33 = lhs.m33 * rhs
        result.m34 = lhs.m34 * rhs
        result.m41 = lhs.m41 * rhs
        result.m42 = lhs.m42 * rhs
        result.m43 = lhs.m43 * rhs
        result.m44 = lhs.m44 * rhs
        return result
    }

    @inline(__always)
    public static func *=(lhs: inout Matrix4<T>, rhs: T) {
        lhs = lhs * rhs
    }

    @inline(__always)
    public static func *(lhs: Matrix4<T>, rhs: Matrix4<T>) -> Matrix4<T> {
        var result = Matrix4<T>(0)
        result.m11  = lhs.m11 * rhs.m11 
        result.m11 += lhs.m12 * rhs.m21 
        result.m11 += lhs.m13 * rhs.m31 
        result.m11 += lhs.m14 * rhs.m41

        result.m12  = lhs.m11 * rhs.m12 
        result.m12 += lhs.m12 * rhs.m22 
        result.m12 += lhs.m13 * rhs.m32 
        result.m12 += lhs.m14 * rhs.m42
        
        result.m13  = lhs.m11 * rhs.m13 
        result.m13 += lhs.m12 * rhs.m23 
        result.m13 += lhs.m13 * rhs.m33  
        result.m13 += lhs.m14 * rhs.m43 

        result.m14  = lhs.m11 * rhs.m14  
        result.m14 += lhs.m12 * rhs.m24  
        result.m14 += lhs.m13 * rhs.m34  
        result.m14 += lhs.m14 * rhs.m44 
        
        result.m21  = lhs.m21 * rhs.m11 
        result.m21 += lhs.m22 * rhs.m21  
        result.m21 += lhs.m23 * rhs.m31  
        result.m21 += lhs.m24 * rhs.m41

        result.m22  = lhs.m21 * rhs.m12 
        result.m22 += lhs.m22 * rhs.m22 
        result.m22 += lhs.m23 * rhs.m32 
        result.m22 += lhs.m24 * rhs.m42

        result.m23  = lhs.m21 * rhs.m13 
        result.m23 += lhs.m22 * rhs.m23 
        result.m23 += lhs.m23 * rhs.m33 
        result.m23 += lhs.m24 * rhs.m43

        result.m24  = lhs.m21 * rhs.m14 
        result.m24 += lhs.m22 * rhs.m24 
        result.m24 += lhs.m23 * rhs.m34 
        result.m24 += lhs.m24 * rhs.m44

        result.m31  = lhs.m31 * rhs.m11 
        result.m31 += lhs.m32 * rhs.m21  
        result.m31 += lhs.m33 * rhs.m31  
        result.m31 += lhs.m34 * rhs.m41

        result.m32  = lhs.m31 * rhs.m12 
        result.m32 += lhs.m32 * rhs.m22 
        result.m32 += lhs.m33 * rhs.m32 
        result.m32 += lhs.m34 * rhs.m42

        result.m33  = lhs.m31 * rhs.m13 
        result.m33 += lhs.m32 * rhs.m23 
        result.m33 += lhs.m33 * rhs.m33 
        result.m33 += lhs.m34 * rhs.m43

        result.m34  = lhs.m31 * rhs.m14 
        result.m34 += lhs.m32 * rhs.m24 
        result.m34 += lhs.m33 * rhs.m34 
        result.m34 += lhs.m34 * rhs.m44

        result.m41  = lhs.m41 * rhs.m11 
        result.m41 += lhs.m42 * rhs.m21 
        result.m41 += lhs.m43 * rhs.m31 
        result.m41 += lhs.m44 * rhs.m41
        
        result.m42  = lhs.m41 * rhs.m12 
        result.m42 += lhs.m42 * rhs.m22 
        result.m42 += lhs.m43 * rhs.m32 
        result.m42 += lhs.m44 * rhs.m42
        
        result.m43  = lhs.m41 * rhs.m13 
        result.m43 += lhs.m42 * rhs.m23 
        result.m43 += lhs.m43 * rhs.m33 
        result.m43 += lhs.m44 * rhs.m43
        
        result.m44  = lhs.m41 * rhs.m14 
        result.m44 += lhs.m42 * rhs.m24 
        result.m44 += lhs.m43 * rhs.m34 
        result.m44 += lhs.m44 * rhs.m44
        return result
    }

    public static func *=(lhs: inout Matrix4<T>, rhs: Matrix4<T>) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix4<T>, rhs: Vector4<T>) -> Vector4<T> {
        var result = Vector4<T>()
        result.x  = lhs.m11 * rhs.x 
        result.x += lhs.m12 * rhs.y 
        result.x += lhs.m13 * rhs.z 
        result.x += lhs.m14 * rhs.w

        result.y  = lhs.m21 * rhs.x 
        result.y += lhs.m22 * rhs.y 
        result.y += lhs.m23 * rhs.z 
        result.y += lhs.m24 * rhs.w

        result.z = lhs.m31 * rhs.x 
        result.z += lhs.m32 * rhs.y 
        result.z += lhs.m33 * rhs.z 
        result.z += lhs.m34 * rhs.w

        result.w = lhs.m41 * rhs.x 
        result.w += lhs.m42 * rhs.y 
        result.w += lhs.m43 * rhs.z  
        result.w += lhs.m44 * rhs.w
        return result
    }

    public static func *(lhs: Vector4<T>, rhs: Matrix4<T>) -> Vector4<T> {
        var result = Vector4<T>()
        result.x = lhs.x * rhs.m11 
        result.x += lhs.y * rhs.m21
        result.x += lhs.z * rhs.m31
        result.x += lhs.w * rhs.m41

        result.y = lhs.x * rhs.m12
        result.y += lhs.y * rhs.m22
        result.y += lhs.z * rhs.m32
        result.y += lhs.w * rhs.m42

        result.z = lhs.x * rhs.m13
        result.z += lhs.y * rhs.m23
        result.z += lhs.z * rhs.m33
        result.z += lhs.w * rhs.m43

        result.w = lhs.x * rhs.m14
        result.w += lhs.y * rhs.m24
        result.w += lhs.z * rhs.m34
        result.w += lhs.w * rhs.m44
        return result
    }
}

public extension Matrix4 where T: BinaryFloatingPoint {
    var inverse: Matrix4<T> {
        let d00: T = m11 * m22 - m21 * m12
        let d01: T = m11 * m23 - m21 * m13
        let d02: T = m11 * m24 - m21 * m14
        let d03: T = m12 * m23 - m22 * m13
        let d04: T = m12 * m24 - m22 * m14
        let d05: T = m13 * m24 - m23 * m14

        let d10: T = m31 * m42 - m41 * m32
        let d11: T = m31 * m43 - m41 * m33
        let d12: T = m31 * m44 - m41 * m34
        let d13: T = m32 * m43 - m42 * m33
        let d14: T = m32 * m44 - m42 * m34
        let d15: T = m33 * m44 - m43 * m34

        var _determinant = d00 * d15
        _determinant = _determinant - d01 * d14
        _determinant = _determinant + d02 * d13
        _determinant = _determinant + d03 * d12
        _determinant = _determinant - d04 * d11
        _determinant = _determinant + d05 * d10

        var _m11 = m22 * d15
        _m11 = _m11 - m23 * d14
        _m11 = _m11 + m24 * d13
        
        var _m12 = 0 - m12 * d15
        _m12 = _m12 + m13 * d14
        _m12 = _m12 - m14 * d13
        
        var _m13 = m42 * d05
        _m13 = _m13 - m43 * d04
        _m13 = _m13 + m44 * d03
        
        var _m14 = 0 - m32 * d05
        _m14 = _m14 + m33 * d04
        _m14 = _m14 - m34 * d03

        var _m21 = 0 - m21 * d15
        _m21 = _m21 + m23 * d12
        _m21 = _m21 - m24 * d11
        
        var _m22 = m11 * d15
        _m22 = _m22 - m13 * d12
        _m22 = _m22 + m14 * d11
        
        var _m23 = 0 - m41 * d05
        _m23 = _m23 + m43 * d02
        _m23 = _m23 - m44 * d01

        var _m24 = m31 * d05
        _m24 = _m24 - m33 * d02
        _m24 = _m24 + m34 * d01
        
        var _m31 = m21 * d14
        _m31 = _m31 - m22 * d12
        _m31 = _m31 + m24 * d10
        
        var _m32 = 0 - m11 * d14
        _m32 = _m32 + m12 * d12
        _m32 = _m32 - m14 * d10
        
        var _m33 = m41 * d04
        _m33 = _m33 - m42 * d02
        _m33 = _m33 + m44 * d00
        
        var _m34 = 0 - m31 * d04
        _m34 = _m34 + m32 * d02
        _m34 = _m34 - m34 * d00

        var _m41 = 0 - m21 * d13
        _m41 = _m41 + m22 * d11
        _m41 = _m41 - m23 * d10
        
        var _m42 = m11 * d13
        _m42 = _m42 - m12 * d11
        _m42 = _m42 + m13 * d10
        
        var _m43 = 0 - m41 * d03
        _m43 = _m43 + m42 * d01
        _m43 = _m43 - m43 * d00
        
        var _m44 = m31 * d03
        _m44 = _m44 - m32 * d01
        _m44 = _m44 + m33 * d00

        let invdet = 1 / Double(_determinant)
        
        _m11 = T(Double(_m11) * Double(invdet))
        _m12 = T(Double(_m12) * Double(invdet))
        _m13 = T(Double(_m13) * Double(invdet))
        _m14 = T(Double(_m14) * Double(invdet))

        _m21 = T(Double(_m21) * Double(invdet))
        _m22 = T(Double(_m22) * Double(invdet))
        _m23 = T(Double(_m23) * Double(invdet))
        _m24 = T(Double(_m24) * Double(invdet))

        _m31 = T(Double(_m31) * Double(invdet))
        _m32 = T(Double(_m32) * Double(invdet))
        _m33 = T(Double(_m33) * Double(invdet))
        _m34 = T(Double(_m34) * Double(invdet))
        
        _m41 = T(Double(_m41) * Double(invdet))
        _m42 = T(Double(_m42) * Double(invdet))
        _m43 = T(Double(_m43) * Double(invdet))
        _m44 = T(Double(_m44) * Double(invdet))

        return Matrix4<T>(_m11, _m12, _m13, _m14,
                          _m21, _m22, _m23, _m24,
                          _m31, _m32, _m33, _m34,
                          _m41, _m42, _m43, _m44)
    }

    static func /(lhs: Matrix4<T>, rhs: T) -> Matrix4<T> {
        Matrix4<T>(lhs.m11 / rhs, lhs.m12 / rhs, lhs.m13 / rhs, lhs.m14 / rhs,
                   lhs.m21 / rhs, lhs.m22 / rhs, lhs.m23 / rhs, lhs.m24 / rhs,
                   lhs.m31 / rhs, lhs.m32 / rhs, lhs.m33 / rhs, lhs.m34 / rhs,
                   lhs.m41 / rhs, lhs.m42 / rhs, lhs.m43 / rhs, lhs.m44 / rhs)
    }

    static func /=(lhs: inout Matrix4<T>, rhs: T) {
        lhs = lhs / rhs
    }
}

public extension Matrix4 where T: BinaryInteger {
    var inverse: Matrix4<T> {
        let d00: T = m11 * m22 - m21 * m12
        let d01: T = m11 * m23 - m21 * m13
        let d02: T = m11 * m24 - m21 * m14
        let d03: T = m12 * m23 - m22 * m13
        let d04: T = m12 * m24 - m22 * m14
        let d05: T = m13 * m24 - m23 * m14

        let d10: T = m31 * m42 - m41 * m32
        let d11: T = m31 * m43 - m41 * m33
        let d12: T = m31 * m44 - m41 * m34
        let d13: T = m32 * m43 - m42 * m33
        let d14: T = m32 * m44 - m42 * m34
        let d15: T = m33 * m44 - m43 * m34

        var _determinant = d00 * d15
        _determinant = _determinant - d01 * d14
        _determinant = _determinant + d02 * d13
        _determinant = _determinant + d03 * d12
        _determinant = _determinant - d04 * d11
        _determinant = _determinant + d05 * d10

        var _m11 = m22 * d15
        _m11 = _m11 - m23 * d14
        _m11 = _m11 + m24 * d13
        var _m12 = 0 - m12 * d15
        _m12 = _m12 + m13 * d14
        _m12 = _m12 - m14 * d13
        var _m13 = m42 * d05
        _m13 = _m13 - m43 * d04
        _m13 = _m13 + m44 * d03
        var _m14 = 0 - m32 * d05
        _m14 = _m14 + m33 * d04
        _m14 = _m14 - m34 * d03

        var _m21 = 0 - m21 * d15
        _m21 = _m21 + m23 * d12
        _m21 = _m21 - m24 * d11
        var _m22 = m11 * d15
        _m22 = _m22 - m13 * d12
        _m22 = _m22 + m14 * d11
        var _m23 = 0 - m41 * d05
        _m23 = _m23 + m43 * d02
        _m23 = _m23 - m44 * d01
        var _m24 = m31 * d05
        _m24 = _m24 - m33 * d02
        _m24 = _m24 + m34 * d01

        var _m31 = m21 * d14
        _m31 = _m31 - m22 * d12
        _m31 = _m31 + m24 * d10
        var _m32 = 0 - m11 * d14
        _m32 = _m32 + m12 * d12
        _m32 = _m32 - m14 * d10
        var _m33 = m41 * d04
        _m33 = _m33 - m42 * d02
        _m33 = _m33 + m44 * d00
        var _m34 = 0 - m31 * d04
        _m34 = _m34 + m32 * d02
        _m34 = _m34 - m34 * d00

        var _m41 = 0 - m21 * d13
        _m41 = _m41 + m22 * d11
        _m41 = _m41 - m23 * d10
        var _m42 = m11 * d13
        _m42 = _m42 - m12 * d11
        _m42 = _m42 + m13 * d10
        var _m43 = 0 - m41 * d03
        _m43 = _m43 + m42 * d01
        _m43 = _m43 - m43 * d00
        var _m44 = m31 * d03
        _m44 = _m44 - m32 * d01
        _m44 = _m44 + m33 * d00

        let invdet = 1 / Double(_determinant)
        
        _m11 = T(Double(_m11) * Double(invdet))
        _m12 = T(Double(_m12) * Double(invdet))
        _m13 = T(Double(_m13) * Double(invdet))
        _m14 = T(Double(_m14) * Double(invdet))

        _m21 = T(Double(_m21) * Double(invdet))
        _m22 = T(Double(_m22) * Double(invdet))
        _m23 = T(Double(_m23) * Double(invdet))
        _m24 = T(Double(_m24) * Double(invdet))

        _m31 = T(Double(_m31) * Double(invdet))
        _m32 = T(Double(_m32) * Double(invdet))
        _m33 = T(Double(_m33) * Double(invdet))
        _m34 = T(Double(_m34) * Double(invdet))
        
        _m41 = T(Double(_m41) * Double(invdet))
        _m42 = T(Double(_m42) * Double(invdet))
        _m43 = T(Double(_m43) * Double(invdet))
        _m44 = T(Double(_m44) * Double(invdet))

        return Matrix4<T>(_m11, _m12, _m13, _m14,
                          _m21, _m22, _m23, _m24,
                          _m31, _m32, _m33, _m34,
                          _m41, _m42, _m43, _m44)
    }

    static func /<U: BinaryFloatingPoint>(lhs: Matrix4<T>, rhs: U) -> Matrix4<T> {
        Matrix4<T>(T(U(lhs.m11) / rhs), T(U(lhs.m12) / rhs), T(U(lhs.m13) / rhs), T(U(lhs.m14) / rhs),
                   T(U(lhs.m21) / rhs), T(U(lhs.m22) / rhs), T(U(lhs.m23) / rhs), T(U(lhs.m24) / rhs),
                   T(U(lhs.m31) / rhs), T(U(lhs.m32) / rhs), T(U(lhs.m33) / rhs), T(U(lhs.m34) / rhs),
                   T(U(lhs.m41) / rhs), T(U(lhs.m42) / rhs), T(U(lhs.m43) / rhs), T(U(lhs.m44) / rhs))
    }

    static func /=<U: BinaryFloatingPoint>(lhs: inout Matrix4<T>, rhs: U) {
        lhs = lhs / rhs
    }
}