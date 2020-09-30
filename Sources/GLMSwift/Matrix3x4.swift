public struct Matrix3x4<T: ArithmeticType>: MatrixType {
    public typealias Element = T

    private var x: Vector4<T>, y: Vector4<T>, z: Vector4<T>

    public subscript(column: Int) -> Vector4<T> {
        get {
            switch(column) {
            case 0: return x
            case 1: return y
            case 2: return z
            default: preconditionFailure("Matrix index out of range")
            }
        }
        set {
            switch(column) {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            default: preconditionFailure("Matrix index out of range")
            }
        }
    }

    public var elements: [Element] {
        return Array([x.elements, y.elements, z.elements].joined())
    }

    public func makeIterator() -> IndexingIterator<Array<Element>> {
        return elements.makeIterator()
    }

    public subscript(column: Int, row: Int) -> T {
        return self[column][row]
    }

    public var debugDescription: String {
        return String(describing: type(of: self)) + "(" + [x, y, z].map { (v: Vector4<T>) -> String in
            "[" + [v.x, v.y, v.z, v.w].map { (n: T) -> String in String(describing: n) }.joined(separator: ", ") + "]"
        }.joined(separator: ", ") + ")"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(GLMSwift.hash(x.hashValue, y.hashValue, z.hashValue))
    }

    public init() {
        self.x = Vector4<T>(1, 0, 0, 0)
        self.y = Vector4<T>(0, 1, 0, 0)
        self.z = Vector4<T>(0, 0, 1, 0)
    }

    public init(_ s: T) {
        self.x = Vector4<T>(s, 0, 0, 0)
        self.y = Vector4<T>(0, s, 0, 0)
        self.z = Vector4<T>(0, 0, s, 0)
    }

    public init(_ x: Vector4<T>, _ y: Vector4<T>, _ z: Vector4<T>) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init(
        _ x1: T, _ y1: T, _ z1: T, _ w1: T,
        _ x2: T, _ y2: T, _ z2: T, _ w2: T,
        _ x3: T, _ y3: T, _ z3: T, _ w3: T
        ) {
            self.x = Vector4<T>(x1, y1, z1, w1)
            self.y = Vector4<T>(x2, y2, z2, w2)
            self.z = Vector4<T>(x3, y3, z3, w3)
    }

    public init(_ m: Matrix2x2<T>) {
        self.x = Vector4<T>(m[0], 0, 0)
        self.y = Vector4<T>(m[1], 0, 0)
        self.z = Vector4<T>(0, 0, 1, 0)
    }

    public init(_ m: Matrix2x3<T>) {
        self.x = Vector4<T>(m[0], 0)
        self.y = Vector4<T>(m[1], 0)
        self.z = Vector4<T>(0, 0, 1, 0)
    }

    public init(_ m: Matrix2x4<T>) {
        self.x = Vector4<T>(m[0])
        self.y = Vector4<T>(m[1])
        self.z = Vector4<T>(0, 0, 1, 0)
    }

    public init(_ m: Matrix3x2<T>) {
        self.x = Vector4<T>(m[0], 0, 0)
        self.y = Vector4<T>(m[1], 0, 0)
        self.z = Vector4<T>(m[2], 1, 0)
    }

    public init(_ m: Matrix3x3<T>) {
        self.x = Vector4<T>(m[0], 0)
        self.y = Vector4<T>(m[1], 0)
        self.z = Vector4<T>(m[2], 0)
    }

    public init(_ m: Matrix3x4<T>) {
        self.x = Vector4<T>(m[0])
        self.y = Vector4<T>(m[1])
        self.z = Vector4<T>(m[2])
    }

    public init(_ m: Matrix4x2<T>) {
        self.x = Vector4<T>(m[0], 0, 0)
        self.y = Vector4<T>(m[1], 0, 0)
        self.z = Vector4<T>(m[2], 1, 0)
    }

    public init(_ m: Matrix4x3<T>) {
        self.x = Vector4<T>(m[0], 0)
        self.y = Vector4<T>(m[1], 0)
        self.z = Vector4<T>(m[2], 0)
    }

    public init(_ m: Matrix4x4<T>) {
        self.x = Vector4<T>(m[0])
        self.y = Vector4<T>(m[1])
        self.z = Vector4<T>(m[2])
    }

    public init(_ m: Matrix3x4<Double>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<Float>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<Int>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<UInt>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<Int8>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<UInt8>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<Int16>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<UInt16>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<Int32>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<UInt32>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<Int64>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init(_ m: Matrix3x4<UInt64>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
        self.z = Vector4<T>(m.z)
    }

    public init (_ m: Matrix3x4<T>, _ op:(_:T) -> T) {
        self.x = Vector4<T>(m.x, op)
        self.y = Vector4<T>(m.y, op)
        self.z = Vector4<T>(m.z, op)
    }

    public init (_ s: T, _ m: Matrix3x4<T>, _ op:(_:T, _:T) -> T) {
        self.x = Vector4<T>(s, m.x, op)
        self.y = Vector4<T>(s, m.y, op)
        self.z = Vector4<T>(s, m.z, op)
    }

    public init (_ m: Matrix3x4<T>, _ s: T, _ op:(_:T, _:T) -> T) {
        self.x = Vector4<T>(m.x, s, op)
        self.y = Vector4<T>(m.y, s, op)
        self.z = Vector4<T>(m.z, s, op)
    }

    public init (_ m1: Matrix3x4<T>, _ m2: Matrix3x4<T>, _ op:(_:T, _:T) -> T) {
        self.x = Vector4<T>(m1.x, m2.x, op)
        self.y = Vector4<T>(m1.y, m2.y, op)
        self.z = Vector4<T>(m1.z, m2.z, op)
    }

    public var transpose: Matrix4x3<T> {
        return Matrix4x3(
            self.x.x, self.y.x, self.z.x,
            self.x.y, self.y.y, self.z.y,
            self.x.z, self.y.z, self.z.z,
            self.x.w, self.y.w, self.z.w
        )
    }

    public static func ==(m1: Matrix3x4<T>, m2: Matrix3x4<T>) -> Bool {
        return m1.x == m2.x && m1.y == m2.y && m1.z == m2.z
    }

    public static func *(v: Vector4<T>, m: Matrix3x4<T>) -> Vector3<T> {
        var x: T = v.x * m.x.x
            x = x + v.y * m.x.y
            x = x + v.z * m.x.z
            x = x + v.w * m.x.w
        var y: T = v.x * m.y.x
            y = y + v.y * m.y.y
            y = y + v.z * m.y.z
            y = y + v.w * m.y.w
        var z: T = v.x * m.z.x
            z = z + v.y * m.z.y
            z = z + v.z * m.z.z
            z = z + v.w * m.z.w
        return Vector3<T>(x, y, z)
    }

    public static func *(m: Matrix3x4<T>, v: Vector3<T>) -> Vector4<T> {
        var rv: Vector4<T> = m.x * v.x
            rv = rv + m.y * v.y
            rv = rv + m.z * v.z
        return rv
    }

    public static func *(m1: Matrix3x4<T>, m2: Matrix2x3<T>) -> Matrix2x4<T> {
        var x: Vector4<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
            x = x + m1.z * m2[0].z
        var y: Vector4<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
            y = y + m1.z * m2[1].z
        return Matrix2x4<T>(x, y)
    }

    public static func *(m1: Matrix3x4<T>, m2: Matrix3x3<T>) -> Matrix3x4<T> {
        var x: Vector4<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
            x = x + m1.z * m2[0].z
        var y: Vector4<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
            y = y + m1.z * m2[1].z
        var z: Vector4<T> = m1.x * m2[2].x
            z = z + m1.y * m2[2].y
            z = z + m1.z * m2[2].z
        return Matrix3x4<T>(x, y, z)
    }

    public static func *(m1: Matrix3x4<T>, m2: Matrix4x3<T>) -> Matrix4x4<T> {
        var x: Vector4<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
            x = x + m1.z * m2[0].z
        var y: Vector4<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
            y = y + m1.z * m2[1].z
        var z: Vector4<T> = m1.x * m2[2].x
            z = z + m1.y * m2[2].y
            z = z + m1.z * m2[2].z
        var w: Vector4<T> = m1.x * m2[3].x
            w = w + m1.y * m2[3].y
            w = w + m1.z * m2[3].z
        return Matrix4x4<T>(x, y, z, w)
    }
}
