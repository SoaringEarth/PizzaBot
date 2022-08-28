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

    public static func parse(input: String, completionHandler: @escaping (Result<DeliveryMap, ParserError>) -> Void) {
        guard !input.isEmpty
        else {
            return completionHandler(.failure(.inputEmpty))
        }
        Parser.prse(input: input)
        let spaceSplit = input.split(maxSplits: 1,
                                     omittingEmptySubsequences: true,
                                     whereSeparator: { $0 == " "})
        let gridSize = spaceSplit[0].split(separator: "x")
        guard
            gridSize.count == 2, // Ensure we have 2 numbers to make a valid grid
            let width = Int(gridSize[0]),
            let height = Int(gridSize[1])
        else {
            return completionHandler(.failure(.failedToParseGridSize))
        }
        let locations = spaceSplit[1]
            .filter({ $0 != " " && $0 != "(" })
            .split(separator: ")")
        var map = DeliveryMap(width: width,
                              height: height,
                              dropPoints: [])
        for location in locations {
            let splitLocation = location.split(separator: ",")
            guard
                splitLocation.count == 2,
                let locationX = Int(splitLocation[0]),
                let locationY = Int(splitLocation[1])
            else {
                return completionHandler(.failure(.failedToParseLocation(location: String(location))))
            }
            map.dropPoints.append(Location(x: locationX,
                                           y: locationY))
        }
        completionHandler(.success(map))
    }

    public static func prse(input: String) {//}, completionHandler: @escaping (Result<DeliveryMap, ParserError>) -> Void) {
        let grid = Parser.newParser(input: input,
                                    captureGroups: GridCaptureGroup.allCases.map({ "\($0)" }),
                                    capturePattern: .grid).first
        print(grid)
    }

    public static func newParser(input: String, captureGroups: [String], capturePattern: CapturePattern) -> [[String: Any]] {
        // https://regex101.com/r/BTxTwo/1
        // https://regex101.com/r/yNSG6x/1
        let nameRange = NSRange(
            input.startIndex..<input.endIndex,
            in: input
        )
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

            print(matches.count)

            var capturedGroup: [String: Any] = [:]
            var captures: [[String: Any]] = []
            // For each matched range, extract the named capture group
            for match in matches {
                for group in captureGroups {
                    let matchRange = match.range(withName: group)
                    // Extract the substring matching the named capture group
                    if let substringRange = Range(matchRange, in: input) {
                        let capture = String(input[substringRange])
                        capturedGroup[group] = capture
                    }
                }
                captures.append(capturedGroup)
            }
            print(captures)
            return captures
        } catch {
            return []
        }
    }

}
