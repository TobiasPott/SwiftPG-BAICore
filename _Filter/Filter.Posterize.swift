import SwiftUI

public extension Filter {
    static func posterize(name: String = "Posterize", inInputLevels: CGFloat = 32.0) -> Filter {
        return generic(name, BuiltInFilter.posterize, [inInputLevels], action: { (input, args) in
            let inputLevels = args[0];
            if(inputLevels <= 0) { return input; }
            
            let filter = CIFilter(name: "CIColorPosterize")
            filter?.setValue(input, forKey: "inputImage")
            filter?.setValue(inputLevels, forKey: "inputLevels")
            return filter?.outputImage ?? input
        })
    }
}
public extension FilterView {
    func getPosterizeView() -> AnyView {
        AnyView(HStack {
            Text("Levels \(Int(filter.args[0]))")
            Slider(value: $filter.args[0], in: 1.0...32.0, step: 1.0)
        })
    }
}
