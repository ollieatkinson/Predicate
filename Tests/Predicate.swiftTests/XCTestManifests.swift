import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Predicate_swiftTests.allTests),
    ]
}
#endif