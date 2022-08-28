import Foundation

public struct DeliveryMap {
    let grid: Grid
    public var dropPoints: [Location]

    public init(grid: Grid, dropPoints: [Location]) {
        self.grid = grid
        self.dropPoints = dropPoints
    }
}

extension DeliveryMap {
    static var empty: DeliveryMap {
        return DeliveryMap(grid: Grid.empty, dropPoints: [])
    }
}
