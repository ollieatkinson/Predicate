import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UserPredicateTests.allTests),
        testCase(DogPredicateTests.allTests)
    ]
}
#endif