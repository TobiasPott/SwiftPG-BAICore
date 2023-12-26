import SwiftUI

extension CIImage {
    func posterize(inputLevels: Double) -> CIImage {
        let posterize = CIFilter(name: "CIColorPosterize")
        posterize?.setValue(self, forKey: kCIInputImageKey)
        posterize?.setValue(inputLevels, forKey: "inputLevels")
        
        return posterize?.outputImage ?? self
    }
    func dither(inputIntensity: Double = 0.0) -> CIImage {
        let dither = CIFilter(name: "CIDither")
        dither?.setValue(self, forKey: kCIInputImageKey)
        dither?.setValue(inputIntensity, forKey: "inputIntensity")
        
        return dither?.outputImage ?? self
    }
    func noiseRecution(inputNoiseLevel: Double = 0.0, inputSharpness: Double = 0.0) -> CIImage {
        let filter = CIFilter(name: "CINoiseReduction")
        filter?.setValue(self, forKey: kCIInputImageKey)
        filter?.setValue(inputNoiseLevel, forKey: "inputNoiseLevel")
        filter?.setValue(inputSharpness, forKey: "inputSharpness")
        return filter?.outputImage ?? self
    }
    
    func colorControls(inputBrightness: Double = 1.0, inputContrast: Double = 0.0,
                       inputSaturation: Double = 0.5) -> CIImage {
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(self, forKey: kCIInputImageKey)
        filter?.setValue(inputBrightness, forKey: "inputBrightness")
        filter?.setValue(inputContrast, forKey: "inputContrast")
        filter?.setValue(inputSaturation, forKey: "inputSaturation")
        
        return filter?.outputImage ?? self
    }
    func saturation(inputSaturation: Double = 1.0) -> CIImage {
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(self, forKey: kCIInputImageKey)
        filter?.setValue(0.0, forKey: "inputBrightness")
        filter?.setValue(1.0, forKey: "inputContrast")
        filter?.setValue(inputSaturation, forKey: "inputSaturation")
        
        return filter?.outputImage ?? self
    }
    
}

extension Image {
    func rs(fit: Bool = true) -> some View {
        if (fit) { return AnyView(self.resizable().scaledToFit()) }
        else { return AnyView(self.resizable().scaledToFill()) }
    }
}
