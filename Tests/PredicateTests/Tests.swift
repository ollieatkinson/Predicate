import XCTest

@testable import Predicate

final class UserPredicateTests: XCTestCase {
    
    struct User {
        let name: String
        let age: Int
    }
    
    private var allUsers: [User]!
    
    override func setUp() {
        super.setUp()
        
        let bob = User(name: "Bob", age: 32)
        let rob = User(name: "Rob", age: 38)
        let dan = User(name: "Dan", age: 36)
        
        allUsers = [ bob, rob, dan ]
        
    }
    
    func test_filter_name() {
        XCTAssertEqual(allUsers.filter(\User.name == "Bob").count, 1) // Bob
    }
    
    func test_filter_ageOver35() {
        XCTAssertEqual(allUsers.filter(\User.age > 35).count, 2) // Rob, Dan
    }

    static var allTests = [
        ("test_filter_name", test_filter_name),
        ("test_filter_ageOver35", test_filter_ageOver35)
    ]
    
}

final class DogPredicateTests: XCTestCase {

    struct Dog {
        let age: Int
        let name: String
        let vaccinated: Bool
    }

    struct Person {
        let age: Int
        let birthday: Date
        let image: Data
        let name: String
        let nickname: String
        let weight: Float
        let dogs: [Dog]
    }
    
    func test_filter() {
        XCTAssertTrue(true)
    }

    static var allTests = [
        ("test_filter", test_filter)
    ]

}

