import Foundation

public enum ParserError: Error {
    case failedToFindMatches
    case failedToParseGridSize
    case failedToParseLocation(location: String)
    case inputEmpty
    case unknown
}

extension ParserError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .failedToFindMatches:
            return "Failed to find any matches in input, please check your input and capture pattern"
        case .failedToParseGridSize:
            return "Failed to correctly parse grid size, please check the input"
        case .failedToParseLocation(let location):
            return "Failed to correctly parse location: \(location), please check the input"
        case .inputEmpty:
            return "Input is empty, please enter a correctly formatted input"
        case .unknown:
            return "An unexpected error occurred."
        }
    }
}
