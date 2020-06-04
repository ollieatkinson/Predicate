import XCTest
import Predicate

struct User: Hashable {
    let name: String
    let age: Int
    let weight: Float
    let isClearToFly: Bool
}

extension Sequence where Element: Hashable {
    var set: Set<Element> { .init(self) }
}

final class PredicateTests: XCTestCase {
    
    private var sut: [User]!
    
    override func setUp() {
        super.setUp()
        
        let Milos = User(name: "Milos", age: 32, weight: 78.2, isClearToFly: true)
        let Noah = User(name: "Noah", age: 38, weight: 82.1, isClearToFly: false)
        let Ste = User(name: "Ste", age: 36, weight: 85.8, isClearToFly: false)
        
        sut = [ Milos, Noah, Ste ]
        
    }
    
    public func XCTAssertUsersEqual<S>(
        _ expression1: @autoclosure () throws -> S,
        _ expression2: String...,
        message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) rethrows where S: Sequence, S.Element == User {
        try XCTAssertUsersEqual(try expression1(), Array(expression2), message(), file: file, line: line)
    }
    
    public func XCTAssertUsersEqual<S>(
        _ expression1: @autoclosure () throws -> S,
        _ expression2: @autoclosure () throws -> [String],
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) rethrows where S: Sequence, S.Element == User {
        XCTAssertEqual(try expression1().map(\.name), Array(try expression2()), message(), file: file, line: line)
    }
    
    func test_filter_string_equal() {
        XCTAssertUsersEqual(sut.filter(\.name == "Milos"), "Milos")
    }
    
    func test_filter_string_notEqual() {
        XCTAssertUsersEqual(sut.filter(\.name != "Milos"), "Noah", "Ste")
    }
    
    func test_filter_intComparison() {
        XCTAssertUsersEqual(sut.filter(\.age > 33), "Noah", "Ste")
        XCTAssertUsersEqual(sut.filter(\.age >= 36), "Noah", "Ste")
    }
    
    func test_filter_floatComparison() {
        XCTAssertUsersEqual(sut.filter(\.weight < 85), "Milos", "Noah")
        XCTAssertUsersEqual(sut.filter(\.weight <= 82.1), "Milos", "Noah")
    }
    
    func test_filter_float_equals_with_accuracy() {
        XCTAssertUsersEqual(sut.filter(\.weight == 85 ± 4), "Noah", "Ste")
        XCTAssertUsersEqual(sut.filter(\.weight == 82.1 ± 3), "Noah")
    }
    
    func test_filter_included_range() {
        XCTAssertUsersEqual(sut.filter(\.age << (30...35)), "Milos")
    }
    
    func test_filter_included_array() {
        XCTAssertUsersEqual(sut.filter(\.age << [ 30, 32, 34 ]), "Milos")
    }
    
    func test_filter_float() {
        XCTAssertUsersEqual(sut.filter(\.weight == 78.2), "Milos")
    }
    
    func test_filter_boolean() {
        XCTAssertUsersEqual(sut.filter(\.isClearToFly == false), [ "Noah", "Ste" ])
        XCTAssertUsersEqual(sut.filter(\.isClearToFly), [ "Milos" ])
        XCTAssertUsersEqual(sut.filter(!\.isClearToFly), [ "Noah", "Ste" ])
    }
    
    func test_filter_and() {
        XCTAssertUsersEqual(sut.filter(!\.isClearToFly && \.name == "Noah"), "Noah")
    }
    
    func test_filter_or() {
        XCTAssertUsersEqual(sut.filter(!\.isClearToFly || \.name == "Milos"), "Milos", "Noah", "Ste")
    }
    
    func test_filter_not() {
        XCTAssertUsersEqual(sut.filter(!\.isClearToFly), "Noah", "Ste")
    }
    
    func test_filter_chain() {
        XCTAssertUsersEqual(sut.filter(!\.isClearToFly).filter(\.name == "Noah"), "Noah")
    }

    func test_filter_regex() {
        XCTAssertUsersEqual(sut.filter(\.name ~= "o(s|ah)$"), "Milos", "Noah")
    }
    
    func test_filter_regexCaseInsensitive() {
        XCTAssertUsersEqual(sut.filter(\.name ~= Regex(pattern: "O(S|AH)$", options: .caseInsensitive)), "Milos", "Noah")
    }
    
    func test_prefixWhile() {
        XCTAssertUsersEqual(sut.prefix(while: \.weight < 85), "Milos", "Noah")
    }
    
    func test_dropWhile() {
        XCTAssertUsersEqual(sut.drop(while: \.age < 35), "Noah", "Ste")
    }

    func test_first() {
        XCTAssertEqual(sut.first(where: !\.isClearToFly)?.name, "Noah")
    }

    func test_contains_true() {
        XCTAssertTrue(sut.contains(where: \.weight < 85))
    }

    func test_contains_false() {
        XCTAssertFalse(sut.contains(where: \.weight > 185))
    }

    func test_allSatisfy_true() {
        XCTAssertTrue(sut.allSatisfy(\.age > 20))
    }

    func test_allSatisfy_false() {
        XCTAssertFalse(sut.allSatisfy(\.age > 35))
    }
    
}
