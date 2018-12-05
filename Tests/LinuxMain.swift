import XCTest

import Predicate_swiftTests

var tests = [XCTestCaseEntry]()
tests += UserPredicateTests.allTests()
tests += DogPredicateTests.allTests()
XCTMain(tests)