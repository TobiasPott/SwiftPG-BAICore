import SwiftUI

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
            if cgImage.byteOrderInfo == CGImageByteOrderInfo.orderDefault || cgImage.byteOrderInfo == CGImageByteOrderInfo.order32Big {
                r = pixel & 255
                g = (pixel >> 8) & 255
                b = (pixel >> 16) & 255
            } else if cgImage.byteOrderInfo == CGImageByteOrderInfo.order32Little {
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
            intent: CGColorRenderingIntent.defaultIntent)
        else { return nil }
        self.init(cgImage: cgim)
    }
}
