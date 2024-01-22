import SwiftUI

struct PaletteRowPreview: View { 
    let palette: Palette;
    
    var max: Int = 24 
    let size: CGFloat
    
    var body: some View {
        GeometryReader(content: { geometry in
            let cMin = min(palette.count, Int(floor(geometry.size.width / (size + 2.0))))
            let isCapped = (CGFloat(cMin) * (size + 2.0)) >= CGFloat(geometry.size.width - 8.0)
            let nMin = cMin - (isCapped ? Int(ceil(50.0 / size)) : 0) 
            let overhang = palette.count - nMin
            let fMax = (overhang > 0 ? nMin : cMin)
            ZStack {
                LazyVGrid(columns: [GridItem(GridItem.Size.adaptive(minimum: size, maximum: size), spacing: 2.0)]) {
                    ForEach(0..<fMax, id: \.self) { i in
                        palette.artColors[i].swuiColor.frameSquare(size)
                            .mask(Styling.roundedRectHalf)
                    }
                }
                
                if (overhang > 0) {
                    Text(" \(fMax) of \(palette.count) ")
                        .font(Styling.caption2Font)
                        .background(Styling.black.opacity(0.65))
                        .mask(Styling.roundedRect)
                        .frameRow(CGFloat.infinity, Alignment.trailing)
                }
            }
        })
        
    }
    
}
