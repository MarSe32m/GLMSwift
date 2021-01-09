import func Foundation.sqrt
import func Foundation.acos
import struct Foundation.CGFloat

public typealias vec4i = Vector4<Int>
public typealias vec4u = Vector4<UInt>
public typealias vec4d = Vector4<Double>
public typealias vec4f = Vector4<Float>
public typealias vec4  = vec4f

public struct Vector4<T>: CustomStringConvertible, Equatable where T: Numeric, T: SIMDScalar {
    public var x: T
    public var y: T
    public var z: T
    public var w: T
    
    public var xyz: Vector3<T> {
        Vector3<T>(x, y, z)
    }

    public var description: String {
        "(\(x), \(y), \(z), \(w))"
    }

    public var inverse: Vector4<T> {
        -self
    }

    public init(_ x: T = 0, _ y: T = 0, _ z: T = 0, _ w: T = 0) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init(x: T = 0, y: T = 0, z: T = 0, w: T = 0) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init(_ vector3: Vector3<T>, _ w: T = 1) {
        self.x = vector3.x
        self.y = vector3.y
        self.z = vector3.z
        self.w = w
    }
    
    public init(vector3: Vector3<T>, w: T = 1) {
        self.x = vector3.x
        self.y = vector3.y
        self.z = vector3.z
        self.w = w
    }

    public func dot(_ rhs: Vector4<T>) -> T {
        var dotProduct = x * rhs.x + y * rhs.y
        dotProduct += z * rhs.z + w * rhs.w
        return dotProduct
    }

    public static func +(lhs: Vector4<T>, rhs: Vector4<T>) -> Vector4<T> {
        Vector4<T>(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
    }
    
    public static func +=(lhs: inout Vector4<T>, rhs: Vector4<T>) {
        lhs = lhs + rhs
    }
    
    public static func -(lhs: Vector4<T>, rhs: Vector4<T>) -> Vector4<T> {
        Vector4<T>(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
    }
    
    public static func -=(lhs: inout Vector4<T>, rhs: Vector4<T>) {
        lhs = lhs - rhs
    }

    public static func *(lhs: T, rhs: Vector4<T>) -> Vector4<T> {
        Vector4<T>(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
    }
    
    public static func *(lhs: Vector4<T>, rhs: T) -> Vector4<T> {
        rhs * lhs
    }

    public static func *=(lhs: inout Vector4<T>, rhs: T) {
        lhs = rhs * lhs
    }

    public static prefix func -(vector: Vector4<T>) -> Vector4<T> {
        -1 * vector
    }

    static func ~= (lhs: Vector4<T>, rhs: Vector4<T>) -> Bool where T: Equatable {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y && lhs.z ~= rhs.z && lhs.w ~= rhs.w
    }
}

public extension Vector4 where T: FloatingPoint {
    var lengthSquared: T {
        var sum = x * x + y * y
        sum += z * z + w * w
        return sum
    }

    var length: T {
        return sqrt(lengthSquared)
    }

    var normalized: Vector4<T> {
        self / length
    }

    func angle(with other: Vector4<T>) -> T {
        let x = self.dot(other) / (self.length * other.length)
        //TODO: Float80, Float16?
        switch x {
            case let x as Double:
                return acos(x) as? T ?? 0
            case let x as CGFloat:
                return acos(x) as? T ?? 0
            case let x as Float:
                return acos(x) as? T ?? 0
            default:
                return 0 as T
        }
    }

    static func /(lhs: Vector4<T>, rhs: T) -> Vector4<T> {
        Vector4<T>(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
    }

    static func /=(lhs: inout Vector4<T>, rhs: T) {
        lhs = lhs / rhs
    }
}

public extension Vector4 where T: BinaryInteger {
    var lengthSquared: T {
        return x * x + y * y + z * z + w * w
    }

    var length: Double {
        return sqrt(Double(lengthSquared))
    }

    var normalized: Vector4<Double> {
        Vector4<Double>(Double(x), Double(y), Double(z), Double(w)) / length
    }

    func angle(with other: Vector4<T>) -> Double {
        acos(Double(self.dot(other)) / (self.length * other.length))
    }

    static func /<U: BinaryFloatingPoint>(lhs: Vector4<T>, rhs: U) -> Vector4<T> {
        Vector4<T>(T(U(lhs.x) / rhs), T(U(lhs.y) / rhs), T(U(lhs.z) / rhs), T(U(lhs.w) / rhs))
    }

    static func /=<U: BinaryFloatingPoint>(lhs: inout Vector4<T>, rhs: U) {
        lhs = lhs / rhs
    }
}