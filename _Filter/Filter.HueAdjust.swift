import SwiftUI

public extension Filter {
    static func hueAdjust(name: String = "Hue Adjust", inInputAngle: CGFloat = 0.0) -> Filter {
        return generic(name, BuiltInFilter.hueadjust, [inInputAngle], action: { (input, args) in
            let inputAngle = args[0];
            if(inputAngle <= 0) { return input; }
            
            let filter = CIFilter(name: "CIHueAdjust")
            filter?.setValue(input, forKey: "inputImage")
            filter?.setValue(inputAngle, forKey: "inputAngle")
            return filter?.outputImage ?? input
        })
    }
}
public extension FilterView {
    func getHueAdjustView() -> AnyView {
        AnyView(HStack {
                Text("Angle \(String(format: "%.2f", filter.args[0]))")
                Slider(value: $filter.args[0], in: 0.0...4.0, step: 0.01)
            })
    }
}
