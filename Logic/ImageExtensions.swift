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

extension PImage {
    
    func getPixels() -> [CGColor] { return getPixels(CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))}
    func getPixels(_ rect: CGRect) -> [CGColor] {
        guard let cgImage = self.cgImage else {
            return []
        }
        assert(cgImage.bitsPerPixel == 32, "only support 32 bit images")
        assert(cgImage.bitsPerComponent == 8,  "only support 8 bit per channel")
        guard let imageData = cgImage.dataProvider?.data as Data? else {
            return []
        }
        let size = Int(size.width) * Int(size.height)
        let buffer = UnsafeMutableBufferPointer<UInt32>.allocate(capacity: size)
        
        _ = imageData.copyBytes(to: buffer)
        var result = [CGColor]()
        result.reserveCapacity(size)
        for pixel in buffer {
            var r : UInt32 = 0
            var g : UInt32 = 0
            var b : UInt32 = 0
            if cgImage.byteOrderInfo == .orderDefault || cgImage.byteOrderInfo == .order32Big {
                r = pixel & 255
                g = (pixel >> 8) & 255
                b = (pixel >> 16) & 255
            } else if cgImage.byteOrderInfo == .order32Little {
                r = (pixel >> 16) & 255
                g = (pixel >> 8) & 255
                b = pixel & 255
            }
            let color = CGColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
            result.append(color)
        }
        return result
    }
    
    
    convenience init?(pixels: [PixelData], width: Int, height: Int) {
        guard width > 0 && height > 0, pixels.count == width * height else { return nil }
        var data = pixels
        guard let providerRef = CGDataProvider(data: Data(bytes: &data, count: data.count * MemoryLayout<PixelData>.size) as CFData)
        else { return nil }
        guard let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            bytesPerRow: width * MemoryLayout<PixelData>.size,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent)
        else { return nil }
        self.init(cgImage: cgim)
    }
}
