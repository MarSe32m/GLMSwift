public struct Vector2b: BooleanVectorType {
    public typealias BooleanVector = Vector2b

    public var x: Bool, y: Bool

    public var r: Bool { get { return x } set { x = newValue } }
    public var g: Bool { get { return y } set { y = newValue } }

    public var s: Bool { get { return x } set { x = newValue } }
    public var t: Bool { get { return y } set { y = newValue } }

    public var elements: [Bool] {
        return [x, y]
    }

    public func makeIterator() -> IndexingIterator<Array<Bool>> {
        return elements.makeIterator()
    }

    public subscript(index: Int) -> Bool {
        get {
            switch(index) {
            case 0: return x
            case 1: return y
            default: preconditionFailure("Vector index out of range")
            }
        }
        set {
            switch(index) {
            case 0: x = newValue
            case 1: y = newValue
            default: preconditionFailure("Vector index out of range")
            }
        }
    }

    public var debugDescription: String {
        return String(describing: type(of: self)) + "(\(x), \(y))"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(GLMSwift.hash(x.hashValue, y.hashValue))
    }

    public init () {
        self.x = false
        self.y = false
    }

    public init (_ v: Bool) {
        self.x = v
        self.y = v
    }

    public init (_ x: Bool, _ y: Bool) {
        self.x = x
        self.y = y
    }

    public init (x: Bool, y: Bool) {
        self.x = x
        self.y = y
    }

    public init (r: Bool, g: Bool) {
        self.x = r
        self.y = g
    }

    public init (s: Bool, t: Bool) {
        self.x = s
        self.y = t
    }

    public init (_ v: Vector2b) {
        self.x = v.x
        self.y = v.y
    }

    public init (_ v: Vector3b) {
        self.x = v.x
        self.y = v.y
    }

    public init (_ v: Vector4b) {
        self.x = v.x
        self.y = v.y
    }

    public init (_ s: Bool, _ v: Vector2b, _ op:(_:Bool, _:Bool) -> Bool) {
        self.x = op(s, v.x)
        self.y = op(s, v.y)
    }

    public init (_ v: Vector2b, _ s: Bool, _ op:(_:Bool, _:Bool) -> Bool) {
        self.x = op(v.x, s)
        self.y = op(v.y, s)
    }

    public init(_ v: Vector2b, _ op:(_:Bool) -> Bool) {
            self.x = op(v[0])
            self.y = op(v[1])
    }

    public init<T: VectorType>(_ v: T, _ op:(_:T.Element) -> Bool) where T.BooleanVector == BooleanVector {
            self.x = op(v[0])
            self.y = op(v[1])
    }

    public init<T1: VectorType, T2: VectorType>(_ v1: T1, _ v2: T2, _ op:(_:T1.Element, _:T2.Element) -> Bool) where
        T1.BooleanVector == BooleanVector, T2.BooleanVector == BooleanVector {
            self.x = op(v1[0], v2[0])
            self.y = op(v1[1], v2[1])
    }

    public static func ==(v1: Vector2b, v2: Vector2b) -> Bool {
        return v1.x == v2.x && v1.y == v2.y
    }
}
