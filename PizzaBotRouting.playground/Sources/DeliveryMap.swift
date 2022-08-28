import Foundation

public struct DeliveryMap {
    let width: Int
    let height: Int
    public var dropPoints: [Location]

    public init(width: Int, height: Int, dropPoints: [Location]) {
        self.width = width
        self.height = height
        self.dropPoints = dropPoints
    }

    var gridSize: String {
        return "\(width)x\(height)"
    }
}

extension DeliveryMap {
    static var empty: DeliveryMap {
        return DeliveryMap(width: 0, height: 0, dropPoints: [])
    }
}
