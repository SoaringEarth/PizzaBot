import Foundation
import XCTest

public class ParserTests: XCTestCase {

    public override func setUp() {
        super.setUp()
    }
    public override func tearDown() {
        super.tearDown()
    }

    //    test(captureGroups: ParserGridCaptureGroup.allCases.map({"\($0)"}),
    //         capturePattern: #"(?<gridWidth>[0-9]+)x(?<gridHeight>[0-9]+)"#)
    //
    //    test(captureGroups: ParserDropPointCaptureGroup.allCases.map({"\($0)"}),
    //         capturePattern: #"[(](?<xCoord>[0-9]+), (?<yCoord>[0-9]+)[)]"#)

    func test_parse_grid_failed() {
        let captureTypes = Parser.GridCaptureGroup.allCases.map({"\($0)"})
        let regex = "(?<gridWidth>^[0-9]+)x(?<gridHeight>[0-9]+)"
        var input = "55 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"
        var sut = Parser.newParser(input: input, captureGroups: captureTypes, capturePattern: regex)
        XCTAssertEqual(sut.count, 0)

        input = "5xx5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"
        sut = Parser.newParser(input: input, captureGroups: captureTypes, capturePattern: regex)
        XCTAssertEqual(sut.count, 0)

        input = "a5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"
        sut = Parser.newParser(input: input, captureGroups: captureTypes, capturePattern: regex)
        XCTAssertEqual(sut.count, 0)

        input = "axb (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"
        sut = Parser.newParser(input: input, captureGroups: captureTypes, capturePattern: regex)
        XCTAssertEqual(sut.count, 0)

        input = "(0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"
        sut = Parser.newParser(input: input, captureGroups: captureTypes, capturePattern: regex)
        XCTAssertEqual(sut.count, 0)
    }

    func test_parse_failed() {
        let expectation = expectation(description: "expectation for pizzabot running their route")
        let input = ""
        Parser.parse(input: input) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1.0)
    }

    func test_parse_succeeds() {
        let expectation = expectation(description: "expectation for pizzabot running their route")
        let input = "5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"
        Parser.parse(input: input) { result in
            switch result {
            case .success(let map):
                XCTAssertEqual(map.width, 5)
                XCTAssertEqual(map.height, 5)
                XCTAssertEqual(map.gridSize, "5x5")
                XCTAssertEqual(map.dropPoints.count, 9)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        waitForExpectations(timeout: 1.0)
    }
}
