import Foundation

public protocol Optimiser {
    func optimiseRoute(_ locations: [Location]) -> [Location]
}

public struct RouteOptimiser: Optimiser {

    public init() {}
    
    public func optimiseRoute(_ locations: [Location]) -> [Location] {
        func calculateDistance(start: Location, end: Location) -> Double {
            let dX = Double(end.x - start.x)
            let dY = Double(end.y - start.y)
            let sqrX = sqrt(dX)
            let sqrY = sqrt(dY)
            let distance = sqrt((sqrX + sqrY))
            return distance
        }

        var tmp: [Location] = []
        for location in locations {
            var tmpLocation = location
            tmpLocation.distance = calculateDistance(start: Location.startPoint,
                                                     end: location)
            tmp.append(tmpLocation)
        }
        return tmp.sorted(by: { $0.distance < $1.distance })
    }
}

public struct Mock_RouteOptimiser: Optimiser {

    public func optimiseRoute(_ locations: [Location]) -> [Location] {
        return locations
    }
}
