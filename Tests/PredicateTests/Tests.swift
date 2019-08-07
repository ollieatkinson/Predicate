import XCTest
import Predicate

struct User {
    let name: String
    let age: Int
    let weight: Float
    let isClearToFly: Bool
}

final class PredicateTests: XCTestCase {
    
    private var allUsers: [User]!
    
    override func setUp() {
        super.setUp()
        
        let bob = User(name: "Bob", age: 32, weight: 78.2, isClearToFly: true)
        let rob = User(name: "Rob", age: 38, weight: 82.1, isClearToFly: false)
        let dan = User(name: "Dan", age: 36, weight: 85.8, isClearToFly: false)
        
        allUsers = [ bob, rob, dan ]
        
    }
    
    func test_filter_string_equal() {
        
        let result = allUsers.filter(\.name == "Bob")
        
        XCTAssertEqual(result.count, 1) // Bob
        XCTAssertEqual(result[0].name, "Bob") // Bob
    }
    
    func test_filter_string_notEqual() {
        
        let result = allUsers.filter(\.name != "Bob")
        
        XCTAssertEqual(result.count, 2) // Rob, Dan
        
        XCTAssertEqual(result[0].name, "Rob") // Rob
        XCTAssertEqual(result[1].name, "Dan") // Dan
        
    }
    
    func test_filter_intComparison() {
        XCTAssertEqual(allUsers.filter(\.age > 33).count, 2) // Rob, Dan
        XCTAssertEqual(allUsers.filter(\.age >= 36).count, 2) // Rob, Dan
    }
    
    func test_filter_floatComparison() {
        XCTAssertEqual(allUsers.filter(\.weight < 85).count, 2) // Bob, Rob
        XCTAssertEqual(allUsers.filter(\.weight <= 82.1).count, 2) // Bob, Rob
    }
    
    func test_filter_included_range() {
        XCTAssertEqual(allUsers.filter(\.age << (30...35)).count, 1) // Bob
    }
    
    func test_filter_included_array() {
        XCTAssertEqual(allUsers.filter(\.age << [ 30, 32, 34 ]).count, 1) // Bob
    }
    
    func test_filter_float() {
        XCTAssertEqual(allUsers.filter(\.weight == 78.2).count, 1) // Bob
    }
    
    func test_filter_boolean() {
        XCTAssertEqual(allUsers.filter(\.isClearToFly == false).count, 2) // Rob, Dan
    }
    
    func test_filter_and() {
        XCTAssertEqual(allUsers.filter(\.isClearToFly == false && \.name == "Rob").count, 1) // Rob
    }
    
    func test_filter_or() {
        XCTAssertEqual(allUsers.filter(\.isClearToFly == false || \.name == "Bob").count, 3) // Bob, Rob, Dan
    }
    
    func test_filter_not() {
        
        let isUserClearToFlyPredicate = \User.isClearToFly == true
        
        XCTAssertEqual(allUsers.filter(isUserClearToFlyPredicate.not).count, 2) // Rob, Dan
        XCTAssertEqual(allUsers.filter(!isUserClearToFlyPredicate).count, 2) // Rob, Dan
        
    }
    
    func test_filter_chain() {
        XCTAssertEqual(allUsers.filter(\.isClearToFly == false).filter(\.name == "Rob").count, 1) // Rob
    }
    
    func test_filter_usingKeyPathPartialPredicate() {
        
        let partialPredicate = KeyPathPartialPredicate(keyPath: \User.name)
        let predicate = partialPredicate.equal(value: "Bob")
        
        XCTAssertEqual(allUsers.filter(predicate).count, 1) // Bob
        
    }
    
    func test_filter_regex() {
        XCTAssertEqual(allUsers.filter(\.name ~= "ob$").count, 2) // Bob, Rob
    }
    
    func test_filter_regexCaseInsensitive() {
        XCTAssertEqual(allUsers.filter(\.name ~= Regex(pattern: "OB$", options: .caseInsensitive)).count, 2) // Bob, Rob
    }
    
    func test_prefixWhile() {
        
        let result = allUsers.prefix(while: \.weight < 85)
        
        XCTAssertEqual(result.count, 2) // Bob, Rob
        XCTAssertEqual(result[result.startIndex].name, "Bob")
        XCTAssertEqual(result[result.startIndex + 1].name, "Rob")
        
    }
    
    func test_dropWhile() {
        
        let result = Array(allUsers.drop(while: \.age < 35))
        
        XCTAssertEqual(result.count, 2) // Rob, Dan
        XCTAssertEqual(result[result.startIndex].name, "Rob")
        XCTAssertEqual(result[result.startIndex + 1].name, "Dan")
        
    }

    func test_first() {

        let result = allUsers.first(where: \.isClearToFly == false) // Rob, Dan

        XCTAssertEqual(result?.name, "Rob") // Rob
    }

    func test_contains_true() {

        let result = allUsers.contains(where: \.weight < 85)

        XCTAssertTrue(result)

    }

    func test_contains_false() {

        let result = allUsers.contains(where: \.weight > 185)

        XCTAssertFalse(result)

    }

    func test_allSatisfy_true() {

        let result = allUsers.allSatisfy(\.age > 20)

        XCTAssertTrue(result)

    }

    func test_allSatisfy_false() {

        let result = allUsers.allSatisfy(\.age > 35)

        XCTAssertFalse(result)

    }
    
    static var allTests = [
        ("test_filter_string_equal", test_filter_string_equal),
        ("test_filter_string_notEqual", test_filter_string_notEqual),
        ("test_filter_intComparison", test_filter_intComparison),
        ("test_filter_floatComparison", test_filter_floatComparison),
        ("test_filter_included_range", test_filter_included_range),
        ("test_filter_included_array", test_filter_included_array),
        ("test_filter_float", test_filter_float),
        ("test_filter_boolean", test_filter_boolean),
        ("test_filter_and", test_filter_and),
        ("test_filter_or", test_filter_or),
        ("test_filter_not", test_filter_not),
        ("test_filter_chain", test_filter_chain),
        ("test_filter_regex", test_filter_regex),
        ("test_filter_usingKeyPathPartialPredicate", test_filter_usingKeyPathPartialPredicate),
        ("test_filter_regexCaseInsensitive", test_filter_regexCaseInsensitive),
        ("test_prefixWhile", test_prefixWhile),
        ("test_dropWhile", test_dropWhile),
        ("test_first", test_first),
        ("test_contains_true", test_contains_true),
        ("test_contains_false", test_contains_false),
        ("test_allSatisfy_true", test_allSatisfy_true),
        ("test_allSatisfy_false", test_allSatisfy_false),
    ]
    
}
