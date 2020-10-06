

public struct Matrix2x2<T: ArithmeticType>: MatrixType {
    public typealias Element = T

    private var x: Vector2<T>, y: Vector2<T>

    public subscript(column: Int) -> Vector2<T> {
        get {
            switch(column) {
            case 0: return x
            case 1: return y
            default: preconditionFailure("Matrix index out of range")
            }
        }
        set {
            switch(column) {
            case 0: x = newValue
            case 1: y = newValue
            default: preconditionFailure("Matrix index out of range")
            }
        }
    }

    public var elements: [Element] {
        return Array([x.elements, y.elements].joined())
    }

    public func makeIterator() -> IndexingIterator<Array<Element>> {
        return elements.makeIterator()
    }

    public subscript(column: Int, row: Int) -> T {
        return self[column][row]
    }

    public var debugDescription: String {
        return String(describing: type(of: self)) + "(" + [x, y].map { (v: Vector2<T>) -> String in
            "[" + [v.x, v.y].map { (n: T) -> String in String(describing: n) }.joined(separator: ", ") + "]"
        }.joined(separator: ", ") + ")"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(GLMSwift.hash(x.hashValue, y.hashValue))
    }

    public init() {
        self.x = Vector2<T>(1, 0)
        self.y = Vector2<T>(0, 1)
    }

    public init(_ s: T) {
        self.x = Vector2<T>(s, 0)
        self.y = Vector2<T>(0, s)
    }

    public init(_ x: Vector2<T>, _ y: Vector2<T>) {
        self.x = x
        self.y = y
    }

    public init(
        _ x1: T, _ y1: T,
        _ x2: T, _ y2: T
        ) {
            self.x = Vector2<T>(x1, y1)
            self.y = Vector2<T>(x2, y2)
    }

    public init(_ m: Matrix2x2<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
    }

    public init(_ m: Matrix2x3<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
    }

    public init(_ m: Matrix2x4<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
    }

    public init(_ m: Matrix3x2<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
    }

    public init(_ m: Matrix3x3<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
    }

    public init(_ m: Matrix3x4<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
    }

    public init(_ m: Matrix4x2<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
    }

    public init(_ m: Matrix4x3<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
    }

    public init(_ m: Matrix4x4<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
    }

    public init(_ m: Matrix2x2<Double>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Float>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int8>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt8>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int16>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt16>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int32>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt32>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int64>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt64>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init (_ m: Matrix2x2<T>, _ op:(_:T) -> T) {
        self.x = Vector2<T>(m.x, op)
        self.y = Vector2<T>(m.y, op)
    }

    public init (_ s: T, _ m: Matrix2x2<T>, _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(s, m.x, op)
        self.y = Vector2<T>(s, m.y, op)
    }

    public init (_ m: Matrix2x2<T>, _ s: T, _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(m.x, s, op)
        self.y = Vector2<T>(m.y, s, op)
    }

    public init (_ m1: Matrix2x2<T>, _ m2: Matrix2x2<T>, _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(m1.x, m2.x, op)
        self.y = Vector2<T>(m1.y, m2.y, op)
    }

    public var inverse: Matrix2x2<T> {
        
        let invdet: T = 1 / determinant
        return invdet * Matrix2x2<T>(self.y.y, 0 - self.x.y, 0 - self.y.x, self.x.x)
    }

    public var determinant: T {
        return self.x.x * self.y.y - self.y.x * self.x.y
    }

    public var transpose: Matrix2x2<T> {
        return Matrix2x2(
            self.x.x, self.y.x,
            self.x.y, self.y.y
        )
    }

    public static func ==(m1: Matrix2x2<T>, m2: Matrix2x2<T>) -> Bool {
        return m1.x == m2.x && m1.y == m2.y
    }

    public static func *(v: Vector2<T>, m: Matrix2x2<T>) -> Vector2<T> {
        
        let x: T = v.x * m.x.x + v.y * m.x.y
        let y: T = v.x * m.y.x + v.y * m.y.y
        return Vector2<T>(x, y)
    }

    public static func *(m: Matrix2x2<T>, v: Vector2<T>) -> Vector2<T> {
        
        return m.x * v.x + m.y * v.y
    }

    public static func *(m1: Matrix2x2<T>, m2: Matrix2x2<T>) -> Matrix2x2<T> {
        
        var x: Vector2<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
        var y: Vector2<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
        return Matrix2x2<T>(x, y)
    }

    public static func *(m1: Matrix2x2<T>, m2: Matrix3x2<T>) -> Matrix3x2<T> {
        
        var x: Vector2<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
        var y: Vector2<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
        var z: Vector2<T> = m1.x * m2[2].x
            z = z + m1.y * m2[2].y
        return Matrix3x2<T>(x, y, z)
    }

    public static func *(m1: Matrix2x2<T>, m2: Matrix4x2<T>) -> Matrix4x2<T> {
        
        var x: Vector2<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
        var y: Vector2<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
        var z: Vector2<T> = m1.x * m2[2].x
            z = z + m1.y * m2[2].y
        var w: Vector2<T> = m1.x * m2[3].x
            w = w + m1.y * m2[3].y
        return Matrix4x2<T>(x, y, z, w)
    }

    public static func *=(m1: inout Matrix2x2<T>, m2: Matrix2x2<T>) {
        m1 = m1 * m2
    }

    public static func /(v: Vector2<T>, m: Matrix2x2<T>) -> Vector2<T> {
        return v * m.inverse
    }

    public static func /(m: Matrix2x2<T>, v: Vector2<T>) -> Vector2<T> {
        return m.inverse * v
    }

    public static func /(m1: Matrix2x2<T>, m2: Matrix2x2<T>) -> Matrix2x2<T> {
        return m1 * m2.inverse
    }

    public static func /=(m1: inout Matrix2x2<T>, m2: Matrix2x2<T>) {
        m1 = m1 / m2
    }
}
