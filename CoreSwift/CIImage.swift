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
    
}
