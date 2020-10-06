

public struct Matrix4x2<T: ArithmeticType>: MatrixType {
    public typealias Element = T

    private var x: Vector2<T>, y: Vector2<T>, z: Vector2<T>, w: Vector2<T>

    public subscript(column: Int) -> Vector2<T> {
        get {
            switch(column) {
            case 0: return x
            case 1: return y
            case 2: return z
            case 3: return w
            default: preconditionFailure("Matrix index out of range")
            }
        }
        set {
            switch(column) {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            case 3: w = newValue
            default: preconditionFailure("Matrix index out of range")
            }
        }
    }

    public var elements: [Element] {
        return Array([x.elements, y.elements, z.elements, w.elements].joined())
    }

    public func makeIterator() -> IndexingIterator<Array<Element>> {
        return elements.makeIterator()
    }

    public subscript(column: Int, row: Int) -> T {
        return self[column][row]
    }

    public var debugDescription: String {
        return String(describing: type(of: self)) + "(" + [x, y, z, w].map { (v: Vector2<T>) -> String in
            "[" + [v.x, v.y].map { (n: T) -> String in String(describing: n) }.joined(separator: ", ") + "]"
        }.joined(separator: ", ") + ")"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(GLMSwift.hash(x.hashValue, y.hashValue, z.hashValue, w.hashValue))
    }

    public init() {
        self.x = Vector2<T>(1, 0)
        self.y = Vector2<T>(0, 1)
        self.z = Vector2<T>(0, 0)
        self.w = Vector2<T>(0, 0)
    }

    public init(_ s: T) {
        self.x = Vector2<T>(s, 0)
        self.y = Vector2<T>(0, s)
        self.z = Vector2<T>(0, 0)
        self.w = Vector2<T>(0, 0)
    }

    public init(_ x: Vector2<T>, _ y: Vector2<T>, _ z: Vector2<T>, _ w: Vector2<T>) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init(
        _ x1: T, _ y1: T,
        _ x2: T, _ y2: T,
        _ x3: T, _ y3: T,
        _ x4: T, _ y4: T
        ) {
            self.x = Vector2<T>(x1, y1)
            self.y = Vector2<T>(x2, y2)
            self.z = Vector2<T>(x3, y3)
            self.w = Vector2<T>(x4, y4)
    }

    public init(_ m: Matrix2x2<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
        self.z = Vector2<T>(0, 0)
        self.w = Vector2<T>(0, 0)
    }

    public init(_ m: Matrix2x3<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
        self.z = Vector2<T>(0, 0)
        self.w = Vector2<T>(0, 0)
    }

    public init(_ m: Matrix2x4<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
        self.z = Vector2<T>(0, 0)
        self.w = Vector2<T>(0, 0)
    }

    public init(_ m: Matrix3x2<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
        self.z = Vector2<T>(m[2])
        self.w = Vector2<T>(0, 0)
    }

    public init(_ m: Matrix3x3<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
        self.z = Vector2<T>(m[2])
        self.w = Vector2<T>(0, 0)
    }

    public init(_ m: Matrix3x4<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
        self.z = Vector2<T>(m[2])
        self.w = Vector2<T>(0, 0)
    }

    public init(_ m: Matrix4x2<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
        self.z = Vector2<T>(m[2])
        self.w = Vector2<T>(m[3])
    }

    public init(_ m: Matrix4x3<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
        self.z = Vector2<T>(m[2])
        self.w = Vector2<T>(m[3])
    }

    public init(_ m: Matrix4x4<T>) {
        self.x = Vector2<T>(m[0])
        self.y = Vector2<T>(m[1])
        self.z = Vector2<T>(m[2])
        self.w = Vector2<T>(m[3])
    }

    public init(_ m: Matrix4x2<Double>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<Float>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<Int>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<UInt>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<Int8>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<UInt8>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<Int16>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<UInt16>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<Int32>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<UInt32>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<Int64>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init(_ m: Matrix4x2<UInt64>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
        self.w = Vector2<T>(m.w)
    }

    public init (_ m: Matrix4x2<T>, _ op:(_:T) -> T) {
        self.x = Vector2<T>(m.x, op)
        self.y = Vector2<T>(m.y, op)
        self.z = Vector2<T>(m.z, op)
        self.w = Vector2<T>(m.w, op)
    }

    public init (_ s: T, _ m: Matrix4x2<T>, _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(s, m.x, op)
        self.y = Vector2<T>(s, m.y, op)
        self.z = Vector2<T>(s, m.z, op)
        self.w = Vector2<T>(s, m.w, op)
    }

    public init (_ m: Matrix4x2<T>, _ s: T, _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(m.x, s, op)
        self.y = Vector2<T>(m.y, s, op)
        self.z = Vector2<T>(m.z, s, op)
        self.w = Vector2<T>(m.w, s, op)
    }

    public init (_ m1: Matrix4x2<T>, _ m2: Matrix4x2<T>, _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(m1.x, m2.x, op)
        self.y = Vector2<T>(m1.y, m2.y, op)
        self.z = Vector2<T>(m1.z, m2.z, op)
        self.w = Vector2<T>(m1.w, m2.w, op)
    }

    public var transpose: Matrix2x4<T> {
        return Matrix2x4(
            self.x.x, self.y.x, self.z.x, self.w.x,
            self.x.y, self.y.y, self.z.y, self.w.y
        )
    }

    public static func ==(m1: Matrix4x2<T>, m2: Matrix4x2<T>) -> Bool {
        return m1.x == m2.x && m1.y == m2.y && m1.z == m2.z && m1.w == m2.w
    }

    public static func *(v: Vector2<T>, m: Matrix4x2<T>) -> Vector4<T> {
        
        let x: T = v.x * m.x.x + v.y * m.x.y
        let y: T = v.x * m.y.x + v.y * m.y.y
        let z: T = v.x * m.z.x + v.y * m.z.y
        let w: T = v.x * m.w.x + v.y * m.w.y
        return Vector4<T>(x, y, z, w)
    }

    public static func *(m: Matrix4x2<T>, v: Vector4<T>) -> Vector2<T> {
        
        var rv: Vector2<T> = m.x * v.x
            rv = rv + m.y * v.y
            rv = rv + m.z * v.z
            rv = rv + m.w * v.w
        return rv
    }

    public static func *(m1: Matrix4x2<T>, m2: Matrix2x4<T>) -> Matrix2x2<T> {
        
        var x: Vector2<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
            x = x + m1.z * m2[0].z
            x = x + m1.w * m2[0].w
        var y: Vector2<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
            y = y + m1.z * m2[1].z
            y = y + m1.w * m2[1].w
        return Matrix2x2<T>(x, y)
    }

    public static func *(m1: Matrix4x2<T>, m2: Matrix3x4<T>) -> Matrix3x2<T> {
        
        var x: Vector2<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
            x = x + m1.z * m2[0].z
            x = x + m1.w * m2[0].w
        var y: Vector2<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
            y = y + m1.z * m2[1].z
            y = y + m1.w * m2[1].w
        var z: Vector2<T> = m1.x * m2[2].x
            z = z + m1.y * m2[2].y
            z = z + m1.z * m2[2].z
            z = z + m1.w * m2[2].w
        return Matrix3x2<T>(x, y, z)
    }

    public static func *(m1: Matrix4x2<T>, m2: Matrix4x4<T>) -> Matrix4x2<T> {
        
        var x: Vector2<T> = m1.x * m2[0].x
            x = x + m1.y * m2[0].y
            x = x + m1.z * m2[0].z
            x = x + m1.w * m2[0].w
        var y: Vector2<T> = m1.x * m2[1].x
            y = y + m1.y * m2[1].y
            y = y + m1.z * m2[1].z
            y = y + m1.w * m2[1].w
        var z: Vector2<T> = m1.x * m2[2].x
            z = z + m1.y * m2[2].y
            z = z + m1.z * m2[2].z
            z = z + m1.w * m2[2].w
        var w: Vector2<T> = m1.x * m2[3].x
            w = w + m1.y * m2[3].y
            w = w + m1.z * m2[3].z
            w = w + m1.w * m2[3].w
        return Matrix4x2<T>(x, y, z, w)
    }
}
