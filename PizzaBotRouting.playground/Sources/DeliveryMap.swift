import Foundation

public struct DeliveryMap {
    public let grid: Grid
    public var dropPoints: [Location]

    public init(grid: Grid, dropPoints: [Location]) {
        self.grid = grid
        self.dropPoints = dropPoints
    }

    public func isLocationWithinDeliveryZone(_ location: Location) -> Bool {
        if (location.x < 0 || location.x > grid.width) {
            return false
        }
        if (location.y < 0 || location.y > grid.height) {
            return false
        }
        return true
    }
}

extension DeliveryMap {
    static var empty: DeliveryMap {
        return DeliveryMap(grid: Grid.empty, dropPoints: [])
    }
}
