import Foundation

struct TargetLocation {
    var isLeftHand: Bool
    
    var x: Int
    var y: Int
    
    static func random() -> Self {
        TargetLocation(isLeftHand: .random(), x: .random(in: 0..<3), y: .random(in: 0..<5))
    }
}
