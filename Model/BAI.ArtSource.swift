import SwiftUI

class ArtSource : ObservableObject, Codable {
    private enum CodingKeys: String, CodingKey {
        case filters, imageBase64
    }
    
    @Published var isImageSet: Bool = false;
    @Published var originalImage: PImage = Defaults.image;
    @Published var workImage: PImage? = nil;
    
    @Published var filters: Filters = Filters();
    
    
    public var image: PImage { get { return workImage ?? originalImage; } }
    public var aspect: CGFloat { get { return image.size.width / image.size.height; } }
    
    init() {
        workImage = makeUniform(originalImage);
        isImageSet = originalImage != Defaults.image;
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        filters = try container.decode(Filters.self, forKey: CodingKeys.filters)

        let imageAsBase64 = try container.decode(String.self, forKey: CodingKeys.imageBase64)
        let imageData = Data(base64Encoded: imageAsBase64, options: .ignoreUnknownCharacters)
        let decodedimage = UIImage(data: imageData!) ?? Defaults.image
        self.setImage(image: decodedimage)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filters, forKey: CodingKeys.filters)
        
        //Now use image to create into NSData format
        guard let imageData: Data = (workImage ?? originalImage).pngData() else { return }
        let imageAsBase64: String = imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        try container.encode(imageAsBase64, forKey: CodingKeys.imageBase64)
    }
    
    func reset() {
        filters.reset()
        originalImage = Defaults.image;
        resetImage()
        isImageSet = originalImage != Defaults.image;
    }
    
    func reset(_ to: ArtSource) {
        filters.reset()
        filters.append(other: to.filters)
        originalImage = to.originalImage;
        resetImage()
        isImageSet = originalImage != Defaults.image;
    }
    
    func resetImage() {
        workImage = makeUniform(originalImage);
    }
    func setImage(image: PImage) {
        originalImage = image;
        workImage = makeUniform(image);
        isImageSet = image != Defaults.image;
    }
    
    func makeUniform(_ input: PImage) -> PImage {
        let context = CIContext()
        let maxDim: CGFloat = max(input.size.width, input.size.height); 
        let scale: CGFloat = (1024.0 / maxDim);
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
