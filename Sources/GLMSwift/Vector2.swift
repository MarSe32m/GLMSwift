import func Foundation.sqrt
import func Foundation.acos
import struct Foundation.CGFloat

public typealias vec2i = Vector2<Int>
public typealias vec2u = Vector2<UInt>
public typealias vec2d = Vector2<Double>
public typealias vec2f = Vector2<Float>
public typealias vec2  = vec3f

public struct Vector2<T>: CustomStringConvertible, Equatable where T: Numeric, T: SIMDScalar {
    public var x: T
    public var y: T

    public var description: String {
        "(\(x), \(y))"
    }

    public var inverse: Vector2<T> {
        -self
    }

    public init(_ x: T = 0, _ y: T = 0) {
        self.x = x
        self.y = y
    }

    public init(x: T = 0, y: T = 0) {
        self.x = x
        self.y = y
    }

    public init<U>(vector2: Vector2<U>) where U: BinaryInteger {
        self.x = T(exactly: vector2.x) ?? 0
        self.y = T(exactly: vector2.y) ?? 0
    }

    public init<U>(_ vector2: Vector2<U>) where U: BinaryInteger {
        self.x = T(exactly: vector2.x) ?? 0
        self.y = T(exactly: vector2.y) ?? 0
    }

    public func dot(_ rhs: Vector2<T>) -> T {
        x * rhs.x + y * rhs.y
    }

    public func cross(_ rhs: Vector2<T>) -> T {
        return x * rhs.y - y * rhs.x
    }

    public static func +(lhs: Vector2<T>, rhs: Vector2<T>) -> Vector2<T> {
        Vector2<T>(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    public static func +=(lhs: inout Vector2<T>, rhs: Vector2<T>) {
        lhs = lhs + rhs
    }
    
    public static func -(lhs: Vector2<T>, rhs: Vector2<T>) -> Vector2<T> {
        Vector2<T>(lhs.x - rhs.x, lhs.y - rhs.y)
    }
    
    public static func -=(lhs: inout Vector2<T>, rhs: Vector2<T>) {
        lhs = lhs - rhs
    }

    public static func *(lhs: T, rhs: Vector2<T>) -> Vector2<T> {
        Vector2<T>(lhs * rhs.x, lhs * rhs.y)
    }
    
    public static func *(lhs: Vector2<T>, rhs: T) -> Vector2<T> {
        rhs * lhs
    }

    public static func *=(lhs: inout Vector2<T>, rhs: T) {
        lhs = rhs * lhs
    }

    public static prefix func -(vector: Vector2<T>) -> Vector2<T> {
        -1 * vector
    }

    static func ~= (lhs: Vector2<T>, rhs: Vector2<T>) -> Bool {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y
    }
}

public extension Vector2 where T: FloatingPoint {
    var lengthSquared: T {
        x * x + y * y
    }

    var length: T {
        return sqrt(lengthSquared)
    }

    var normalized: Vector2<T> {
        self / length
    }

    func angle(with other: Vector2<T>) -> T {
        let x = self.dot(other) / (self.length * other.length)
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

    static func /(lhs: Vector2<T>, rhs: T) -> Vector2<T> {
        Vector2<T>(lhs.x / rhs, lhs.y / rhs)
    }

    static func /=(lhs: inout Vector2<T>, rhs: T) {
        lhs = lhs / rhs
    }
}

public extension Vector2 where T: BinaryInteger {
    var lengthSquared: T {
        return x * x + y * y
    }

    var length: Double {
        return sqrt(Double(lengthSquared))
    }

    var normalized: Vector2<Double> {
        Vector2<Double>(Double(x), Double(y)) / length
    }

    func angle(with other: Vector2<T>) -> Double {
        acos(Double(self.dot(other)) / (self.length * other.length))
    }

    static func /<U: BinaryFloatingPoint>(lhs: Vector2<T>, rhs: U) -> Vector2<T> {
        Vector2<T>(T(U(lhs.x) / rhs), T(U(lhs.y) / rhs))
    }

    static func /=<U: BinaryFloatingPoint>(lhs: inout Vector2<T>, rhs: U) {
        lhs = lhs / rhs
    }
}