import Foundation

public struct LocationFactory {

    public static func generateLocations(amount: Int, maxRange: Int) -> [Location] {
        var locations: [Location] = []
        for _ in 0..<amount {
            let location = Location(x: Int.random(in: 0..<maxRange),
                                    y: Int.random(in: 0..<maxRange))
            locations.append(location)
        }
        return locations
    }
}
