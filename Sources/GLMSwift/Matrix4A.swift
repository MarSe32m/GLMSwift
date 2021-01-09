import GLMSwift



public typealias mat4ia = Matrix4A<Int>
public typealias mat4ua = Matrix4A<UInt>
public typealias mat4da = Matrix4A<Double>
public typealias mat4fa = Matrix4A<Float>
public typealias mat4a  = mat4fa
/// Array backed matrix, just for reference for now
/// Object that represents a 4 by 4 matrix
/// The matrix is ROW-major, so passing this to the shader is done with the transpose parameter set to GL_TRUE
internal struct Matrix4A<T>: CustomStringConvertible, Equatable where T: Numeric, T: SIMDScalar {
    public private(set) var elements: [T] = Array<T>(repeating: 0, count: 16)

    public var description: String {
        return """
         __________________________
        (\(elements[0])    \(elements[1])     \(elements[2])     \(elements[3]))
        (\(elements[4])    \(elements[5])     \(elements[6])     \(elements[7]))
        (\(elements[8])    \(elements[9])     \(elements[10])     \(elements[11]))
        (\(elements[12])    \(elements[13])     \(elements[14])     \(elements[15]))
         ~~~~~~~~~~~~~~~~~~~~~~~~~~
        """
    }

    public var transpose: Matrix4A<T> {
        return Matrix4A([elements[0], elements[4], elements[8], elements[12],
                        elements[1], elements[5], elements[9], elements[13],
                        elements[2], elements[6], elements[10], elements[14],
                        elements[3], elements[7], elements[11], elements[15]])
    }

    public var determinant: T {
        let d00: T = elements[0] * elements[5] - elements[4] * elements[1]
        let d01: T = elements[0] * elements[6] - elements[4] * elements[2]
        let d02: T = elements[0] * elements[7] - elements[4] * elements[3]
        let d03: T = elements[1] * elements[6] - elements[5] * elements[2]
        
        let d04: T = elements[1] * elements[7] - elements[5] * elements[3]
        let d05: T = elements[2] * elements[7] - elements[6] * elements[3]
        let d10: T = elements[8] * elements[13] - elements[12] * elements[9]
        let d11: T = elements[8] * elements[14] - elements[12] * elements[10]
        
        let d12: T = elements[8] * elements[15] - elements[12] * elements[11]
        let d13: T = elements[9] * elements[14] - elements[13] * elements[10]
        let d14: T = elements[9] * elements[15] - elements[13] * elements[11]
        let d15: T = elements[10] * elements[15] - elements[14] * elements[11]
        
        var _determinant: T = d00 * d15
        _determinant = _determinant - d01 * d14
        _determinant = _determinant + d02 * d13
        _determinant = _determinant + d03 * d12
        _determinant = _determinant - d04 * d11
        _determinant = _determinant + d05 * d10
        
        return _determinant
    }

    public init() {
        elements = [1, 0, 0, 1,
                    0, 1, 0, 1,
                    0, 0, 1, 0,
                    0, 0, 0, 1]
    }

    public init(_ diagonal: T) {
        elements = [diagonal, 0, 0, 0,
                    0, diagonal, 0, 0,
                    0, 0, diagonal, 0,
                    0, 0, 0, diagonal]
    }

    public init(_ elements: [T]) {
        precondition(elements.count == 16, "Wrong amount of elements")
        self.elements = elements
    }

    public init(_ m11: T, _ m12: T, _ m13: T, _ m14: T,
         _ m21: T, _ m22: T, _ m23: T, _ m24: T,
         _ m31: T, _ m32: T, _ m33: T, _ m34: T,
         _ m41: T, _ m42: T, _ m43: T, _ m44: T) {
        self.elements = [m11, m12, m13, m14,
                         m21, m22, m23, m24,
                         m31, m32, m33, m34,
                         m41, m42, m43, m44]
    }
    
    public subscript(m: Int, n: Int) -> T {
        get {
            precondition(n >= 0 && n < 4 && m >= 0 && m < 4, "Out of bounds")
            return elements[n + m * 4]
        }
        set {
            precondition(n >= 0 && n < 4 && m >= 0 && m < 4, "Out of bounds")
            elements[n + m * 4] = newValue
        }
    }

    public static func +(lhs: Matrix4A<T>, rhs: Matrix4A<T>) -> Matrix4A<T> {
        var result = Matrix4A<T>(0)
        for i in 0 ..< 4 * 4 {
            result.elements[i] = lhs.elements[i] + rhs.elements[i]
        }
        return result
    }

    public static func +=(lhs: inout Matrix4A<T>, rhs: Matrix4A<T>) {
        lhs = lhs + rhs
    }

    public static func -(lhs: Matrix4A<T>, rhs: Matrix4A<T>) -> Matrix4A<T> {
        var result = Matrix4A<T>(0)
        for i in 0 ..< 4 * 4 {
            result.elements[i] = lhs.elements[i] - rhs.elements[i]
        }
        return result
    }

    public static func -=(lhs: inout Matrix4A<T>, rhs: Matrix4A<T>) {
        lhs = lhs - rhs
    }

    public static prefix func -(matrix: Matrix4A<T>) -> Matrix4A<T> {
        -1 * matrix
    }

    public static func *(lhs: T, rhs: Matrix4A<T>) -> Matrix4A<T> {
        return Matrix4A<T>(rhs.elements.map { $0 * lhs })
    }

    public static func *(lhs: Matrix4A<T>, rhs: T) -> Matrix4A<T> {
        return Matrix4A<T>(lhs.elements.map { $0 * rhs })
    }

    public static func *=(lhs: inout Matrix4A<T>, rhs: T) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix4A<T>, rhs: Matrix4A<T>) -> Matrix4A<T> {
        var result = Matrix4A<T>(0)
        for i in 0..<4 {
            for j in 0..<4 {
                for k in 0..<4 {
                    result.elements[i * 4 + j] += lhs.elements[i * 4 + k] * rhs.elements[k * 4 + j]
                }
            }
        }
        return result
    }

    public static func *=(lhs: inout Matrix4A<T>, rhs: Matrix4A<T>) {
        lhs = lhs * rhs
    }

    public static func *(lhs: Matrix4A<T>, rhs: Vector4<T>) -> Vector4<T> {
        var result = Vector4<T>()
        result.x  = lhs.elements[0] * rhs.x 
        result.x += lhs.elements[1] * rhs.y 
        result.x += lhs.elements[2] * rhs.z 
        result.x += lhs.elements[3] * rhs.w

        result.y  = lhs.elements[4] * rhs.x 
        result.y += lhs.elements[5] * rhs.y 
        result.y += lhs.elements[6] * rhs.z 
        result.y += lhs.elements[7] * rhs.w

        result.z = lhs.elements[8] * rhs.x 
        result.z += lhs.elements[9] * rhs.y 
        result.z += lhs.elements[10] * rhs.z 
        result.z += lhs.elements[11] * rhs.w

        result.w = lhs.elements[12] * rhs.x 
        result.w += lhs.elements[13] * rhs.y 
        result.w += lhs.elements[14] * rhs.z  
        result.w += lhs.elements[15] * rhs.w
        return result
    }

    public static func *(lhs: Vector4<T>, rhs: Matrix4A<T>) -> Vector4<T> {
        var result = Vector4<T>()
        result.x = lhs.x * rhs.elements[0] 
        result.x += lhs.y * rhs.elements[4]
        result.x += lhs.z * rhs.elements[8]
        result.x += lhs.w * rhs.elements[12]

        result.y = lhs.x * rhs.elements[1]
        result.y += lhs.y * rhs.elements[5]
        result.y += lhs.z * rhs.elements[9]
        result.y += lhs.w * rhs.elements[13]

        result.z = lhs.x * rhs.elements[2]
        result.z += lhs.y * rhs.elements[6]
        result.z += lhs.z * rhs.elements[10]
        result.z += lhs.w * rhs.elements[14]

        result.w = lhs.x * rhs.elements[3]
        result.w += lhs.y * rhs.elements[7]
        result.w += lhs.z * rhs.elements[11]
        result.w += lhs.w * rhs.elements[15]
        return result
    }
}

public extension Matrix4A where T: BinaryFloatingPoint {
    var inverse: Matrix4A<T> {
        let d00: T = elements[0] * elements[5] - elements[4] * elements[1]
        let d01: T = elements[0] * elements[6] - elements[4] * elements[2]
        let d02: T = elements[0] * elements[7] - elements[4] * elements[3]
        let d03: T = elements[1] * elements[6] - elements[5] * elements[2]
        let d04: T = elements[1] * elements[7] - elements[5] * elements[3]
        let d05: T = elements[2] * elements[7] - elements[6] * elements[3]

        let d10: T = elements[8] * elements[13] - elements[12] * elements[9]
        let d11: T = elements[8] * elements[14] - elements[12] * elements[10]
        let d12: T = elements[8] * elements[15] - elements[12] * elements[11]
        let d13: T = elements[9] * elements[14] - elements[13] * elements[10]
        let d14: T = elements[9] * elements[15] - elements[13] * elements[11]
        let d15: T = elements[10] * elements[15] - elements[14] * elements[11]

        var _determinant = d00 * d15
        _determinant = _determinant - d01 * d14
        _determinant = _determinant + d02 * d13
        _determinant = _determinant + d03 * d12
        _determinant = _determinant - d04 * d11
        _determinant = _determinant + d05 * d10

        var _inverse: [T] = Array<T>(repeating: 0, count: 16)
        _inverse[0] = elements[5] * d15
        _inverse[0] = _inverse[0] - elements[6] * d14
        _inverse[0] = _inverse[0] + elements[7] * d13
        _inverse[1] = 0 - elements[1] * d15
        _inverse[1] = _inverse[1] + elements[2] * d14
        _inverse[1] = _inverse[1] - elements[3] * d13
        _inverse[2] = elements[13] * d05
        _inverse[2] = _inverse[2] - elements[14] * d04
        _inverse[2] = _inverse[2] + elements[15] * d03
        _inverse[3] = 0 - elements[9] * d05
        _inverse[3] = _inverse[3] + elements[10] * d04
        _inverse[3] = _inverse[3] - elements[11] * d03

        _inverse[4] = 0 - elements[4] * d15
        _inverse[4] = _inverse[4] + elements[6] * d12
        _inverse[4] = _inverse[4] - elements[7] * d11
        _inverse[5] = elements[0] * d15
        _inverse[5] = _inverse[5] - elements[2] * d12
        _inverse[5] = _inverse[5] + elements[3] * d11
        _inverse[6] = 0 - elements[12] * d05
        _inverse[6] = _inverse[6] + elements[14] * d02
        _inverse[6] = _inverse[6] - elements[15] * d01
        _inverse[7] = elements[8] * d05
        _inverse[7] = _inverse[7] - elements[10] * d02
        _inverse[7] = _inverse[7] + elements[11] * d01

        _inverse[8] = elements[4] * d14
        _inverse[8] = _inverse[8] - elements[5] * d12
        _inverse[8] = _inverse[8] + elements[7] * d10
        _inverse[9] = 0 - elements[0] * d14
        _inverse[9] = _inverse[9] + elements[1] * d12
        _inverse[9] = _inverse[9] - elements[3] * d10
        _inverse[10] = elements[12] * d04
        _inverse[10] = _inverse[10] - elements[13] * d02
        _inverse[10] = _inverse[10] + elements[15] * d00
        _inverse[11] = 0 - elements[8] * d04
        _inverse[11] = _inverse[11] + elements[9] * d02
        _inverse[11] = _inverse[11] - elements[11] * d00

        _inverse[12] = 0 - elements[4] * d13
        _inverse[12] = _inverse[12] + elements[5] * d11
        _inverse[12] = _inverse[12] - elements[6] * d10
        _inverse[13] = elements[0] * d13
        _inverse[13] = _inverse[13] - elements[1] * d11
        _inverse[13] = _inverse[13] + elements[2] * d10
        _inverse[14] = 0 - elements[12] * d03
        _inverse[14] = _inverse[14] + elements[13] * d01
        _inverse[14] = _inverse[14] - elements[14] * d00
        _inverse[15] = elements[8] * d03
        _inverse[15] = _inverse[15] - elements[9] * d01
        _inverse[15] = _inverse[15] + elements[10] * d00

        let invdet = 1 / Double(_determinant)
        for i in _inverse.indices {
            _inverse[i] = T(invdet * Double(_inverse[i]))
        }
        return Matrix4A<T>(_inverse)
    }

    static func /(lhs: Matrix4A<T>, rhs: T) -> Matrix4A<T> {
        Matrix4A<T>(lhs.elements.map{$0 / rhs})
    }

    static func /=(lhs: inout Matrix4A<T>, rhs: T) {
        lhs = lhs / rhs
    }
}

public extension Matrix4A where T: BinaryInteger {
    var inverse: Matrix4A<T> {
        let d00: T = elements[0] * elements[5] - elements[4] * elements[1]
        let d01: T = elements[0] * elements[6] - elements[4] * elements[2]
        let d02: T = elements[0] * elements[7] - elements[4] * elements[3]
        let d03: T = elements[1] * elements[6] - elements[5] * elements[2]
        let d04: T = elements[1] * elements[7] - elements[5] * elements[3]
        let d05: T = elements[2] * elements[7] - elements[6] * elements[3]

        let d10: T = elements[8] * elements[13] - elements[12] * elements[9]
        let d11: T = elements[8] * elements[14] - elements[12] * elements[10]
        let d12: T = elements[8] * elements[15] - elements[12] * elements[11]
        let d13: T = elements[9] * elements[14] - elements[13] * elements[10]
        let d14: T = elements[9] * elements[15] - elements[13] * elements[11]
        let d15: T = elements[10] * elements[15] - elements[14] * elements[11]

        var _determinant = d00 * d15
        _determinant = _determinant - d01 * d14
        _determinant = _determinant + d02 * d13
        _determinant = _determinant + d03 * d12
        _determinant = _determinant - d04 * d11
        _determinant = _determinant + d05 * d10

        var _inverse: [T] = Array<T>(repeating: 0, count: 16)
        _inverse[0] = elements[5] * d15
        _inverse[0] = _inverse[0] - elements[6] * d14
        _inverse[0] = _inverse[0] + elements[7] * d13
        _inverse[1] = 0 - elements[1] * d15
        _inverse[1] = _inverse[1] + elements[2] * d14
        _inverse[1] = _inverse[1] - elements[3] * d13
        _inverse[2] = elements[13] * d05
        _inverse[2] = _inverse[2] - elements[14] * d04
        _inverse[2] = _inverse[2] + elements[15] * d03
        _inverse[3] = 0 - elements[9] * d05
        _inverse[3] = _inverse[3] + elements[10] * d04
        _inverse[3] = _inverse[3] - elements[11] * d03

        _inverse[4] = 0 - elements[4] * d15
        _inverse[4] = _inverse[4] + elements[6] * d12
        _inverse[4] = _inverse[4] - elements[7] * d11
        _inverse[5] = elements[0] * d15
        _inverse[5] = _inverse[5] - elements[2] * d12
        _inverse[5] = _inverse[5] + elements[3] * d11
        _inverse[6] = 0 - elements[12] * d05
        _inverse[6] = _inverse[6] + elements[14] * d02
        _inverse[6] = _inverse[6] - elements[15] * d01
        _inverse[7] = elements[8] * d05
        _inverse[7] = _inverse[7] - elements[10] * d02
        _inverse[7] = _inverse[7] + elements[11] * d01

        _inverse[8] = elements[4] * d14
        _inverse[8] = _inverse[8] - elements[5] * d12
        _inverse[8] = _inverse[8] + elements[7] * d10
        _inverse[9] = 0 - elements[0] * d14
        _inverse[9] = _inverse[9] + elements[1] * d12
        _inverse[9] = _inverse[9] - elements[3] * d10
        _inverse[10] = elements[12] * d04
        _inverse[10] = _inverse[10] - elements[13] * d02
        _inverse[10] = _inverse[10] + elements[15] * d00
        _inverse[11] = 0 - elements[8] * d04
        _inverse[11] = _inverse[11] + elements[9] * d02
        _inverse[11] = _inverse[11] - elements[11] * d00

        _inverse[12] = 0 - elements[4] * d13
        _inverse[12] = _inverse[12] + elements[5] * d11
        _inverse[12] = _inverse[12] - elements[6] * d10
        _inverse[13] = elements[0] * d13
        _inverse[13] = _inverse[13] - elements[1] * d11
        _inverse[13] = _inverse[13] + elements[2] * d10
        _inverse[14] = 0 - elements[12] * d03
        _inverse[14] = _inverse[14] + elements[13] * d01
        _inverse[14] = _inverse[14] - elements[14] * d00
        _inverse[15] = elements[8] * d03
        _inverse[15] = _inverse[15] - elements[9] * d01
        _inverse[15] = _inverse[15] + elements[10] * d00

        let invdet = 1 / Double(_determinant)
        for i in _inverse.indices {
            _inverse[i] = T(invdet * Double(_inverse[i]))
        }
        return Matrix4A<T>(_inverse)
    }

    static func /<U: BinaryFloatingPoint>(lhs: Matrix4A<T>, rhs: U) -> Matrix4A<T> {
        Matrix4A<T>(lhs.elements.map{ T(U($0) / rhs)})
    }

    static func /=<U: BinaryFloatingPoint>(lhs: inout Matrix4A<T>, rhs: U) {
        lhs = lhs / rhs
    }
}