import Foundation

public class Parser {

    public enum CapturePattern: String {
        case grid = "(?<gridWidth>^[0-9]+)x(?<gridHeight>[0-9]+)"
        case dropPoint = "[(](?<xCoord>[0-9]+), (?<yCoord>[0-9]+)[)]"
    }

    public enum GridCaptureGroup: String, CaseIterable {
        case gridWidth, gridHeight
    }

    public enum DropPointCaptureGroup: String, CaseIterable {
        case xCoord, yCoord
    }

    public static func parseDeliveryMap(input: String, completionHandler: @escaping (Result<DeliveryMap, ParserError>) -> Void) {
        guard !input.isEmpty
        else {
            return completionHandler(.failure(.inputEmpty))
        }
        guard
            let parsedGrid = parse(input: input,
                                   captureGroups: GridCaptureGroup.allCases.map({"\($0)"}),
                                   capturePattern: .grid).first,
            let width = parsedGrid[GridCaptureGroup.gridWidth.rawValue],
            let height = parsedGrid[GridCaptureGroup.gridHeight.rawValue]
        else { return completionHandler(.failure(.failedToParseGridSize)) }

        let grid = Grid(width: width, height: height)
        print(grid)
        var map = DeliveryMap(grid: grid,
                              dropPoints: [])

        let dropPoints: [Location] = parse(input: input,
                                           captureGroups: DropPointCaptureGroup.allCases.map({"\($0)"}),
                                           capturePattern: .dropPoint).compactMap({
            guard
                let x = $0["xCoord"],
                let y = $0["yCoord"]
            else { return nil }
            return Location(x: x, y: y)
        })
        print(dropPoints)
        map.dropPoints = dropPoints
        completionHandler(.success(map))
    }

    // https://regex101.com/r/BTxTwo/1
    // https://regex101.com/r/yNSG6x/1
    public static func parse(input: String, captureGroups: [String], capturePattern: CapturePattern) -> [[String: Int]] {
        let nameRange = NSRange(input.startIndex..<input.endIndex, in: input)
        do {
            let captureRegex = try! NSRegularExpression(pattern: capturePattern.rawValue,
                                                        options: [])
            let matches = captureRegex.matches(in: input,
                                               options: [],
                                               range: nameRange)
            guard let _ = matches.first else {
                // Handle exception
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
            var capturedGroup: [String: Int] = [:]
            var captures: [[String: Int]] = []
            // For each matched range, extract the named capture group
            for match in matches {
                for group in captureGroups {
                    let matchRange = match.range(withName: group)
                    // Extract the substring matching the named capture group
                    if let substringRange = Range(matchRange, in: input) {
                        let capture = Int(input[substringRange])
                        capturedGroup[group] = capture
                    }
                }
                captures.append(capturedGroup)
            }
            return captures
        } catch {
            return []
        }
    }

}
