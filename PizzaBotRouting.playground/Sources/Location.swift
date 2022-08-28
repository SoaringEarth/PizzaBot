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
}

extension Location {

    static var startPoint: Location {
        return Location(x: 0, y: 0)
    }
}
