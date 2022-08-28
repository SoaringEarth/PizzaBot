import Foundation

public enum Direction {
    case Horizontal
    case Vertical
}

protocol Robot {
    func moveTo(location: Int, direction: Direction)
}

public class PizzaBot: Robot {

    private enum Instruction: String {
        case N
        case S
        case E
        case W
        case D
    }

    public var currentLocation: Location = Location.startPoint
    
    private var route: String = ""
    private var map: DeliveryMap

    public init(map: DeliveryMap) {
        self.map = map
    }

    public func run(optimised: Bool = false, completionHandler: @escaping (Result<String, PizzaBotError>) -> Void) {
        if optimised {
            map.dropPoints = optimiseRoute(map.dropPoints)
        }
        deliverTo(map.dropPoints) { [weak self] result in
            switch result {
            case .success(let route):
                print("DropLocations", self?.map.dropPoints.map({ $0.tupleOutput }) ?? "")
                completionHandler(.success(route))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    private func optimiseRoute(_ locations: [Location]) -> [Location] {
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

    private func deliverTo(_ locations: [Location], completionHandler: @escaping (Result<String, PizzaBotError>) -> Void) {
        for location in locations {
            guard location.isWithinDeliveryZone(map: map) else {
                return completionHandler(.failure(.locationOutsideGrid(location: location, gridSize: map.gridSize)))
            }
            moveTo(location: location.x, direction: .Horizontal)
            moveTo(location: location.y, direction: .Vertical)
            if currentLocation == location {
                route.append(Instruction.D.rawValue)
            }
        }
        completionHandler(.success(route))
    }

    func moveTo(location: Int, direction: Direction) {
        switch direction {
        case .Horizontal:
            if location > currentLocation.x {
                route.append(Instruction.E.rawValue)
                currentLocation.x += 1
            } else if location < currentLocation.x {
                route.append(Instruction.W.rawValue)
                currentLocation.x -= 1
            } else {
                currentLocation.x = location
                return
            }
        case .Vertical:
            if location > currentLocation.y {
                route.append(Instruction.N.rawValue)
                currentLocation.y += 1
            } else if location < currentLocation.y {
                route.append(Instruction.S.rawValue)
                currentLocation.y -= 1
            } else {
                currentLocation.y = location
                return
            }

        }
        moveTo(location: location, direction: direction)
    }
}
