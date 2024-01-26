import SwiftUI

struct ColorListSheet: View {
    @EnvironmentObject var state: GlobalState;
    
    @Binding var isOpen: Bool
    @ObservedObject var canvas: ArtCanvas;
    
    var isWide: Bool = false 
    
    var body: some View {
        ZStack(alignment: Alignment.topLeading) {
            GroupView(label: { Text("Colors") }, content: {
                if (canvas.analysis != nil) {
                    ScrollView(content: {
                        ColorSwatchList(colorsWithCount: canvas.analysis!.colorInfo.mappedColorCounts, palette: state.palette, isWide: isWide)
                    })
                    Divider()
                    let differenceColors = getDifferenceMappedColors()
                    if (differenceColors.count > 0) {
                        Text("Colors not in your inventory '\(state.inventory.name)'")
                        ScrollView(content: {
                            ColorSwatchList(colorsWithCount: differenceColors, palette: state.palette, isWide: isWide)
                          
                            Divider()
                            Image(systemName: "lightbulb").padding()
                            Text("You can leave out '\(ArtPalette.Black)' when your backplates are black (Same for white or any other color).")
                        })
                        Spacer()
                    }
                } else {
                    Text("No image analysis available. Retry your last step.")
                }
            })
            HStack { Spacer()
                Button("Close", action: { isOpen = isOpen.not })    
            }.frameStretch(Alignment.topTrailing).padding()
        }.padding()
    }
    
    func getDifferenceMappedColors() -> Dictionary<MultiColor, Int> {
        guard let analysis = canvas.analysis else { return [:] }
        
        let colors = analysis.colorInfo.mappedColorCounts
        
        var result = Dictionary<MultiColor, Int>()
        for (color, qty) in colors {
            let pIndex: Int = state.palette.findClosest(color);
            let colorInfo = pIndex >= 0 ? state.palette.get(pIndex) : ArtColor(name: "none", color: color);
            let invItem = state.inventory.items.first { item in return item.name == colorInfo.name } ?? ArtInventory.Item("-", 0)
            if (invItem.name == colorInfo.name) {
                let newQty = qty - invItem.quantity
                if (newQty > 0) {
                    result[color] = newQty
                } else {
                    result.removeValue(forKey: color)
                }
            } else { 
                result[color] = qty
            }
        }    
        
        return result
    }
    
}





