import SwiftUI

public struct FilterView: View {
    @Binding var filter: Filter;
    
    public init(filter: Binding<Filter>) {
        _filter = filter
    }
    
    public var body: some View {
        HStack {
            HStack {
                Toggle(isOn: $filter.enabled, label: { Text(filter.enabled ? "on" : "off") }).toggleStyle(.button).tint(filter.enabled ? .green : .red)
                Text("\(filter.name)")
            }
            .frame(maxWidth: 110.0, alignment: .leading)
            Divider()
            getArgsView()
        }
        .font(Styling.caption2Font)
    }
    
    func getArgsView() -> AnyView {
        switch(filter.type) {
        case .scale:
            return getScaleView()
        case .posterize:
            return getPosterizeView()
        case .saturation:
            return FilterView.anyEmpty
        case .thermal:
            return getThermalView()
        case .xray:
            return getXRayView()
        case .sepiatone:
            return getSepiaToneView()
        case .hueadjust:
            return getHueAdjustView()
        case .comiceffect:
            return getComicEffectView()
        }
    }
}

public extension Filter {
    static func thermal(name: String = "Thermal") -> Filter {
        return generic(name, .thermal, [], action: { (input, args) in
            let filter = CIFilter(name: "CIThermal")
            filter?.setValue(input, forKey: "inputImage")
            return filter?.outputImage ?? input
        })
    }
    static func xray(name: String = "XRay") -> Filter {
        return generic(name, .xray, [], action: { (input, args) in
            let filter = CIFilter(name: "CIXRay")
            filter?.setValue(input, forKey: "inputImage")
            return filter?.outputImage ?? input
        })
    }
    static func comicEffect(name: String = "Comic Effect") -> Filter {
        return generic(name, .comiceffect, [], action: { (input, args) in
            let filter = CIFilter(name: "CIComicEffect")
            filter?.setValue(input, forKey: "inputImage")
            return filter?.outputImage ?? input
        })
    }
}

public extension FilterView {
    func getThermalView() -> AnyView { FilterView.anySpacer }
    func getXRayView() -> AnyView { FilterView.anySpacer }
    func getComicEffectView() -> AnyView { FilterView.anySpacer }
}
