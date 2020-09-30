public struct Vector4<T: ArithmeticType>: VectorType {
    public typealias Element = T
    public typealias FloatVector = Vector4<Float>
    public typealias DoubleVector = Vector4<Double>
    public typealias Int32Vector = Vector4<Int32>
    public typealias UInt32Vector = Vector4<UInt32>
    public typealias BooleanVector = Vector4b

    public var x: T, y: T, z: T, w: T

    public var r: T { get { return x } set { x = newValue } }
    public var g: T { get { return y } set { y = newValue } }
    public var b: T { get { return z } set { z = newValue } }
    public var a: T { get { return w } set { w = newValue } }

    public var s: T { get { return x } set { x = newValue } }
    public var t: T { get { return y } set { y = newValue } }
    public var p: T { get { return z } set { z = newValue } }
    public var q: T { get { return w } set { w = newValue } }

    public var elements: [Element] {
        return [x, y, z, w]
    }

    public func makeIterator() -> IndexingIterator<Array<Element>> {
        return elements.makeIterator()
    }

    public subscript(index: Int) -> T {
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
        self.x = 0
        self.y = 0
        self.z = 0
        self.w = 0
    }

    public init (_ v: T) {
        self.x = v
        self.y = v
        self.z = v
        self.w = v
    }

    public init(_ array: [T]) {
        precondition(array.count == 4, "Vector4 requires a 4-element array")
        self.x = array[0]
        self.y = array[1]
        self.z = array[2]
        self.w = array[3]
    }

    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }

    public init (_ x: T, _ y: T, _ z: T, _ w: T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init (_ v: Vector3<T>, _ w: T) {
        self.x = v.x
        self.y = v.y
        self.z = v.z
        self.w = w
    }

    public init (_ x: T, _ v: Vector3<T>) {
        self.x = x
        self.y = v.x
        self.z = v.y
        self.w = v.z
    }

    public init (_ v: Vector2<T>, _ z: T, _ w: T) {
        self.x = v.x
        self.y = v.y
        self.z = z
        self.w = w
    }

    public init (_ x: T, _ y: T, _ v: Vector2<T>) {
        self.x = x
        self.y = y
        self.z = v.x
        self.w = v.y
    }

    public init (_ x: T, _ v: Vector2<T>, _ w: T) {
        self.x = x
        self.y = v.x
        self.z = v.y
        self.w = w
    }

    public init (_ v1: Vector2<T>, _ v2: Vector2<T>) {
        self.x = v1.x
        self.y = v1.y
        self.z = v2.x
        self.w = v2.y
    }

    public init (x: T, y: T, z: T, w: T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init (r: T, g: T, b: T, a: T) {
        self.x = r
        self.y = g
        self.z = b
        self.w = a
    }

    public init (s: T, t: T, p: T, q: T) {
        self.x = s
        self.y = t
        self.z = p
        self.w = q
    }

    public init (_ v: Vector4<T>) {
        self.x = v.x
        self.y = v.y
        self.z = v.z
        self.w = v.w
    }

    public init (_ v: Vector4<Double>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<Float>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<Int>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<UInt>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<Int8>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<UInt8>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<Int16>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<UInt16>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<Int32>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<UInt32>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<Int64>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v: Vector4<UInt64>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ s: T, _ v: Vector4<T>, _ op:(_:T, _:T) -> T) {
        self.x = op(s, v.x)
        self.y = op(s, v.y)
        self.z = op(s, v.z)
        self.w = op(s, v.w)
    }

    public init (_ v: Vector4<T>, _ s: T, _ op:(_:T, _:T) -> T) {
        self.x = op(v.x, s)
        self.y = op(v.y, s)
        self.z = op(v.z, s)
        self.w = op(v.w, s)
    }

    public init<T: VectorType>(_ v: T, _ op:(_:T.Element) -> Element) where T.BooleanVector == BooleanVector {
        self.x = op(v[0])
        self.y = op(v[1])
        self.z = op(v[2])
        self.w = op(v[3])
    }

    public init<T1: VectorType, T2: VectorType>(_ v1: T1, _ v2: T2, _ op:(_:T1.Element, _:T2.Element) -> Element) where
        T1.BooleanVector == BooleanVector, T2.BooleanVector == BooleanVector {
            self.x = op(v1[0], v2[0])
            self.y = op(v1[1], v2[1])
            self.z = op(v1[2], v2[2])
            self.w = op(v1[3], v2[3])
    }

    public init<T1: VectorType, T2: VectorType>(_ v1: T1, _ v2:inout T2, _ op:(_:T1.Element, _:inout T2.Element) -> Element) where
        T1.BooleanVector == BooleanVector, T2.BooleanVector == BooleanVector {
            self.x = op(v1[0], &v2[0])
            self.y = op(v1[1], &v2[1])
            self.z = op(v1[2], &v2[2])
            self.w = op(v1[3], &v2[3])
    }

    public init<T1: VectorType, T2: VectorType, T3: VectorType>(_ v1: T1, _ v2: T2, _ v3: T3, _ op:(_:T1.Element, _:T2.Element, _:T3.Element) -> Element) where
        T1.BooleanVector == BooleanVector, T2.BooleanVector == BooleanVector, T3.BooleanVector == BooleanVector {
            self.x = op(v1[0], v2[0], v3[0])
            self.y = op(v1[1], v2[1], v3[1])
            self.z = op(v1[2], v2[2], v3[2])
            self.w = op(v1[3], v2[3], v3[3])
    }

    public init<T1: VectorType, T2: VectorType, T3: BooleanVectorType>(_ v1: T1, _ v2: T2, _ v3: T3, _ op:(_:T1.Element, _:T2.Element, _:Bool) -> Element) where
        T1.BooleanVector == BooleanVector, T2.BooleanVector == BooleanVector, T3.BooleanVector == BooleanVector {
            self.x = op(v1[0], v2[0], v3[0])
            self.y = op(v1[1], v2[1], v3[1])
            self.z = op(v1[2], v2[2], v3[2])
            self.w = op(v1[3], v2[3], v3[3])
    }

    public static func ==(v1: Vector4<T>, v2: Vector4<T>) -> Bool {
        return v1.x == v2.x && v1.y == v2.y && v1.z == v2.z && v1.w == v2.w
    }
}
