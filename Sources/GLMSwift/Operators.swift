#if canImport(simd)
    import simd
#endif

// Arithmetic Operators

public prefix func ++<T: MatrixType>(v: inout T) -> T {
    v = v + 1
    return v
}

public postfix func ++<T: MatrixType>(v: inout T) -> T {
    let r = v
    v = v + 1
    return r
}

public prefix func --<T: MatrixType>(v: inout T) -> T {
    v = v - 1
    return v
}

public postfix func --<T: MatrixType>(v: inout T) -> T {
    let r = v
    v = v - 1
    return r
}

public func +<T: MatrixType>(x1: T, x2: T) -> T {
    #if canImport(simd)
        switch (x1) {
        case is Matrix2x2<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float2x2.self) + unsafeBitCast(x2, to: float2x2.self), to: T.self)

        case is Matrix2x2<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double2x2.self) + unsafeBitCast(x2, to: double2x2.self), to: T.self)

        case is Matrix2x4<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float2x4.self) + unsafeBitCast(x2, to: float2x4.self), to: T.self)

        case is Matrix2x4<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double2x4.self) + unsafeBitCast(x2, to: double2x4.self), to: T.self)

        case is Matrix3x2<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float3x2.self) + unsafeBitCast(x2, to: float3x2.self), to: T.self)

        case is Matrix3x2<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double3x2.self) + unsafeBitCast(x2, to: double3x2.self), to: T.self)

        case is Matrix3x4<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float3x4.self) + unsafeBitCast(x2, to: float3x4.self), to: T.self)

        case is Matrix3x4<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double3x4.self) + unsafeBitCast(x2, to: double3x4.self), to: T.self)

        case is Matrix4x2<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float4x2.self) + unsafeBitCast(x2, to: float4x2.self), to: T.self)

        case is Matrix4x2<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double4x2.self) + unsafeBitCast(x2, to: double4x2.self), to: T.self)

        case is Matrix4x4<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float4x4.self) + unsafeBitCast(x2, to: float4x4.self), to: T.self)

        case is Matrix4x4<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double4x4.self) + unsafeBitCast(x2, to: double4x4.self), to: T.self)

        case is Vector2<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float2.self) + unsafeBitCast(x2, to: float2.self), to: T.self)

        case is Vector2<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double2.self) + unsafeBitCast(x2, to: double2.self), to: T.self)

        case is Vector4<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float4.self) + unsafeBitCast(x2, to: float4.self), to: T.self)

        case is Vector4<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double4.self) + unsafeBitCast(x2, to: double4.self), to: T.self)
        default: break
        }
    #endif
    return T(x1, x2, +)
}

public func +=<T: MatrixType>(x1: inout T, x2: T) {
    x1 = x1 + x2
}

public func +<T: MatrixType>(s: T.Element, x: T) -> T {
    return T(s, x, +)
}

public func +<T: MatrixType>(x: T, s: T.Element) -> T {
    return T(x, s, +)
}

public func +=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x + s
}

public func -<T: MatrixType>(x1: T, x2: T) -> T {
    #if canImport(simd)
        switch (x1) {
        case is Matrix2x2<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float2x2.self) - unsafeBitCast(x2, to: float2x2.self), to: T.self)

        case is Matrix2x2<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double2x2.self) - unsafeBitCast(x2, to: double2x2.self), to: T.self)

        case is Matrix2x4<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float2x4.self) - unsafeBitCast(x2, to: float2x4.self), to: T.self)

        case is Matrix2x4<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double2x4.self) - unsafeBitCast(x2, to: double2x4.self), to: T.self)

        case is Matrix3x2<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float3x2.self) - unsafeBitCast(x2, to: float3x2.self), to: T.self)

        case is Matrix3x2<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double3x2.self) - unsafeBitCast(x2, to: double3x2.self), to: T.self)

        case is Matrix3x4<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float3x4.self) - unsafeBitCast(x2, to: float3x4.self), to: T.self)

        case is Matrix3x4<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double3x4.self) - unsafeBitCast(x2, to: double3x4.self), to: T.self)

        case is Matrix4x2<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float4x2.self) - unsafeBitCast(x2, to: float4x2.self), to: T.self)

        case is Matrix4x2<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double4x2.self) - unsafeBitCast(x2, to: double4x2.self), to: T.self)

        case is Matrix4x4<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float4x4.self) - unsafeBitCast(x2, to: float4x4.self), to: T.self)

        case is Matrix4x4<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double4x4.self) - unsafeBitCast(x2, to: double4x4.self), to: T.self)

        case is Vector2<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float2.self) - unsafeBitCast(x2, to: float2.self), to: T.self)

        case is Vector2<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double2.self) - unsafeBitCast(x2, to: double2.self), to: T.self)

        case is Vector4<Float> :
            return unsafeBitCast(unsafeBitCast(x1, to: float4.self) - unsafeBitCast(x2, to: float4.self), to: T.self)

        case is Vector4<Double> :
            return unsafeBitCast(unsafeBitCast(x1, to: double4.self) - unsafeBitCast(x2, to: double4.self), to: T.self)
        default: break
        }
    #endif
    return T(x1, x2, -)
}

public func -=<T: MatrixType>(x1: inout T, x2: T) {
    x1 = x1 - x2
}

public func -<T: MatrixType>(s: T.Element, x: T) -> T {
    return T(s, x, -)
}

public func -<T: MatrixType>(x: T, s: T.Element) -> T {
    return T(x, s, -)
}

public func -=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x - s
}

public func *<T: MatrixType>(s: T.Element, x: T) -> T {
    #if canImport(simd)
        switch (x) {
        case is Matrix2x2<Float> :
            return unsafeBitCast((s as! Float) * unsafeBitCast(x, to: float2x2.self), to: T.self)

        case is Matrix2x2<Double> :
            return unsafeBitCast((s as! Double) * unsafeBitCast(x, to: double2x2.self), to: T.self)

        case is Matrix2x4<Float> :
            return unsafeBitCast((s as! Float) * unsafeBitCast(x, to: float2x4.self), to: T.self)

        case is Matrix2x4<Double> :
            return unsafeBitCast((s as! Double) * unsafeBitCast(x, to: double2x4.self), to: T.self)

        case is Matrix3x2<Float> :
            return unsafeBitCast((s as! Float) * unsafeBitCast(x, to: float3x2.self), to: T.self)

        case is Matrix3x2<Double> :
            return unsafeBitCast((s as! Double) * unsafeBitCast(x, to: double3x2.self), to: T.self)

        case is Matrix3x4<Float> :
            return unsafeBitCast((s as! Float) * unsafeBitCast(x, to: float3x4.self), to: T.self)

        case is Matrix3x4<Double> :
            return unsafeBitCast((s as! Double) * unsafeBitCast(x, to: double3x4.self), to: T.self)

        case is Matrix4x2<Float> :
            return unsafeBitCast((s as! Float) * unsafeBitCast(x, to: float4x2.self), to: T.self)

        case is Matrix4x2<Double> :
            return unsafeBitCast((s as! Double) * unsafeBitCast(x, to: double4x2.self), to: T.self)

        case is Matrix4x4<Float> :
            return unsafeBitCast((s as! Float) * unsafeBitCast(x, to: float4x4.self), to: T.self)

        case is Matrix4x4<Double> :
            return unsafeBitCast((s as! Double) * unsafeBitCast(x, to: double4x4.self), to: T.self)

        case is Vector2<Float> :
            return unsafeBitCast((s as! Float) * unsafeBitCast(x, to: float2.self), to: T.self)

        case is Vector2<Double> :
            return unsafeBitCast((s as! Double) * unsafeBitCast(x, to: double2.self), to: T.self)

        case is Vector4<Float> :
            return unsafeBitCast((s as! Float) * unsafeBitCast(x, to: float4.self), to: T.self)

        case is Vector4<Double> :
            return unsafeBitCast((s as! Double) * unsafeBitCast(x, to: double4.self), to: T.self)
        default: break
        }
    #endif
    return T(s, x, *)
}

public func *<T: MatrixType>(x: T, s: T.Element) -> T {
    #if canImport(simd)
        switch (x) {
        case is Matrix2x2<Float> :
            return unsafeBitCast(unsafeBitCast(x, to: float2x2.self) * (s as! Float), to: T.self)

        case is Matrix2x2<Double> :
            return unsafeBitCast(unsafeBitCast(x, to: double2x2.self) * (s as! Double), to: T.self)

        case is Matrix2x4<Float> :
            return unsafeBitCast(unsafeBitCast(x, to: float2x4.self) * (s as! Float), to: T.self)

        case is Matrix2x4<Double> :
            return unsafeBitCast(unsafeBitCast(x, to: double2x4.self) * (s as! Double), to: T.self)

        case is Matrix3x2<Float> :
            return unsafeBitCast(unsafeBitCast(x, to: float3x2.self) * (s as! Float), to: T.self)

        case is Matrix3x2<Double> :
            return unsafeBitCast(unsafeBitCast(x, to: double3x2.self) * (s as! Double), to: T.self)

        case is Matrix3x4<Float> :
            return unsafeBitCast(unsafeBitCast(x, to: float3x4.self) * (s as! Float), to: T.self)

        case is Matrix3x4<Double> :
            return unsafeBitCast(unsafeBitCast(x, to: double3x4.self) * (s as! Double), to: T.self)

        case is Matrix4x2<Float> :
            return unsafeBitCast(unsafeBitCast(x, to: float4x2.self) * (s as! Float), to: T.self)

        case is Matrix4x2<Double> :
            return unsafeBitCast(unsafeBitCast(x, to: double4x2.self) * (s as! Double), to: T.self)

        case is Matrix4x4<Float> :
            return unsafeBitCast(unsafeBitCast(x, to: float4x4.self) * (s as! Float), to: T.self)

        case is Matrix4x4<Double> :
            return unsafeBitCast(unsafeBitCast(x, to: double4x4.self) * (s as! Double), to: T.self)

        case is Vector2<Float> :
            return unsafeBitCast(unsafeBitCast(x, to: float2.self) * (s as! Float), to: T.self)

        case is Vector2<Double> :
            return unsafeBitCast(unsafeBitCast(x, to: double2.self) * (s as! Double), to: T.self)

        case is Vector4<Float> :
            return unsafeBitCast(unsafeBitCast(x, to: float4.self) * (s as! Float), to: T.self)

        case is Vector4<Double> :
            return unsafeBitCast(unsafeBitCast(x, to: double4.self) * (s as! Double), to: T.self)
        default: break
        }
    #endif
    return T(x, s, *)
}

public func *=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x * s
}

public func /<T: MatrixType>(s: T.Element, x: T) -> T {
    return T(s, x, /)
}

public func /<T: MatrixType>(x: T, s: T.Element) -> T {
    return T(x, s, /)
}

public func /=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x / s
}

public func %<T: MatrixType>(x1: T, x2: T) -> T {
    return T(x1, x2, %)
}

public func %=<T: MatrixType>(x1: inout T, x2: T) {
    x1 = x1 % x2
}

public func %<T: MatrixType>(s: T.Element, x: T) -> T {
    return T(s, x, %)
}

public func %<T: MatrixType>(x: T, s: T.Element) -> T {
    return T(x, s, %)
}

public func %=<T: MatrixType>(x: inout T, s: T.Element) {
    x = x % s
}

// Unchecked Integer Operators

public func &+<T: MatrixType>(v1: T, v2: T) -> T where T.Element: FixedWidthInteger {
    #if canImport(simd)
        switch (v1) {
        case is Vector2<Int32>, is Vector2<UInt32> :
            return unsafeBitCast(unsafeBitCast(v1, to: int2.self) &+ unsafeBitCast(v2, to: int2.self), to: T.self)

        case is Vector4<Int32>, is Vector4<UInt32> :
            return unsafeBitCast(unsafeBitCast(v1, to: int4.self) &+ unsafeBitCast(v2, to: int4.self), to: T.self)

        default:
            break
        }
    #endif
    return T(v1, v2, &+)
}

public func &+<T: MatrixType>(s: T.Element, v: T) -> T where T.Element: FixedWidthInteger {
    return T(s, v, &+)
}

public func &+<T: MatrixType>(v: T, s: T.Element) -> T where T.Element: FixedWidthInteger {
    return T(v, s, &+)
}

public func &-<T: MatrixType>(v1: T, v2: T) -> T where T.Element: FixedWidthInteger {
    #if canImport(simd)
        switch (v1) {
        case is Vector2<Int32>, is Vector2<UInt32> :
            return unsafeBitCast(unsafeBitCast(v1, to: int2.self) &- unsafeBitCast(v2, to: int2.self), to: T.self)

        case is Vector4<Int32>, is Vector4<UInt32> :
            return unsafeBitCast(unsafeBitCast(v1, to: int4.self) &- unsafeBitCast(v2, to: int4.self), to: T.self)

        default:
            break
        }
    #endif
    return T(v1, v2, &-)
}

public func &-<T: MatrixType>(s: T.Element, v: T) -> T where T.Element: FixedWidthInteger {
    return T(s, v, &-)
}

public func &-<T: MatrixType>(v: T, s: T.Element) -> T where T.Element: FixedWidthInteger {
    return T(v, s, &-)
}

public func &*<T: MatrixType>(v1: T, v2: T) -> T where T.Element: FixedWidthInteger {
    #if canImport(simd)
        switch (v1) {
        case is Vector2<Int32>, is Vector2<UInt32> :
            return unsafeBitCast(unsafeBitCast(v1, to: int2.self) &* unsafeBitCast(v2, to: int2.self), to: T.self)

        case is Vector4<Int32>, is Vector4<UInt32> :
            return unsafeBitCast(unsafeBitCast(v1, to: int4.self) &* unsafeBitCast(v2, to: int4.self), to: T.self)

        default:
            break
        }
    #endif
    return T(v1, v2, &*)
}

public func &*<T: MatrixType>(s: T.Element, v: T) -> T where T.Element: FixedWidthInteger {
    #if canImport(simd)
        switch (v) {
        case is Vector2<Int32>, is Vector2<UInt32> :
            return unsafeBitCast(unsafeBitCast(s, to: Int32.self) &* unsafeBitCast(v, to: int2.self), to: T.self)

        case is Vector4<Int32>, is Vector4<UInt32> :
            return unsafeBitCast(unsafeBitCast(s, to: Int32.self) &* unsafeBitCast(v, to: int4.self), to: T.self)

        default:
            break
        }
    #endif
    return T(s, v, &*)
}

public func &*<T: MatrixType>(v: T, s: T.Element) -> T where T.Element: FixedWidthInteger {
    #if canImport(simd)
        switch (v) {
        case is Vector2<Int32>, is Vector2<UInt32> :
            return unsafeBitCast(unsafeBitCast(v, to: int2.self) &* unsafeBitCast(s, to: Int32.self), to: T.self)

        case is Vector4<Int32>, is Vector4<UInt32> :
            return unsafeBitCast(unsafeBitCast(v, to: int4.self) &* unsafeBitCast(s, to: Int32.self), to: T.self)

        default:
            break
        }
    #endif
    return T(v, s, &*)
}

public func << <T: MatrixType>(v: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(v, s, <<)
}

public func <<= <T: MatrixType>(v: inout T, s: T.Element) where T.Element: BitsOperationsType {
    v = v << s
}

public func >> <T: MatrixType>(v: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(v, s, <<)
}

public func >>= <T: MatrixType>(v: inout T, s: T.Element) where T.Element: BitsOperationsType {
    v = v >> s
}

public func &<T: MatrixType>(x1: T, x2: T) -> T where T.Element: BitsOperationsType {
    return T(x1, x2, &)
}

public func &=<T: MatrixType>(x1: inout T, x2: T) where T.Element: BitsOperationsType {
    x1 = x1 & x2
}

public func &<T: MatrixType>(s: T.Element, x: T) -> T where T.Element: BitsOperationsType {
    return T(s, x, &)
}

public func &<T: MatrixType>(x: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(x, s, &)
}

public func &=<T: MatrixType>(x: inout T, s: T.Element) where T.Element: BitsOperationsType {
    x = x & s
}

public func |<T: MatrixType>(x1: T, x2: T) -> T where T.Element: BitsOperationsType {
    return T(x1, x2, |)
}

public func |=<T: MatrixType>(x1: inout T, x2: T) where T.Element: BitsOperationsType {
    x1 = x1 | x2
}

public func |<T: MatrixType>(s: T.Element, x: T) -> T where T.Element: BitsOperationsType {
    return T(s, x, |)
}

public func |<T: MatrixType>(x: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(x, s, |)
}

public func |=<T: MatrixType>(x: inout T, s: T.Element) where T.Element: BitsOperationsType {
    x = x | s
}

public func ^<T: MatrixType>(v1: T, v2: T) -> T where T.Element: BitsOperationsType {
    return T(v1, v2, ^)
}

public func ^=<T: MatrixType>(x1: inout T, x2: T) where T.Element: BitsOperationsType {
    x1 = x1 ^ x2
}

public func ^<T: MatrixType>(s: T.Element, x: T) -> T where T.Element: BitsOperationsType {
    return T(s, x, ^)
}

public func ^<T: MatrixType>(x: T, s: T.Element) -> T where T.Element: BitsOperationsType {
    return T(x, s, ^)
}

public func ^=<T: MatrixType>(x: inout T, s: T.Element) where T.Element: BitsOperationsType {
    x = x ^ s
}

public prefix func ~<T: MatrixType>(v: T) -> T where T.Element: BitsOperationsType {
    return T(v, ~)
}

// Signed Numbers Only

public prefix func +<T: MatrixType>(v: T) -> T where T.Element: SignedNumeric {
    return v
}

public prefix func -<T: MatrixType>(x: T) -> T where T.Element: SignedNumeric {
    #if canImport(simd)
        switch (x) {
        case is Matrix2x2<Float> :
            return unsafeBitCast(-unsafeBitCast(x, to: float2x2.self), to: T.self)

        case is Matrix2x2<Double> :
            return unsafeBitCast(-unsafeBitCast(x, to: double2x2.self), to: T.self)

        case is Matrix2x4<Float> :
            return unsafeBitCast(-unsafeBitCast(x, to: float2x4.self), to: T.self)

        case is Matrix2x4<Double> :
            return unsafeBitCast(-unsafeBitCast(x, to: double2x4.self), to: T.self)

        case is Matrix3x2<Float> :
            return unsafeBitCast(-unsafeBitCast(x, to: float3x2.self), to: T.self)

        case is Matrix3x2<Double> :
            return unsafeBitCast(-unsafeBitCast(x, to: double3x2.self), to: T.self)

        case is Matrix3x4<Float> :
            return unsafeBitCast(-unsafeBitCast(x, to: float3x4.self), to: T.self)

        case is Matrix3x4<Double> :
            return unsafeBitCast(-unsafeBitCast(x, to: double3x4.self), to: T.self)

        case is Matrix4x2<Float> :
            return unsafeBitCast(-unsafeBitCast(x, to: float4x2.self), to: T.self)

        case is Matrix4x2<Double> :
            return unsafeBitCast(-unsafeBitCast(x, to: double4x2.self), to: T.self)

        case is Matrix4x4<Float> :
            return unsafeBitCast(-unsafeBitCast(x, to: float4x4.self), to: T.self)

        case is Matrix4x4<Double> :
            return unsafeBitCast(-unsafeBitCast(x, to: double4x4.self), to: T.self)

        case is Vector2<Float> :
            return unsafeBitCast(-unsafeBitCast(x, to: float2.self), to: T.self)

        case is Vector2<Double> :
            return unsafeBitCast(-unsafeBitCast(x, to: double2.self), to: T.self)

        case is Vector2<Int32>:
            return unsafeBitCast(-unsafeBitCast(x, to: int2.self), to: T.self)

        case is Vector4<Float> :
            return unsafeBitCast(-unsafeBitCast(x, to: float4.self), to: T.self)

        case is Vector4<Double> :
            return unsafeBitCast(-unsafeBitCast(x, to: double4.self), to: T.self)

        case is Vector4<Int32>:
            return unsafeBitCast(-unsafeBitCast(x, to: int4.self), to: T.self)
        default: break
        }
    #endif
    return T(x, -)
}

// Vector Multiply and Divide

public func *<T: VectorType>(v1: T, v2: T) -> T {
    #if canImport(simd)
        switch (v1) {
        case is Vector2<Float> :
            return unsafeBitCast(unsafeBitCast(v1, to: float2.self) * unsafeBitCast(v2, to: float2.self), to: T.self)

        case is Vector2<Double> :
            return unsafeBitCast(unsafeBitCast(v1, to: double2.self) * unsafeBitCast(v2, to: double2.self), to: T.self)

        case is Vector4<Float> :
            return unsafeBitCast(unsafeBitCast(v1, to: float4.self) * unsafeBitCast(v2, to: float4.self), to: T.self)

        case is Vector4<Double> :
            return unsafeBitCast(unsafeBitCast(v1, to: double4.self) * unsafeBitCast(v2, to: double4.self), to: T.self)
        default: break
        }
    #endif
    return T(v1, v2, *)
}

public func *=<T: VectorType>(v1: inout T, v2: T) {
    v1 = v1 * v2
}

public func /<T: VectorType>(v1: T, v2: T) -> T {
    #if canImport(simd)
        switch (v1) {
        case is Vector2<Int32>, is Vector2<UInt32> :
            return unsafeBitCast(unsafeBitCast(v1, to: int2.self) / unsafeBitCast(v2, to: int2.self), to: T.self)

        case is Vector4<Int32>, is Vector4<UInt32> :
            return unsafeBitCast(unsafeBitCast(v1, to: int4.self) / unsafeBitCast(v2, to: int4.self), to: T.self)

        case is Vector2<Float> :
            return unsafeBitCast(unsafeBitCast(v1, to: float2.self) / unsafeBitCast(v2, to: float2.self), to: T.self)

        case is Vector2<Double> :
            return unsafeBitCast(unsafeBitCast(v1, to: double2.self) / unsafeBitCast(v2, to: double2.self), to: T.self)

        case is Vector4<Float> :
            return unsafeBitCast(unsafeBitCast(v1, to: float4.self) / unsafeBitCast(v2, to: float4.self), to: T.self)

        case is Vector4<Double> :
            return unsafeBitCast(unsafeBitCast(v1, to: double4.self) / unsafeBitCast(v2, to: double4.self), to: T.self)

        default:
            break
        }
    #endif
    return T(v1, v2, /)
}

public func /=<T: VectorType>(v1: inout T, v2: T) {
    v1 = v1 / v2
}
