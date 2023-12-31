import SwiftUI
import SwiftPG_Palettes

// ToDo: Finish renaming type to match file name
class LoadState : ObservableObject {
    public static let defaultImage: PImage = PImage();
    
    @Published public var name: String = "Canvas"
    @Published public var width: Int = 3;
    @Published public var height: Int = 3;
    @Published public var builtInPalette: BuiltInPalette = .lego
    @Published public var palette: Palette
    
    @Published public var isImageSet: Bool = false
    @Published var image: PImage = LoadState.defaultImage;
    public var sizePx: CGSize { get { return CGSize(width: width * 16, height: height * 16); } }
    
    
    
    init(_ width: Int, _ height: Int, _ name: String = "Canvas", _ builtInPalette: BuiltInPalette = BuiltInPalette.lego, _ image: PImage = LoadState.defaultImage) {
        self.width = width;
        self.height = height;
        self.name = name;
        self.builtInPalette = builtInPalette;
        self.palette = Palette.getPalette(builtInPalette)
        self.image = image;
        self.isImageSet = image != LoadState.defaultImage
    }
    
    func set(_ image: PImage) {
        self.image = image;
        self.isImageSet = image != LoadState.defaultImage
    }
    
    func getCanvas(refSize: CGSize) -> ArtCanvas {
        return ArtCanvas(self.width, self.height, size: refSize)
    }
    
    func reset() {
        self.width = 3;
        self.height = 3;
        self.builtInPalette = BuiltInPalette.lego
        self.palette = Palette.getPalette(BuiltInPalette.lego)
        self.image = LoadState.defaultImage
        self.isImageSet = false
    }
}
