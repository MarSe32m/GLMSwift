import XCTest
import GLMSwift

class Vector4Tests: XCTestCase {

    func testInit() {
        let v1 = vec4(1, 2, 3, 4)
        let v2 = vec4(vec2(1, 2), 3, 4)
        let v3 = vec4(1, vec2(2, 3), 4)
        let v4 = vec4(1, 2, vec2(3, 4))
        let v5 = vec4(vec2(1, 2), vec2(3, 4))

        XCTAssertEqual(v1, v2)
        XCTAssertEqual(v1, v3)
        XCTAssertEqual(v1, v4)
        XCTAssertEqual(v1, v5)
    }

    func testAddFloat() {
        let v1 = vec4(1, 2, 3, 4)
        let v2 = vec4(10, 20, 30, 40)
        let v3 = vec4(11, 22, 33, 44)
        XCTAssertEqual(v1+v2, v3)
    }

    func testAddInt() {
        let v1 = ivec4(1, 2, 3, 4)
        let v2 = ivec4(10, 20, 30, 40)
        let v3 = ivec4(11, 22, 33, 44)
        XCTAssertEqual(v1&+v2, v3)
    }

    func testSubFloat() {
        let v1 = vec4(1, 2, 3, 4)
        let v2 = vec4(10, 20, 30, 40)
        let v3 = vec4(-9, -18, -27, -36)
        XCTAssertEqual(v1-v2, v3)
    }

    func testSubInt() {
        let v1 = ivec4(1, 2, 3, 4)
        let v2 = ivec4(10, 20, 30, 40)
        let v3 = ivec4(-9, -18, -27, -36)
        XCTAssertEqual(v1&-v2, v3)
    }

    func testMulFloat() {
        let v1 = vec4(2, 3, 4, 5)
        let v2 = vec4(10, 20, 30, 40)
        let v3 = vec4(20, 60, 120, 200)
        XCTAssertEqual(v1*v2, v3)
        let v4 = vec4(4, 6, 8, 10)
        XCTAssertEqual(v1*2, v4)
    }

    func testMulInt() {
        let v1 = ivec4(2, 3, 4, 5)
        let v2 = ivec4(10, 20, 30, 40)

        let v3 = ivec4(20, 60, 120, 200)
        XCTAssertEqual(v1&*v2, v3)

        let v4 = ivec4(6, 9, 12, 15)
        XCTAssertEqual(3 &* v1, v4)
    }

    func testMulUInt() {
        let v1 = uvec4(2, 3, 4, 5)
        let v2 = uvec4(10, 20, 30, 40)

        let v3 = uvec4(20, 60, 120, 200)
        XCTAssertEqual(v1&*v2, v3)

        let v4 = uvec4(6, 9, 12, 15)
        XCTAssertEqual(3 &* v1, v4)
    }

    func testDivFloat() {
        let v1 = vec4(20, 60, 120, 200)
        let v2 = vec4(2, 3, 4, 5)
        let v3 = vec4(10, 20, 30, 40)
        XCTAssertEqual(v1/v2, v3)
    }

    func testDivInt() {
        let v1 = ivec4(20, 60, 120, 200)
        let v2 = ivec4(2, 3, 4, 5)
        let v3 = ivec4(10, 20, 30, 40)
        XCTAssertEqual(v1/v2, v3)
    }

    static var allTests = [
        ("testInit", testInit),
        ("testAddFloat", testAddFloat),
        ("testAddInt", testAddInt),
        ("testSubFloat", testSubFloat),
        ("testSubInt", testSubInt),
        ("testMulFloat", testMulFloat),
        ("testMulInt", testMulInt),
        ("testMulUInt", testMulUInt),
        ("testDivFloat", testDivFloat),
        ("testDivInt", testDivInt)
    ]
}
