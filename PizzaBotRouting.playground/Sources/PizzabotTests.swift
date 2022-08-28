import Foundation
import XCTest

public class PizzabotTests: XCTestCase {

    public override func setUp() {
        super.setUp()
    }
    public override func tearDown() {
        super.tearDown()
    }

    func test_initialisation() {
        let sut = PizzaBot(map: DeliveryMap.empty, optimiser: Mock_RouteOptimiser())
        XCTAssertNotNil(sut)
    }

    func test_moveToLocation() {
        let sut = PizzaBot(map: DeliveryMap.empty, optimiser: Mock_RouteOptimiser())
        XCTAssertEqual(sut.currentLocation, Location.startPoint)
        sut.moveTo(location: 5, direction: .Horizontal)
        XCTAssertEqual(sut.currentLocation, Location(x: 5, y: 0))
        sut.moveTo(location: 5, direction: .Vertical)
        XCTAssertEqual(sut.currentLocation, Location(x: 5, y: 5))
    }

    func test_runRoute() {
        let expectation = expectation(description: "expectation for pizzabot running their route")
        let testMap = DeliveryMap(grid: Grid(width: 5, height: 5), dropPoints: LocationFactory.generateLocations(amount: 10, maxRange: 5))
        let sut = PizzaBot(map: testMap, optimiser: Mock_RouteOptimiser())
        sut.run(optimised: false) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        waitForExpectations(timeout: 1.0)
    }

    func test_exampleRoute() {
        let expectation = expectation(description: "expectation for pizzabot running the example route")
        let testMap = DeliveryMap(grid: Grid(width: 5, height: 5), dropPoints: [Location(x: 1, y: 3), Location(x: 4, y: 4)])
        let sut = PizzaBot(map: testMap, optimiser: Mock_RouteOptimiser())
        sut.run(optimised: false) { result in
            switch result {
            case .success(let route):
                XCTAssertEqual(route, "ENNNDEEEND")
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        waitForExpectations(timeout: 1.0)
    }
}
