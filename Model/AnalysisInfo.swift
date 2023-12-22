import SwiftUI
import SwiftPG_Palettes

class AnalysisInfo : ObservableObject {   
    @Published public var tileWidth: Int;
    @Published public var tileHeight: Int;
    
    @Published var image: PImage;
    
    @Published public var colorInfo: ColorAnalysisInfo = ColorAnalysisInfo();
    
    public var tileInfos: [ColorAnalysisInfo] = []
    
    
    public var size: CGSize { get { return CGSize(width: tileWidth * 16, height: tileHeight * 16); } }
    
    init(_ canvas: CanvasInfo, image: PImage, palette: Palette) {
        self.tileWidth = canvas.tileWidth;
        self.tileHeight = canvas.tileHeight;
        self.image = image;
        
        let pixels: [CGColor] = image.getPixels();
        self.colorInfo.uniqueColors = Set(pixels).count;
        
        //        var reducedColors: [MultiColor] = [];
        self.colorInfo.colors = [];
        for i in 0..<pixels.count {
            var c = MultiColor(cgColor: pixels[i]); 
            let pIndex = palette.findClosest(c)
            c = pIndex >= 0 ? palette.get(pIndex).color : c;
            
            self.colorInfo.colors.append(c);
        }
        
        for tY in 0..<tileHeight {
            for tX in 0..<tileWidth {
                //                print("AnalysisInfo.init: Color Info: \(tX) \(tY)")
                tileInfos.append(ColorAnalysisInfo(tX * 16, tY * 16, 16, 16, inColors: pixels, rowLength: tileWidth * 16, palette: palette))
            }
        }
        
        self.colorInfo.uniqueColors = Set(self.colorInfo.colors).count;
        
        var total: Int = 0;
        var uniqueClrs: [MultiColor] = Array<MultiColor>(Set(self.colorInfo.colors))
        uniqueClrs.sort(by: { $0.hue > $1.hue})
        for clr in uniqueClrs {
            let count = self.colorInfo.colors.filter { $0 == clr }.count
            self.colorInfo.mappedColorCounts[clr] = count
            total += count;
        }
        
        
        var pixelData: [PixelData] = []
        for clr in self.colorInfo.colors {
            pixelData.append(clr.pixelRGBA)
        }
        self.image = PImage(pixels: pixelData, width: Int(canvas.tileWidth * 16), height: Int(canvas.tileHeight * 16)) ?? image
        
    }
    func imageFromARGB32Bitmap(pixels: [PixelData], width: Int, height: Int) -> PImage? {
        guard width > 0 && height > 0 else { return nil }
        guard pixels.count == width * height else { return nil }
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        var data = pixels // Copy to mutable []
        guard let providerRef = CGDataProvider(data: NSData(bytes: &data,
                                                            length: data.count * MemoryLayout<PixelData>.size)
        )
        else { return nil }
        
        guard let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: width * MemoryLayout<PixelData>.size,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
        else { return nil }
        
        return PImage(cgImage: cgim)
    }
}
