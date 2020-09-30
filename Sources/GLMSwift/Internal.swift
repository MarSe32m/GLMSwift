import Foundation

public final class GLMSwift {
    // This is MurmurHash3 by Austin Appleby
    // https://en.wikipedia.org/wiki/MurmurHash
    public static func hash(_ nums: Int...) -> Int {
        #if !arch(i386) && !arch(arm)
            // 64 bit
            func rotl(_ x: UInt, _ r: UInt) -> UInt {
                return (x << r) | (x >> (64 - r))
            }
            func fmix(_ kk: UInt) -> UInt {
                var k = kk
                k ^= k >> 33
                k = k &* 0xff51afd7ed558ccd
                k ^= k >> 33
                k = k &* 0xc4ceb9fe1a85ec53
                k ^= k >> 33
                return k
            }
            let c1: UInt = 0x87c37b91114253d5
            let c2: UInt = 0x4cf5ad432745937f
            var h1: UInt = c1 ^ UInt(nums.count)
            var h2: UInt = c2 ^ UInt(nums.count)
            var data = nums.makeIterator()
            while true {
                if let k = data.next() {
                    var k1 = UInt(bitPattern: k) &* c1
                    k1 = rotl(k1, 31)
                    k1 = k1 &* c2
                    h1 ^= k1
                    h1 = rotl(h1, 27)
                    h1 = h1 &+ h2
                    h1 = h1 &* 5 + 0x52dce729
                } else { break }
                if let k = data.next() {
                    var k2 = UInt(bitPattern: k) &* c2
                    k2 = rotl(k2, 33)
                    k2 = k2 &* c1
                    h2 ^= k2
                    h2 = rotl(h2, 31)
                    h2 = h2 &+ h1
                    h2 = h2 &* 5 + 0x38495ab5
                } else { break }
            }
            h1 ^= UInt(nums.count)
            h2 ^= UInt(nums.count)
            h1 = h1 &+ h2
            h2 = h2 &+ h1
            h1 = fmix(h1)
            h2 = fmix(h2)
            h1 = h1 &+ h2
            h2 = h2 &+ h1
            return Int(bitPattern: h1)
        #else
            // 32 bit
            let c1: UInt = 0xcc9e2d51
            let c2: UInt = 0x1b873593
            var h1: UInt = c1 ^ UInt(nums.count)
            for n in nums {
                var k1 = UInt(bitPattern: n)
                k1 = k1 &* c1
                k1 = (k1 << 15) | (k1 >> 17)
                k1 = k1 &* c2
                h1 ^= k1
                h1 = (h1 << 13) | (h1 >> 19)
                h1 = h1 &* 5 + 0xe6546b64
            }
            h1 ^= UInt(nums.count)
            h1 ^= h1 >> 16
            h1 = h1 &* 0x85ebca6b
            h1 ^= h1 >> 13
            h1 = h1 &* 0xc2b2ae35
            h1 ^= h1 >> 16
            return Int(bitPattern: h1)
        #endif
    }

    public static func SGLsin<T: FloatingPointArithmeticType>(_ angle: T) -> T {
        if let z = angle as? Double {
            return sin(z) as! T
        }
        if let z = angle as? Float {
            return sinf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLcos<T: FloatingPointArithmeticType>(_ angle: T) -> T {
        if let z = angle as? Double {
            return cos(z) as! T
        }
        if let z = angle as? Float {
            return cosf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLtan<T: FloatingPointArithmeticType>(_ angle: T) -> T {
        if let z = angle as? Double {
            return tan(z) as! T
        }
        if let z = angle as? Float {
            return tanf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLasin<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return asin(z) as! T
        }
        if let z = x as? Float {
            return asinf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLacos<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return acos(z) as! T
        }
        if let z = x as? Float {
            return acosf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLatan<T: FloatingPointArithmeticType>(_ y: T, _ x: T) -> T {
        if let z = y as? Double {
            return atan2(z, x as! Double) as! T
        }
        if let z = y as? Float {
            return atan2f(z, x as! Float) as! T
        }
        preconditionFailure()
    }

    public static func SGLatan<T: FloatingPointArithmeticType>(_ yoverx: T) -> T {
        if let z = yoverx as? Double {
            return atan(z) as! T
        }
        if let z = yoverx as? Float {
            return atanf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLsinh<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return sinh(z) as! T
        }
        if let z = x as? Float {
            return sinhf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLcosh<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return cosh(z) as! T
        }
        if let z = x as? Float {
            return coshf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLtanh<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return tanh(z) as! T
        }
        if let z = x as? Float {
            return tanhf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLasinh<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return asinh(z) as! T
        }
        if let z = x as? Float {
            return asinhf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLacosh<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return acosh(z) as! T
        }
        if let z = x as? Float {
            return acoshf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLatanh<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return atanh(z) as! T
        }
        if let z = x as? Float {
            return atanhf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLpow<T: FloatingPointArithmeticType>(_ x: T, _ y: T) -> T {
        if let z = x as? Double {
            return pow(z, y as! Double) as! T
        }
        if let z = x as? Float {
            return powf(z, y as! Float) as! T
        }
        preconditionFailure()
    }
    public static func SGLexp<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return exp(z) as! T
        }
        if let z = x as? Float {
            return expf(z) as! T
        }
        preconditionFailure()
    }
    public static func SGLlog<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return log(z) as! T
        }
        if let z = x as? Float {
            return logf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLexp2<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return exp2(z) as! T
        }
        if let z = x as? Float {
            return exp2f(z) as! T
        }
        preconditionFailure()
    }
    public static func SGLlog2<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return log2(z) as! T
        }
        if let z = x as? Float {
            return log2f(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLsqrt<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return sqrt(z) as! T
        }
        if let z = x as? Float {
            return sqrtf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLfloor<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return floor(z) as! T
        }
        if let z = x as? Float {
            return floorf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLtrunc<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return trunc(z) as! T
        }
        if let z = x as? Float {
            return truncf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLround<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return round(z) as! T
        }
        if let z = x as? Float {
            return roundf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLceil<T: FloatingPointArithmeticType>(_ x: T) -> T {
        if let z = x as? Double {
            return ceil(z) as! T
        }
        if let z = x as? Float {
            return ceilf(z) as! T
        }
        preconditionFailure()
    }

    public static func SGLmodf<T: FloatingPointArithmeticType>(_ x: T, _ i:inout T) -> T {
        if let z = x as? Double {
            return withUnsafeMutablePointer(to: &i) {
                $0.withMemoryRebound(to: Double.self, capacity: 1) {
                    modf(z, $0) as! T
                }
            }
        }
        if let z = x as? Float {
            return withUnsafeMutablePointer(to: &i) {
                $0.withMemoryRebound(to: Float.self, capacity: 1) {
                    modff(z, $0) as! T
                }
            }
        }
        preconditionFailure()
    }

    public static func SGLfma<T: FloatingPointArithmeticType>(_ a: T, _ b: T, _ c: T) -> T {
        if let z = a as? Double {
            return fma(z, b as! Double, c as! Double) as! T
        }
        if let z = a as? Float {
            return fmaf(z, b as! Float, c as! Float) as! T
        }
        preconditionFailure()
    }

    public static func SGLfrexp<T: FloatingPointArithmeticType>(_ x: T, _ exp:inout Int32) -> T {
        if let z = x as? Double {
            return frexp(z, &exp) as! T
        }
        if let z = x as? Float {
            return frexpf(z, &exp) as! T
        }
        preconditionFailure()
    }

    public static func SGLldexp<T: FloatingPointArithmeticType>(_ x: T, _ exp: Int32) -> T {
        if let z = x as? Double {
            return ldexp(z, exp) as! T
        }
        if let z = x as? Float {
            return ldexpf(z, exp) as! T
        }
        preconditionFailure()
    }

    public static func floatFromHalf(_ i: UInt16) -> Float {
        let ret: UInt32
        var exponent = UInt32(i) & 0x7c00
        let sign = UInt32(i & 0x8000) << 16
        if (exponent == 0) {
            var significand = UInt32(i & 0x03ff)
            if (significand == 0) {
                // Zero
                ret = sign
            } else {
                // Subnormal
                significand <<= 1
                while ((significand & 0x0400) == 0) {
                    significand <<= 1
                    exponent += 1
                }
                exponent = (127 - 15 - exponent) << 23
                significand = (significand & 0x03ff) << 13
                ret = sign | exponent | significand
            }
        } else if (exponent == 0x7c00) {
            // inf or NaN
            ret = sign | 0x7f800000 | (UInt32(i & 0x03ff) << 13)
        } else {
            // Normal
            ret = sign | ((UInt32(i & 0x7fff) + 0x1c000) << 13)
        }
        return Float(bitPattern: ret)
    }

    public static func halfFromFloat(_ f: Float) -> UInt16 {
        let fbits = f.bitPattern
        let sign = UInt16((fbits & 0x80000000) >> 16)
        var exponent = fbits & 0x7f800000
        var significand: UInt32 = fbits & 0x007fffff

        if (exponent <= 0x38000000) {
            // Exponent underflow
            if (exponent < 0x33000000) {
                // Zero
                return sign
            }
            // Subnormal
            exponent >>= 23
            significand |= 0x00800000
            significand >>= 113 - exponent
            significand += 0x00001000
            return sign | UInt16(significand >> 13)
        }

        if (exponent >= 0x47800000) {
            // Exponent overflow
            if (exponent == 0x7f800000 && significand != 0) {
                // NaN
                significand >>= 13
                if (significand == 0) {
                    return 0x7c01
                }
                return sign | 0x7c00 | UInt16(significand)
            }
            // Inf
            return sign | 0x7c00
        }

        // Nominal (must sum for correct rounding)
        exponent -= 0x38000000
        significand += 0x00001000
        return sign + UInt16(exponent >> 13) + UInt16(significand >> 13)
    }
}
