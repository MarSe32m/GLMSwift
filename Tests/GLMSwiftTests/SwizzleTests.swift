import XCTest
import GLMSwift

class SwizzleTests: XCTestCase {

    func test1() {
        var a = vec2(1, 2)
        XCTAssertEqual(a.yx, vec2(2, 1))
        a.yx = vec2(5, 4)
        XCTAssertEqual(a, vec2(4, 5))
        XCTAssertEqual(a.xy, vec2(4, 5))
    }

    func test2() {
        var z = vec4(1, 2, 3, 4)
        z.ab = vec2(99, 98)
        XCTAssertEqual(z.ab, vec2(99, 98))
        XCTAssertEqual(z, vec4(1, 2, 98, 99))
    }

    static var allTests = [
        ("test1", test1),
        ("test2", test2)
    ]
}
