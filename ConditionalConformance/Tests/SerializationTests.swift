
//  Created by Todd Kramer on 4/22/18.
//  Copyright © 2018 Todd Kramer. All rights reserved.

import XCTest
import ConditionalConformance

protocol TestEquatable: Codable {

    func assertIsEqual(to other: Self)

}

extension Array: TestEquatable where Element: TestEquatable {

    func assertIsEqual(to other: [Element]) {
        guard count == other.count else { return XCTFail() }
        zip(self, other).forEach { $0.0.assertIsEqual(to: $0.1) }
    }

}

extension Park: TestEquatable {

    func assertIsEqual(to other: Park) {
        XCTAssertEqual(id, other.id)
        XCTAssertEqual(name, other.name)
        XCTAssertEqual(location, other.location)
    }

}

protocol TestRepresentable {

    func evaluate()

}

struct SerializationTest<T: TestEquatable>: TestRepresentable {

    let filename: String
    let expected: T

    func evaluate() {
        let url = Bundle(for: SerializationTests.self).url(forResource: filename, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let model = try! JSONDecoder().decode(T.self, from: data)
        model.assertIsEqual(to: expected)
    }

}

class SerializationTests: XCTestCase {
    
    func testSerialization() {
        let acadia = Park(id: "1", name: "Acadia", location: "Maine")
        let yosemite = Park(id: "2", name: "Yosemite", location: "California")
        let zion = Park(id: "3", name: "Zion", location: "Utah")
        let parkShow = SerializationTest(filename: "Park_show", expected: acadia)
        let parkIndex = SerializationTest(filename: "Park_index", expected: [acadia, yosemite, zion])
        let cases: [TestRepresentable] = [parkShow, parkIndex]
        cases.forEach { $0.evaluate() }
    }
    
}
