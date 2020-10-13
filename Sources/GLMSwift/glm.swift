import func Foundation.sin
import func Foundation.cos
import func Foundation.tan

public struct GLMSwift {
    public static func translation<T: FloatingPoint>(vector: Vector3<T>) -> Matrix4<T> {
        translation(vector)
    }

    public static func translation<T: FloatingPoint>(_ v: Vector3<T>) -> Matrix4<T> {
        Matrix4<T>(1, 0, 0, v.x, 0, 1, 0, v.y, 0, 0, 1, v.z, 0, 0, 0, 1)
    }

    public static func rotation<T: BinaryFloatingPoint>(angle: T, axis: Vector3<T>) -> Matrix4<T> {
        rotation(angle, axis)
    }

    public static func rotation<T: BinaryFloatingPoint>(_ angle: T, _ v: Vector3<T>) -> Matrix4<T> {
        let a = angle
        let cosine = T(cos(Double(a)))
        let sine = T(sin(Double(a)))
        let axis = v.normalized
        let temp = (1 - cosine) * axis

        let r00: T = cosine + temp.x * axis.x
        let r01: T = temp.y * axis.x - sine * axis.z
        let r02: T = temp.z * axis.x + sine * axis.y

        let r10: T = temp.x * axis.y + sine * axis.z
        let r11: T = cosine + temp.y * axis.y
        let r12: T = temp.z * axis.y - sine * axis.x

        let r20: T = temp.x * axis.z - sine * axis.y
        let r21: T = temp.y * axis.z + sine * axis.x
        let r22: T = cosine + temp.z * axis.z

        return Matrix4<T>(r00, r01, r02, 0,
                          r10, r11, r12, 0,
                          r20, r21, r22, 0,
                          0,     0,   0, 1)
    }

    public static func scale<T: FloatingPoint>(xScale: T, yScale: T, zScale: T) -> Matrix4<T> {
        scale(Vector3<T>(xScale, yScale, zScale))
    }

    public static func scale<T>(_ v: Vector3<T>) -> Matrix4<T> {
        Matrix4<T>(v.x, 0, 0, 0, 0, v.y, 0, 0,0, 0, v.z, 0,0, 0, 0, 1)
    }

    public static func ortho<T: BinaryFloatingPoint>(left: T, right: T, bottom: T, top: T, zNear: T = -1.0, zFar: T = 1.0) -> Matrix4<T> {
        ortho(left, right, bottom, top, zNear, zFar)
    }

    public static func ortho<T: BinaryFloatingPoint>(_ left: T, _ right: T, _ bottom: T, _ top: T, _ zNear: T = -1.0, _ zFar: T = 1.0) -> Matrix4<T> {
        let r00: T = 2 / (right - left)
        let r11: T = 2 / (top - bottom)
        let r22: T = -2 / (zFar - zNear)
        
        let r03: T = -(right + left) / (right - left)
        let r13: T = -(top + bottom) / (top - bottom)
        let r23: T = -(zFar + zNear) / (zFar - zNear)

        return Matrix4<T>(r00, 0,   0,   r03,
                          0, r11,   0,   r13,
                          0,   0, r22,   r23,
                          0,   0,   0,   1)
    }

    public static func orthoInverse<T: BinaryFloatingPoint>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T) -> Matrix4<T> {
        orthoInverse(left, right, bottom, top, zNear, zFar)
    }

    public static func orthoInverse<T: BinaryFloatingPoint>(_ left: T, _ right: T, _ bottom: T, _ top: T, _ zNear: T, _ zFar: T) -> Matrix4<T> {
        let r00: T = (right - left) / 2
        let r11: T = (top - bottom) / 2
        let r22: T = -(top - bottom) / 2

        let r03: T = (left + right) / 2
        let r13: T = (top + bottom) / 2
        let r23: T = -(zFar + zNear) / 2

        return Matrix4<T>(r00, 0,   0,  r03,
                          0, r11,   0,  r13,
                          0,   0, r22,  r23,
                          0,   0,   0,  1)
    }

    public static func frustum<T: BinaryFloatingPoint>(left: T, right: T, bottom: T, top: T, nearVal: T, farVal: T) -> Matrix4<T> {
        frustum(left, right, bottom, top, nearVal, farVal)
    }

    public static func frustum<T: BinaryFloatingPoint>(_ left: T, _ right: T, _ bottom: T, _ top: T, _ nearVal: T, _ farVal: T) -> Matrix4<T> {
        let r00: T = (2 * nearVal) / (right - left)
        let r11: T = (2 * nearVal) / (top - bottom)
        let r02: T = (right + left) / (right - left)
        let r12: T = (top + bottom) / (top - bottom)
        let r22: T = -(farVal + nearVal) / (farVal - nearVal)
        let r23: T = -(2 * farVal * nearVal) / (farVal - nearVal)

        return Matrix4<T>(r00, 0, r02, 0,
                          0, r11, r12, 0,
                          0,   0, r22, r23,
                          0,   0,  -1, 0)
    }

    public static func perspective<T: BinaryFloatingPoint>(fov: T, aspectRatio: T, zNear: T, zFar: T) -> Matrix4<T> {
        perspective(fov, aspectRatio, zNear, zFar)
    }

    public static func perspective<T: BinaryFloatingPoint>(_ fov: T, _ aspectRatio: T, _ zNear: T, _ zFar: T) -> Matrix4<T> {
        assert(aspectRatio > 0)
        let tanHalfFov = T(tan(Double(fov/2)))

        let r00: T = 1 / (aspectRatio * tanHalfFov)
        let r11: T = 1 / tanHalfFov

        let r22: T = -(zFar + zNear) / (zFar - zNear)
        let r23: T = -(2 * zFar * zNear) / (zFar - zNear)

        return Matrix4<T>(r00, 0, 0, 0,
                          0, r11, 0, 0,
                          0, 0, r22, r23,
                          0, 0,  -1, 0)
    }

    public static func perspectiveFov<T: BinaryFloatingPoint>(fov: T, width: T, height: T, zNear: T, zFar: T) -> Matrix4<T> {
        perspectiveFov(fov, width, height, zNear, zFar)
    }

    public static func perspectiveFov<T: BinaryFloatingPoint>(_ fov: T, _ width: T, _ height: T, _ zNear: T, _ zFar: T) -> Matrix4<T> {
        assert(fov > 0)
        assert(width > 0)
        assert(height > 0)
        let aspectRatio = width / height
        return perspective(fov, aspectRatio, zNear, zFar)
    }

    public static func lookAtRH<T: BinaryFloatingPoint>(_ eye: Vector3<T>, _ center: Vector3<T>, _ up: Vector3<T>) -> Matrix4<T> {
        let f: Vector3<T> = (center - eye).normalized
        let s: Vector3<T> = (f.cross(up)).normalized
        let u: Vector3<T> = s.cross(f)

        let r03: T = -s.dot(eye)
        let r13: T = -u.dot(eye)
        let r23: T = f.dot(eye)

        return Matrix4<T>(s.x, s.y, s.z, r03,
                          u.x, u.y, u.z, r13,
                          -f.x, -f.y, -f.z, r23,
                             0,    0,    0,  1)
    }

/*
    public static func project<T>
        (_ obj: Vector3<T>, _ model: Matrix4x4<T>, _ proj: Matrix4x4<T>, _ viewport: Vector4<T>) -> Vector3<T> {
        var tmp = Vector4<T>(obj, 1)
        tmp = model * tmp
        tmp = proj * tmp
        tmp /= tmp.w
        tmp = tmp * T(0.5)
        tmp += T(0.5)
        tmp[0] = tmp[0] * viewport[2] + viewport[0]
        tmp[1] = tmp[1] * viewport[3] + viewport[1]
        return Vector3<T>(tmp)
    }

    public static func unproject<T>
        (_ win: Vector3<T>, _ model: Matrix4x4<T>, _ proj: Matrix4x4<T>, _ viewport: Vector4<T>) -> Vector3<T> {
        var tmp: Vector4<T> = Vector4<T>(win, 1)
        tmp.x = (tmp.x - viewport[0]) / viewport[2]
        tmp.y = (tmp.y - viewport[1]) / viewport[3]
        tmp = tmp * 2
        tmp -= 1
        let inv = (proj * model).inverse
        var obj = inv * tmp
        obj /= obj.w
        return Vector3<T>(obj)
    }

    public static func pickMatrix<T>
        (_ center: Vector2<T>, _ delta: Vector2<T>, _ viewport: Vector4<T>) -> Matrix4x4<T> {
        assert(delta.x > 0 && delta.y > 0)

        var tmpx: T = viewport[2] - 2 * (center.x - viewport[0])
        tmpx /= delta.x
        var tmpy: T = viewport[3] - 2 * (center.y - viewport[1])
        tmpy /= delta.y

        let trans: Vector3<T> = Vector3<T>(tmpx, tmpy, 0)
        let scal: Vector3<T> = Vector3<T>(
            viewport[2] / delta.x,
            viewport[3] / delta.y,
            1
        )
        return scale(translate(Matrix4x4<T>(), trans), scal)
    }
    */
}
