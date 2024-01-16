import SwiftUI

struct Grid: View {
    
    let rows: CGFloat
    let cols: CGFloat
    let gridColor: Color
    let lineWidth: CGFloat;
    
    
    init(cols: CGFloat, rows: CGFloat, gridColor: Color, lineWidth: CGFloat = 2.0) {
        self.cols = cols;
        self.rows = rows;
        self.gridColor = gridColor;
        self.lineWidth = lineWidth
    }
    init(_ colsAndRows: CGFloat, gridColor: Color, lineWidth: CGFloat = 2.0) {
        self.rows = colsAndRows;
        self.cols = colsAndRows;
        self.gridColor = gridColor;
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let width = geometry.size.width
            let height = geometry.size.height
            let xSpacing = width / cols
            let ySpacing = height / rows
            
            
            Path { path in
                
                for index in 0...Int(cols) {
                    let vOffset: CGFloat = CGFloat(index) * xSpacing
                    path.move(to: CGPoint(x: vOffset, y: 0))
                    path.addLine(to: CGPoint(x: vOffset, y: height))
                }
                for index in 0...Int(rows) {
                    let hOffset: CGFloat = CGFloat(index) * ySpacing
                    path.move(to: CGPoint(x: 0, y: hOffset))
                    path.addLine(to: CGPoint(x: width, y: hOffset))
                }
            }
            .stroke(gridColor, lineWidth: self.lineWidth)
        }
    }
    
}

struct BlueprintGrid: View {
    public static let lineColor: Color = Styling.white.opacity(0.25)
    
    var baseSpacing: CGFloat = 128.0;
    var lineWidth: CGFloat = 2.0;
    
    var body: some View {
        ZStack(alignment: Alignment.center) {
            Styling.blueprintColor
            Grid(baseSpacing, gridColor: BlueprintGrid.lineColor, lineWidth: lineWidth)
            Grid(baseSpacing / 4.0, gridColor: BlueprintGrid.lineColor, lineWidth: lineWidth)
        }
        .aspectRatio(1.0, contentMode: ContentMode.fit)
    }
}

