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
        ("test_filter_regexCaseInsensitive", test_filter_regexCaseInsensitive),
    ]
    
}
