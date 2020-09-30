public struct Vector4b: BooleanVectorType {
    public typealias BooleanVector = Vector4b

    public var x: Bool, y: Bool, z: Bool, w: Bool

    public var r: Bool { get { return x } set { x = newValue } }
    public var g: Bool { get { return y } set { y = newValue } }
    public var b: Bool { get { return z } set { z = newValue } }
    public var a: Bool { get { return w } set { w = newValue } }

    public var s: Bool { get { return x } set { x = newValue } }
    public var t: Bool { get { return y } set { y = newValue } }
    public var p: Bool { get { return z } set { z = newValue } }
    public var q: Bool { get { return w } set { w = newValue } }

    public var elements: [Bool] {
        return [x, y, z, w]
    }

    public func makeIterator() -> IndexingIterator<Array<Bool>> {
        return elements.makeIterator()
    }

    public subscript(index: Int) -> Bool {
        get {
            switch(index) {
            case 0: return x
            case 1: return y
            case 2: return z
            case 3: return w
            default: preconditionFailure("Vector index out of range")
            }
        }
        set {
            switch(index) {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            case 3: w = newValue
            default: preconditionFailure("Vector index out of range")
            }
        }
    }

    public var debugDescription: String {
        return String(describing: type(of: self)) + "(\(x), \(y), \(z), \(w))"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(GLMSwift.hash(x.hashValue, y.hashValue, z.hashValue, w.hashValue))
    }

    public init () {
        self.x = false
        self.y = false
        self.z = false
        self.w = false
    }

    public init (_ v: Bool) {
        self.x = v
        self.y = v
        self.z = v
        self.w = v
    }

    public init (_ x: Bool, _ y: Bool, _ z: Bool, _ w: Bool) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init(_ v: Vector3b, _ w: Bool) {
        self.x = v.x
        self.y = v.y
        self.z = v.z
        self.w = w
    }

    public init (_ x: Bool, _ v: Vector3b) {
        self.x = x
        self.y = v.x
        self.z = v.y
        self.w = v.z
    }

    public init (_ v: Vector2b, _ z: Bool, _ w: Bool) {
        self.x = v.x
        self.y = v.y
        self.z = z
        self.w = w
    }

    public init (_ x: Bool, _ y: Bool, _ v: Vector2b) {
        self.x = x
        self.y = y
        self.z = v.x
        self.w = v.y
    }

    public init (_ x: Bool, _ v: Vector2b, _ w: Bool) {
        self.x = x
        self.y = v.x
        self.z = v.y
        self.w = w
    }

    public init (_ v1: Vector2b, _ v2: Vector2b) {
        self.x = v1.x
        self.y = v1.y
        self.z = v2.x
        self.w = v2.y
    }

    public init (x: Bool, y: Bool, z: Bool, w: Bool) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init (r: Bool, g: Bool, b: Bool, a: Bool) {
        self.x = r
        self.y = g
        self.z = b
        self.w = a
    }

    public init (s: Bool, t: Bool, p: Bool, q: Bool) {
        self.x = s
        self.y = t
        self.z = p
        self.w = q
    }

    public init (_ v: Vector4b) {
        self.x = v.x
        self.y = v.y
        self.z = v.z
        self.w = v.w
    }

    public init (_ s: Bool, _ v: Vector4b, _ op:(_:Bool, _:Bool) -> Bool) {
        self.x = op(s, v.x)
        self.y = op(s, v.y)
        self.z = op(s, v.z)
        self.w = op(s, v.w)
    }

    public init (_ v: Vector4b, _ s: Bool, _ op:(_:Bool, _:Bool) -> Bool) {
        self.x = op(v.x, s)
        self.y = op(v.y, s)
        self.z = op(v.z, s)
        self.w = op(v.w, s)
    }

    public init(_ v: Vector4b, _ op:(_:Bool) -> Bool) {
        self.x = op(v[0])
        self.y = op(v[1])
        self.z = op(v[2])
        self.w = op(v[3])
    }

    public init<T: VectorType>(_ v: T, _ op:(_:T.Element) -> Bool) where T.BooleanVector == BooleanVector {
            self.x = op(v[0])
            self.y = op(v[1])
            self.z = op(v[2])
            self.w = op(v[3])
    }

    public init<T1: VectorType, T2: VectorType>(_ v1: T1, _ v2: T2, _ op:(_:T1.Element, _:T2.Element) -> Bool) where
        T1.BooleanVector == BooleanVector, T2.BooleanVector == BooleanVector {
            self.x = op(v1[0], v2[0])
            self.y = op(v1[1], v2[1])
            self.z = op(v1[2], v2[2])
            self.w = op(v1[3], v2[3])
    }

    public static func ==(v1: Vector4b, v2: Vector4b) -> Bool {
        return v1.x == v2.x && v1.y == v2.y && v1.z == v2.z && v1.w == v2.w
    }
}
