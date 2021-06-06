import Foundation

public typealias vec3i = Vector3<Int>
public typealias vec3u = Vector3<UInt>
public typealias vec3d = Vector3<Double>
public typealias vec3f = Vector3<Float>
public typealias vec3  = vec3f

public struct Vector3<T>: CustomStringConvertible, Equatable where T: Numeric, T: SIMDScalar {
    public var x: T
    public var y: T
    public var z: T

    public var description: String {
        "(\(x), \(y), \(z))"
    }

    public var inverse: Vector3<T> {
        -self
    }

    public init(_ x: T = 0, _ y: T = 0, _ z: T = 0) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init(x: T = 0, y: T = 0, z: T = 0) {
        self.x = x
        self.y = y
        self.z = z
    }
    /*
    public init(_ vector2: Vector2<T>, _ z: T = 1) {
        self.x = vector2.x
        self.y = vector2.y
        self.z = z
    }
    
    public init(vector2: Vector3<T>, z: T = 1) {
        self.x = vector2.x
        self.y = vector2.y
        self.z = z
    }
    */

    public func dot(_ rhs: Vector3<T>) -> T {
        let dotProduct = x * rhs.x + y * rhs.y + z * rhs.z
        return dotProduct
    }

    public func cross(_ rhs: Vector3<T>) -> Vector3<T> {
        let x = self.y * rhs.z - self.z * rhs.y
        let y = self.z * rhs.x - self.x * rhs.z
        let z = self.x * rhs.y - self.y * rhs.x
        return Vector3<T>(x, y, z)
    }

    public static func +(lhs: Vector3<T>, rhs: Vector3<T>) -> Vector3<T> {
        Vector3<T>(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }
    
    public static func +=(lhs: inout Vector3<T>, rhs: Vector3<T>) {
        lhs = lhs + rhs
    }
    
    public static func -(lhs: Vector3<T>, rhs: Vector3<T>) -> Vector3<T> {
        Vector3<T>(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
    }
    
    public static func -=(lhs: inout Vector3<T>, rhs: Vector3<T>) {
        lhs = lhs - rhs
    }

    public static func *(lhs: T, rhs: Vector3<T>) -> Vector3<T> {
        Vector3<T>(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z)
    }
    
    public static func *(lhs: Vector3<T>, rhs: T) -> Vector3<T> {
        rhs * lhs
    }

    public static func *=(lhs: inout Vector3<T>, rhs: T) {
        lhs = rhs * lhs
    }

    public static prefix func -(vector: Vector3<T>) -> Vector3<T> {
        -1 * vector
    }

    static func ~= (lhs: Vector3<T>, rhs: Vector3<T>) -> Bool where T: Equatable {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y && lhs.z ~= rhs.z
    }
}

public extension Vector3 where T: FloatingPoint {
    var lengthSquared: T {
        x * x + y * y + z * z
    }

    var length: T {
        return sqrt(lengthSquared)
    }

    var normalized: Vector3<T> {
        self / length
    }

    func angle(with other: Vector3<T>) -> T {
        let x = self.dot(other) / (self.length * other.length)
        //TODO: Float80, Float16?
        switch x {
            case let x as Double:
                return acos(x) as? T ?? 0
            case let x as Float:
                return acos(x) as? T ?? 0
            default:
                return 0 as T
        }
    }

    static func /(lhs: Vector3<T>, rhs: T) -> Vector3<T> {
        Vector3<T>(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
    }

    static func /=(lhs: inout Vector3<T>, rhs: T) {
        lhs = lhs / rhs
    }
}

public extension Vector3 where T: BinaryInteger {
    var lengthSquared: T {
        return x * x + y * y + z * z
    }

    var length: Double {
        return sqrt(Double(lengthSquared))
    }

    var normalized: Vector3<Double> {
        Vector3<Double>(Double(x), Double(y), Double(z)) / length
    }

    func angle(with other: Vector3<T>) -> Double {
        acos(Double(self.dot(other)) / (self.length * other.length))
    }

    static func /<U: BinaryFloatingPoint>(lhs: Vector3<T>, rhs: U) -> Vector3<T> {
        Vector3<T>(T(U(lhs.x) / rhs), T(U(lhs.y) / rhs), T(U(lhs.z) / rhs))
    }

    static func /=<U: BinaryFloatingPoint>(lhs: inout Vector3<T>, rhs: U) {
        lhs = lhs / rhs
    }
}
