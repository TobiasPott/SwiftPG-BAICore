import SwiftUI

class LoadInfo : ObservableObject {
    public static let defaultImage: PImage = PImage();
    
    @Published public var name: String = "Canvas"
    @Published public var width: Int = 3;
    @Published public var height: Int = 3;
    
    @Published public var isImageSet: Bool = false
    @Published var image: PImage = LoadInfo.defaultImage;
    public var sizePx: CGSize { get { return CGSize(width: width * 16, height: height * 16); } }
    
    
    
    init(_ width: Int, _ height: Int, _ name: String = "Canvas",  _ image: PImage = LoadInfo.defaultImage) {
        self.width = width;
        self.height = height;
        self.name = name;
        self.image = image;
        self.isImageSet = image != LoadInfo.defaultImage
    }
    
    func set(_ image: PImage) {
        self.image = image;
        self.isImageSet = image != LoadInfo.defaultImage
    }
    
    func getCanvas(refSize: CGSize) -> CanvasInfo {
        return CanvasInfo(self.width, self.height, size: refSize)
    }
    
    func reset() {
        self.width = 3;
        self.height = 3;
        self.image = LoadInfo.defaultImage
        self.isImageSet = false
    }
}
