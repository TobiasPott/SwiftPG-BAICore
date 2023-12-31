import SwiftUI

class ArtCanvas : ObservableObject, Identifiable, Codable
{
    private enum CodingKeys: String, CodingKey {
        case id, name, tileWidth, tileHeight, location, drag, isLocked, scale
    }
    
    
    @Published public var id: UUID;
    @Published public var name: String;
    @Published public var tileWidth: Int;
    @Published public var tileHeight: Int;
    @Published public var scale: CGFloat = 10;
    @Published public var isLocked: Bool = false;
    
    @Published var drag: DragInfo = DragInfo();
    
    var maxScale: CGFloat = 64.0
    // analysis info
    @Published public var analysis: ArtAnalysis? = nil;
    
    public var aspect: CGFloat { get { return CGFloat(tileHeight) / CGFloat(tileWidth); } }
    public var size: CGSize {
        get {
            // possibly modify the return value
            return CGSize(width: tileWidth * 16, height: tileHeight * 16);
        }
    }
    
    init(_ tileWidth: Int, _ tileHeight: Int, size: CGSize? = nil) {
        let newId = UUID();
        id = newId
        self.tileWidth = tileWidth;
        self.tileHeight = tileHeight;
        self.name = "Canvas \(tileWidth)x\(tileHeight)"
        if (size != nil) {
            self.autoFit(tileWidth, tileHeight, size: size!)
        }
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        drag = try container.decode(DragInfo.self, forKey: .drag)       
        tileWidth = try container.decode(Int.self, forKey: .tileWidth)
        tileHeight = try container.decode(Int.self, forKey: .tileHeight)
        isLocked = try container.decode(Bool.self, forKey: .isLocked)
        scale = try container.decode(CGFloat.self, forKey: .scale)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(drag, forKey: .drag)
        try container.encode(tileWidth, forKey: .tileWidth)
        try container.encode(tileHeight, forKey: .tileHeight)
        try container.encode(isLocked, forKey: .isLocked)
        try container.encode(scale, forKey: .scale)
    }
    
    func Analyse(_ source: ArtSource, _ palette: Palette) -> Bool {
        return freeze(source, palette)
    }
    func DiscardAnalysis() -> Bool {
        if(analysis != nil) {
            analysis = nil;
            return true;
        }
        return false;
    }
    private func freeze(_ source: ArtSource, _ palette: Palette) -> Bool {
        var result: Bool = false;
        
        let context = CIContext()
        let cX = floor(drag.location.x);
        let cY = floor(drag.location.y);
        let cW = floor(size.width * scale);
        let cH = floor(size.height * scale);
        let cropRect: CGRect = CGRect(x: cX, y: floor(source.image.size.height - cH - cY), width: cW, height: cH)
        
        let invScale = 1.0 / scale;
        var ciImage: CIImage? = CIImage(image: source.image);
        ciImage = ciImage?
            .cropped(to: cropRect)
            .samplingNearest()
            .transformed(by: CGAffineTransform(scaleX: invScale, y: invScale))
            .dither(inputIntensity: 0.25)
            .posterize(inputLevels: 6)
        
        guard let fixedImage = ciImage else { return result; }
        let grabRect: CGRect = CGRect(origin: fixedImage.extent.origin, size: size)
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(fixedImage, from: grabRect) {
            // create analysis
            self.analysis = ArtAnalysis(self, image: PImage(cgImage: cgimg), palette: palette);
            result = true;
        }
        return result;
    }
    
    func autoFit(_ newWidth: Int, _ newHeight: Int, size: CGSize) -> Void {
        
        self.tileWidth = newWidth.clamped(lowerBound: 1, upperBound: 9);
        self.tileHeight = newHeight.clamped(lowerBound: 1, upperBound: 9);
        
        let tileScaleX: CGFloat = 16 * CGFloat(newWidth);                    
        let tileScaleY: CGFloat = 16 * CGFloat(newHeight);
        let scale: CGFloat = min(size.width / tileScaleX, size.height / tileScaleY);
        self.scale = scale;
        self.maxScale = scale;
        let location: CGPoint = CGPoint(x: (size.width - (scale * tileScaleX)) / 2, y: (size.height - (scale * tileScaleY)) / 2)
        self.drag.location = location;
        self.drag.fixedLocation = location;
    }
    
    func equals(_ other: ArtCanvas?) -> Bool {
        guard let oCanvas = other else { return false; }
        return self.id == oCanvas.id
    }
}

struct Canvases : Codable {
    private enum CodingKeys: String, CodingKey {
        case items
    }
    
    var items: [ArtCanvas];
    
    init() {
        items = []
    }
    init(_ initItems: [ArtCanvas]) {
        items = []
        items.append(contentsOf: initItems);
    }
    
    subscript (index: Int) -> ArtCanvas {
        get { return items[index] }
        set(value) { items[index] = value }
    }
    mutating func append(_ newElement: ArtCanvas) {
        self.items.append(newElement)
    }
    mutating func append(other: Canvases) {
        self.items.append(contentsOf: other.items)
    }
    mutating func remove(at: Int) {
        self.items.remove(at: at)
    }
    mutating func remove(atOffsets: IndexSet) {
        self.items.remove(atOffsets: atOffsets)
    }
    mutating func reset(_ to: [ArtCanvas] = []) {
        items.removeAll()
        items.append(contentsOf: to)
    }
    mutating func reset(_ to: Canvases) {
        items.removeAll()
        items.append(contentsOf: to.items)
    }
    
}
