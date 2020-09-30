import XCTest
import GLMSwift

class SwiftGLglmTests: XCTestCase {

    func testGenericLink() {
        // Nothing asserts here.
        // Just making sure the generics will link.

        let m4 = mat4()
        let v2 = vec2(1)
        let v3 = vec3()
        let v4 = vec4()

        _ = GLMSwift.translate(m4, v3)
        _ = GLMSwift.rotate(m4, 1.1, v3)
        _ = GLMSwift.rotateSlow(m4, 1.1, v3)
        _ = GLMSwift.scale(m4, v3)

        _ = GLMSwift.ortho(1, 2, 3, 4, 5, 6)
        _ = GLMSwift.ortho(1, 2, 3, 4)
        _ = GLMSwift.orthoLH(1, 2, 3, 4, 5, 6)
        _ = GLMSwift.orthoRH(1, 2, 3, 4, 5, 6)

        _ = GLMSwift.frustum(1, 2, 3, 4, 5, 6)
        _ = GLMSwift.frustumLH(1, 2, 3, 4, 5, 6)
        _ = GLMSwift.frustumRH(1, 2, 3, 4, 5, 6)

        _ = GLMSwift.perspective(1, 2, 3, 4)
        _ = GLMSwift.perspectiveLH(1, 2, 3, 4)
        _ = GLMSwift.perspectiveRH(1, 2, 3, 4)

        _ = GLMSwift.perspectiveFov(1, 2, 3, 4, 5)
        _ = GLMSwift.perspectiveFovLH(1, 2, 3, 4, 5)
        _ = GLMSwift.perspectiveFovRH(1, 2, 3, 4, 5)

        _ = GLMSwift.infinitePerspective(1, 2, 3)
        _ = GLMSwift.infinitePerspectiveLH(1, 2, 3)
        _ = GLMSwift.infinitePerspectiveRH(1, 2, 3)

        _ = GLMSwift.project(v3, m4, m4, v4)
        _ = GLMSwift.unproject(v3, m4, m4, v4)
        _ = GLMSwift.pickMatrix(v2, v2, v4)

        _ = GLMSwift.lookAt(v3, v3, v3)
        _ = GLMSwift.lookAtLH(v3, v3, v3)
        _ = GLMSwift.lookAtRH(v3, v3, v3)
    }

}
