import XCTest
import GLMSwift

class Vector2Tests: XCTestCase {

    func test1() {
        let a = vec2(1.0)
        let b = vec2(1.0)
        let c = vec2(2.0)
        XCTAssertEqual(a, b)
        XCTAssertNotEqual(a, c)
    }

    func test2() {
        var a = vec2(1)
        let b = a + 1
        a += 1
        XCTAssertEqual(a.x, 2)
        XCTAssertEqual(a.y, 2)
        XCTAssertEqual(a.x, b.x)
        XCTAssertEqual(a.y, b.y)
    }

    func test3() {
        let a = ivec2(1)
        let b = ivec2(1)
        let c = ivec2(2)
        XCTAssertEqual(a, b)
        XCTAssertNotEqual(a, c)
    }

    static var allTests = [
        ("test1", test1),
        ("test2", test2),
        ("test3", test3)
    ]
}
