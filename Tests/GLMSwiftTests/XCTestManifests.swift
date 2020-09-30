#if !canImport(ObjectiveC)
import XCTest

extension FunctionsTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FunctionsTests = [
        ("testIsNanIsInf", testIsNanIsInf),
        ("testPackDouble", testPackDouble),
        ("testPackHalf", testPackHalf),
        ("testPackNorm", testPackNorm),
    ]
}

extension Matrix2x2Tests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Matrix2x2Tests = [
        ("testCommmonInits", testCommmonInits),
        ("testDivide", testDivide),
        ("testIdentityInits", testIdentityInits),
        ("testMultiplyInverse", testMultiplyInverse),
        ("testMultiplyVector", testMultiplyVector),
    ]
}

extension Matrix3x3Tests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Matrix3x3Tests = [
        ("testCommmonInits", testCommmonInits),
        ("testDivide", testDivide),
        ("testIdentityInits", testIdentityInits),
        ("testMultiplyInverse", testMultiplyInverse),
        ("testMultiplyVector", testMultiplyVector),
    ]
}

extension Matrix4x4Tests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Matrix4x4Tests = [
        ("testCommmonInits", testCommmonInits),
        ("testDivide", testDivide),
        ("testIdentityInits", testIdentityInits),
        ("testMultiArray", testMultiArray),
        ("testMultiplyInverse", testMultiplyInverse),
        ("testMultiplyVector", testMultiplyVector),
        ("testMultiplyWith2x4", testMultiplyWith2x4),
    ]
}

extension SwiftGLglmTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwiftGLglmTests = [
        ("testGenericLink", testGenericLink),
    ]
}

extension SwizzleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SwizzleTests = [
        ("test1", test1),
        ("test2", test2),
    ]
}

extension Vector2Tests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Vector2Tests = [
        ("test1", test1),
        ("test2", test2),
        ("test3", test3),
    ]
}

extension Vector4Tests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Vector4Tests = [
        ("testAddFloat", testAddFloat),
        ("testAddInt", testAddInt),
        ("testDivFloat", testDivFloat),
        ("testDivInt", testDivInt),
        ("testInit", testInit),
        ("testMulFloat", testMulFloat),
        ("testMulInt", testMulInt),
        ("testMulUInt", testMulUInt),
        ("testSubFloat", testSubFloat),
        ("testSubInt", testSubInt),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FunctionsTests.__allTests__FunctionsTests),
        testCase(Matrix2x2Tests.__allTests__Matrix2x2Tests),
        testCase(Matrix3x3Tests.__allTests__Matrix3x3Tests),
        testCase(Matrix4x4Tests.__allTests__Matrix4x4Tests),
        testCase(SwiftGLglmTests.__allTests__SwiftGLglmTests),
        testCase(SwizzleTests.__allTests__SwizzleTests),
        testCase(Vector2Tests.__allTests__Vector2Tests),
        testCase(Vector4Tests.__allTests__Vector4Tests),
    ]
}
#endif
