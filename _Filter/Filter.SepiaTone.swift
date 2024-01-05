import SwiftUI

public extension Filter {
    static func sepiaTone(name: String = "Sepia Tone", inInputIntensity: CGFloat = 32.0) -> Filter {
        return generic(name, BuiltInFilter.sepiatone, [inInputIntensity], action: { (input, args) in
            let inputIntensity = args[0];
            
            let filter = CIFilter(name: "CISepiaTone")
            filter?.setValue(input, forKey: "inputImage")
            filter?.setValue(inputIntensity, forKey: "inputIntensity")
            return filter?.outputImage ?? input
        })
    }
}
public extension FilterView {
    func getSepiaToneView() -> AnyView {
        AnyView(HStack {
            Text("Intensity \(String(format: "%.2f", filter.args[0]))")
            Slider(value: $filter.args[0], in: 0.0...1.0, step: 0.01)
        })
    }
}
