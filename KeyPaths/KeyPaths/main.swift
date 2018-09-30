
//  Copyright © 2018 Todd Kramer. All rights reserved.

import Foundation

struct City: Hashable {

    let name: String
    let country: String
    let population: Int

}

let beijing = City(name: "Beijing", country: "China", population: 21_707_000)
let buenosAires = City(name: "Buenos Aires", country: "Argentina", population: 3_054_300)
let london = City(name: "London", country: "United Kingdom", population: 8_825_001)
let losAngeles = City(name: "Los Angeles", country: "United States", population: 3_976_322)
let mexicoCity = City(name: "Mexico City", country: "Mexico", population: 8_875_000)
let nairobi = City(name: "Nairobi", country: "Kenya", population: 3_138_369)
let newYork = City(name: "New York", country: "United States", population: 8_443_675)
let shanghai = City(name: "Shanghai", country: "China", population: 24_183_300)


let cities = [beijing, buenosAires, london, losAngeles, mexicoCity, nairobi, newYork, shanghai]

extension Array {

    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, isAscending: Bool = true) -> [Element] {
        return sorted {
            let lhs = $0[keyPath: keyPath]
            let rhs = $1[keyPath: keyPath]
            return isAscending ? lhs < rhs : lhs > rhs
        }
    }

    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }

}

let mostPopulousCities = cities.sorted(by: \.population, isAscending: false).map(\.name)
print(mostPopulousCities)

let reverseAlphabeticalCities = cities.sorted(by: \.name, isAscending: false).map(\.name)
print(reverseAlphabeticalCities)

let citiesGroupedByCountry = cities.sorted(by: \.country).map(\.name)
print(citiesGroupedByCountry)
