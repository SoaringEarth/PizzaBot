import Foundation

let rawInput = "5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"

Parser.parse(input: rawInput) { result in
    switch result {
    case .success(let map):
        var bot = PizzaBot(map: map)
        bot.run(optimised: false) { result in
            switch result {
            case .success(let routeTaken):
                print("Route:", routeTaken)
            case .failure(let error):
                print(error.description)
            }
        }

        bot = PizzaBot(map: map)
        bot.run(optimised: true) { result in
            switch result {
            case .success(let routeTaken):
                print("Route:", routeTaken)
            case .failure(let error):
                print(error.description)
            }
        }
    case .failure(let error):
        print(error.description)
    }
}

var runTests = true
if runTests {
//    PizzabotTests.defaultTestSuite.run()
    ParserTests.defaultTestSuite.run()
}
