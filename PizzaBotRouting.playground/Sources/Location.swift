import Foundation

public struct Location: Equatable {
    var x: Int
    var y: Int
    var distance: Double = 0.0

    public var tupleOutput: String {
        return "(\(x), \(y))"
    }

    public static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public func isWithinDeliveryZone(map: DeliveryMap) -> Bool {
        if (x < 0 || x > map.grid.width) {
            return false
        }
        if (y < 0 || y > map.grid.height) {
            return false
        }
        return true
    }
}

extension Location {

    static var startPoint: Location {
        return Location(x: 0, y: 0)
    }
}
