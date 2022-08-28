import Foundation

public enum PizzaBotError: Error {
    case locationOutsideGrid(location: Location, gridSize: String)
}

extension PizzaBotError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .locationOutsideGrid(let location, let gridSize):
            return "ERROR: location \(location.tupleOutput) is outside of grid, grid size is: \(gridSize)"
        }
    }
}
