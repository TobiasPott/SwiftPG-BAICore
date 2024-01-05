import SwiftUI

public extension Filter {
    static func scale(name: String = "Scale", inScale: CGFloat = 1.0) -> Filter {
        return generic(name, BuiltInFilter.scale, [inScale], action: { (input, args) in
            let scale = args[0];
            if(scale <= 0) { return input; }
            return input
                .samplingNearest().transformed(by: CGAffineTransform(scaleX: scale, y: scale))
                .samplingNearest().transformed(by: CGAffineTransform(scaleX: 1.0 / scale, y: 1.0 / scale))
        })
    }
}
public extension FilterView {
    func getScaleView() -> AnyView {
        AnyView(HStack {
            Text("Scale \(String(format: "%.2f", filter.args[0]))")
            Slider(value: $filter.args[0], in: 0.01...1.0, step: 0.01)
        })
    }
}
