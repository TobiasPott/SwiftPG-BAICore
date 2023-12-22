import SwiftUI
import SwiftPG_CIFilters

class SourceInfo : ObservableObject, Codable {
    private enum CodingKeys: String, CodingKey {
        case filters
    }
    
    @Published var isImageSet: Bool = false;
    @Published var originalImage: PImage = LoadInfo.defaultImage;
    @Published var workImage: PImage? = nil;
    
    @Published var filters: Filters = Filters();
    
    
    public var image: PImage { get { return workImage ?? originalImage; } }
    public var aspect: CGFloat { get { return image.size.width / image.size.height; } }
    
    init() {
        workImage = makeUniform(originalImage);
        isImageSet = originalImage != LoadInfo.defaultImage;
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        filters = try container.decode(Filters.self, forKey: .filters)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filters, forKey: .filters)
    }
    
    func reset() {
        filters.reset()
        originalImage = LoadInfo.defaultImage;
        resetImage()
        isImageSet = originalImage != LoadInfo.defaultImage;
    }
    
    func reset(_ to: SourceInfo) {
        filters.reset()
        filters.append(other: to.filters)
        originalImage = to.originalImage;
        resetImage()
        isImageSet = originalImage != LoadInfo.defaultImage;
    }
    
    func resetImage() {
        workImage = makeUniform(originalImage);
    }
    func setImage(image: PImage) {
        originalImage = image;
        workImage = makeUniform(image);
        isImageSet = image != LoadInfo.defaultImage;
    }
    
    func makeUniform(_ input: PImage) -> PImage {
        let context = CIContext()
        let maxDim: CGFloat = max(input.size.width, input.size.height); 
        let scale: CGFloat = (1024 / maxDim);
        let ciImage = CIImage(image: input)?
            .transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        guard let outputImage = ciImage else { return input }
        
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            return PImage(cgImage: cgimg);
        }
        return input;
    }
    
    func applyFilter() {
        let context = CIContext()
        var ciImage = CIImage(image: makeUniform(originalImage));
        
        for i in 0..<filters.count {
            if (filters[i].enabled) {
                ciImage = filters[i].apply(ciImage!);
            }
        }
        guard let outputImage = ciImage else { return }
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            workImage = PImage(cgImage: cgimg);
        }
        return;
    }
    
}
