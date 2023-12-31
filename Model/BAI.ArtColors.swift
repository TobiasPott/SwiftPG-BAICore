import SwiftUI

class ArtColors: ObservableObject {    
    @Published public var width: Int = 16;
    @Published public var height: Int = 16;
    
    @Published public var colors: [MultiColor] = [];
    @Published public var uniqueColors: Int = 0;
    @Published public var mappedColorCounts: Dictionary<MultiColor, Int> = Dictionary();
    
    init() {
        self.width = 16
        self.height = 16
        self.uniqueColors = 0;
        self.colors = []
        self.mappedColorCounts = [:]
    }
    
    init(_ xOffset: Int, _ yOffset: Int, _ width: Int, _ height: Int, inColors: [CGColor], rowLength: Int, palette: Palette) {
        self.width = width;
        self.height = height
        
        self.uniqueColors = colors.count;
        
        self.colors = [];
        for y in 0..<16 {
            let baseIndex = (yOffset + y) * rowLength + xOffset; 
            for x in 0..<16 {
                let index = baseIndex + Int(x);
                
                var c = MultiColor(cgColor: inColors[index]); 
                let pIndex = palette.findClosest(c)
                c = pIndex >= 0 ? palette.get(pIndex).color : c;
                
                self.colors.append(c);
            }
        }
        
        //        self.mappedColorCounts = [:]
        var uniqueClrs: [MultiColor] = Array<MultiColor>(Set(self.colors))
        uniqueClrs.sort(by: { $0.hue > $1.hue})
        for clr in uniqueClrs {
            let count = self.colors.filter { $0.cgColor == clr.cgColor }.count
            mappedColorCounts[clr] = count
        }
    }
    
}
