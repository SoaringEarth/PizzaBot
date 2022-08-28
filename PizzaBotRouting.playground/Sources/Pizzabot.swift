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
    private var optimiser: Optimiser

    public init(map: DeliveryMap, optimiser: Optimiser) {
        self.map = map
        self.optimiser = optimiser
    }

    public func run(optimised: Bool = false, completionHandler: @escaping (Result<String, PizzaBotError>) -> Void) {
        if optimised {
            map.dropPoints = optimiser.optimiseRoute(map.dropPoints)
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

    private func deliverTo(_ locations: [Location], completionHandler: @escaping (Result<String, PizzaBotError>) -> Void) {
        for location in locations {
            guard map.isLocationWithinDeliveryZone(location) else {
                return completionHandler(.failure(.locationOutsideGrid(location: location, gridSize: map.grid.size)))
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
