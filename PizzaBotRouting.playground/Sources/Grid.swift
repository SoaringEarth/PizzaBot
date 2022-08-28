import Foundation

public struct Grid {
    let width: Int
    let height: Int

    var size: String {
        return "\(width)x\(height)"
    }
}

extension Grid {
    public static var empty: Grid {
        return Grid(width: 0, height: 0)
    }
}
