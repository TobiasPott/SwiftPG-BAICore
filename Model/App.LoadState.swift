import SwiftUI

enum LoadLayout: Int, Codable, Hashable {
    case landscape, square, portrait
}
enum LoadDetails: Int, Codable, Hashable {
    case low, medium, high
}

class LoadState : ObservableObject {
    @Published public var name: String = "Canvas"
    @Published public var width: Int = 3;
    @Published public var height: Int = 3;
    @Published public var builtInPalette: BuiltInPalette = BuiltInPalette.legoReduced
    @Published public var palette: Palette
    
    
    @Published public var layout: LoadLayout = LoadLayout.square
    @Published public var details: LoadDetails = LoadDetails.medium
    
    
    @Published public var isImageSet: Bool = false
    @Published var image: PImage = Defaults.image;
    public var sizePx: CGSize { get { return CGSize(width: width * 16, height: height * 16); } }
    
    public var aspect: CGFloat { get { return CGFloat(self.width) / CGFloat(self.height) } }
    
    
    init(_ width: Int, _ height: Int, _ name: String = "Canvas", _ builtInPalette: BuiltInPalette = BuiltInPalette.legoReduced, _ image: PImage = Defaults.image) {
        self.width = width;
        self.height = height;
        self.name = name;
        self.builtInPalette = builtInPalette;
        self.palette = Palette.getPalette(builtInPalette)
        self.image = image;
        self.isImageSet = image != Defaults.image
    }
    
    func set(_ image: PImage) {
        self.image = image;
        self.isImageSet = image != Defaults.image
    }
    
    func getCanvas(refSize: CGSize) -> ArtCanvas {
        return ArtCanvas(self.width, self.height, size: refSize)
    }
    
    func isLayout(_ layout: LoadLayout) -> Bool { 
        return self.layout == layout; 
    }
    func isDetail(_ details: LoadDetails) -> Bool { 
        return self.details == details; 
    }
    
    func setLayout(_ layout: LoadLayout) { setLayoutAndDetails(layout, self.details) }
    func setDetails(_ details: LoadDetails) { setLayoutAndDetails(self.layout, details) }
    func setLayoutAndDetails(_ layout: LoadLayout, _ details: LoadDetails) {
        self.layout = layout;
        self.details = details
        switch layout {
        case LoadLayout.landscape:
            self.width = 2
            self.height = 1
            break;
        case LoadLayout.square:
            self.width = 2
            self.height = 2
            break;
        case LoadLayout.portrait:
            self.width = 1
            self.height = 2
            break;
        }
        switch details {
        case LoadDetails.low:
            break;
        case LoadDetails.medium:
            self.width += 1
            self.height += 1
            break;
        case LoadDetails.high:
            self.width += 2
            self.height += 2
            break;
        }
    }
    
    func reset() {
        self.width = 3;
        self.height = 3;
        self.builtInPalette = BuiltInPalette.legoReduced
        self.palette = Palette.getPalette(BuiltInPalette.legoReduced)
        self.image = Defaults.image
        self.isImageSet = false
        self.layout = LoadLayout.square
        self.details = LoadDetails.medium
    }
    
    public func importImage(result: Result<URL, Error>) -> Void {
        do {
            let fileUrl = try result.get()
            print(fileUrl)
            
            guard fileUrl.startAccessingSecurityScopedResource() else { return }
            if let imageData = try? Data(contentsOf: fileUrl),
               let image = PImage(data: imageData) {
                self.set(image)
            }
            fileUrl.stopAccessingSecurityScopedResource()
            
        } catch {
            
            print ("Error reading file from disk.")
            print (error.localizedDescription)
        }
    }
}
