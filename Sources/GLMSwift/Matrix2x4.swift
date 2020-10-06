

public struct Matrix2x4<T: ArithmeticType>: MatrixType {
    public typealias Element = T

    private var x: Vector4<T>, y: Vector4<T>

    public subscript(column: Int) -> Vector4<T> {
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
        return String(describing: type(of: self)) + "(" + [x, y].map { (v: Vector4<T>) -> String in
            "[" + [v.x, v.y, v.z, v.w].map { (n: T) -> String in String(describing: n) }.joined(separator: ", ") + "]"
        }.joined(separator: ", ") + ")"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(GLMSwift.hash(x.hashValue, y.hashValue))
    }

    public init() {
        self.x = Vector4<T>(1, 0, 0, 0)
        self.y = Vector4<T>(0, 1, 0, 0)
    }

    public init(_ s: T) {
        self.x = Vector4<T>(s, 0, 0, 0)
        self.y = Vector4<T>(0, s, 0, 0)
    }

    public init(_ x: Vector4<T>, _ y: Vector4<T>) {
        self.x = x
        self.y = y
    }

    public init(
        _ x1: T, _ y1: T, _ z1: T, _ w1: T,
        _ x2: T, _ y2: T, _ z2: T, _ w2: T
        ) {
            self.x = Vector4<T>(x1, y1, z1, w1)
            self.y = Vector4<T>(x2, y2, z2, w2)
    }

    public init(_ m: Matrix2x2<T>) {
        self.x = Vector4<T>(m[0], 0, 0)
        self.y = Vector4<T>(m[1], 0, 0)
    }

    public init(_ m: Matrix2x3<T>) {
        self.x = Vector4<T>(m[0], 0)
        self.y = Vector4<T>(m[1], 0)
    }

    public init(_ m: Matrix2x4<T>) {
        self.x = Vector4<T>(m[0])
        self.y = Vector4<T>(m[1])
    }

    public init(_ m: Matrix3x2<T>) {
        self.x = Vector4<T>(m[0], 0, 0)
        self.y = Vector4<T>(m[1], 0, 0)
    }

    public init(_ m: Matrix3x3<T>) {
        self.x = Vector4<T>(m[0], 0)
        self.y = Vector4<T>(m[1], 0)
    }

    public init(_ m: Matrix3x4<T>) {
        self.x = Vector4<T>(m[0])
        self.y = Vector4<T>(m[1])
    }

    public init(_ m: Matrix4x2<T>) {
        self.x = Vector4<T>(m[0], 0, 0)
        self.y = Vector4<T>(m[1], 0, 0)
    }

    public init(_ m: Matrix4x3<T>) {
        self.x = Vector4<T>(m[0], 0)
        self.y = Vector4<T>(m[1], 0)
    }

    public init(_ m: Matrix4x4<T>) {
        self.x = Vector4<T>(m[0])
        self.y = Vector4<T>(m[1])
    }

    public init(_ m: Matrix2x4<Double>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Float>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int8>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt8>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int16>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt16>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int32>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt32>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int64>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt64>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init (_ m: Matrix2x4<T>, _ op:(_:T) -> T) {
        self.x = Vector4<T>(m.x, op)
        self.y = Vector4<T>(m.y, op)
    }

    public init (_ s: T, _ m: Matrix2x4<T>, _ op:(_:T, _:T) -> T) {
        self.x = Vector4<T>(s, m.x, op)
        self.y = Vector4<T>(s, m.y, op)
    }

    public init (_ m: Matrix2x4<T>, _ s: T, _ op:(_:T, _:T) -> T) {
        self.x = Vector4<T>(m.x, s, op)
        self.y = Vector4<T>(m.y, s, op)
    }

    public init (_ m1: Matrix2x4<T>, _ m2: Matrix2x4<T>, _ op:(_:T, _:T) -> T) {
        self.x = Vector4<T>(m1.x, m2.x, op)
        self.y = Vector4<T>(m1.y, m2.y, op)
    }

    public var transpose: Matrix4x2<T> {
        return Matrix4x2(
            self.x.x, self.y.x,
            self.x.y, self.y.y,
            self.x.z, self.y.z,
            self.x.w, self.y.w
        )
    }

    public static func ==(m1: Matrix2x4<T>, m2: Matrix2x4<T>) -> Bool {
        return m1.x == m2.x && m1.y == m2.y
    }

    public static func *(v: Vector4<T>, m: Matrix2x4<T>) -> Vector2<T> {
        
        var x: T = v.x * m.x.x
            x = x + v.y * m.x.y
            x = x + v.z * m.x.z
            x = x + v.w * m.x.w
        var y: T = v.x * m.y.x
            y = y + v.y * m.y.y
            y = y + v.z * m.y.z
            y = y + v.w * m.y.w
        return Vector2<T>(x, y)
    }

    public static func *(m: Matrix2x4<T>, v: Vector2<T>) -> Vector4<T> {
        
        return m.x * v.x + m.y * v.y
    }

    public static func *(m1: Matrix2x4<T>, m2: Matrix2x2<T>) -> Matrix2x4<T> {
        
        var x: Vector4<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
        var y: Vector4<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
        return Matrix2x4<T>(x, y)
    }

    public static func *(m1: Matrix2x4<T>, m2: Matrix3x2<T>) -> Matrix3x4<T> {
        
        var x: Vector4<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
        var y: Vector4<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
        var z: Vector4<T> = m1.x * m2[2].x
            z = z + m1.y * m2[2].y
        return Matrix3x4<T>(x, y, z)
    }

    public static func *(m1: Matrix2x4<T>, m2: Matrix4x2<T>) -> Matrix4x4<T> {
        
        var x: Vector4<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
        var y: Vector4<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
        var z: Vector4<T> = m1.x * m2[2].x
            z = z + m1.y * m2[2].y
        var w: Vector4<T> = m1.x * m2[3].x
            w = w + m1.y * m2[3].y
        return Matrix4x4<T>(x, y, z, w)
    }
}
