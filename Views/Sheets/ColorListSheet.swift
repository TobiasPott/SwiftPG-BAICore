import SwiftUI

struct ColorListSheet: View {
    @EnvironmentObject var state: GlobalState;
    
    @Binding var isOpen: Bool
    @ObservedObject var canvas: ArtCanvas;
    
    var isWide: Bool = false 
    
    var body: some View {
        ZStack(alignment: Alignment.topLeading) {
            GroupBox(label: Text("Colors"), content: {
                if (canvas.analysis != nil) {
                    ScrollView(content: {
                        ColorSwatchList(colorsWithCount: canvas.analysis!.colorInfo.mappedColorCounts, palette: state.palette, isWide: isWide)
                    })
                } else {
                    Text("No image analysis available. Retry your last step.")
                }
            })
            HStack { Spacer()
                Button("Close", action: { isOpen = isOpen.not })    
            }.frameStretch(Alignment.topTrailing).padding()
        }.padding()
    }
    
}
