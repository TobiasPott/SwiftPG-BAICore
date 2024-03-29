import SwiftUI

struct CanvasesListPanel: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var source: ArtSource;
    @Binding var canvases: Canvases;
    
    @State var newCanvasWidth: Int = 3;
    @State var newCanvasHeight: Int = 3;
    
    
    var body: some View {
        
        
        GroupView(label: { Text("Canvases") }, content: { 
            HStack {
                CompactIconPicker(value: $newCanvasWidth, systemName: "arrow.left.and.right", content: {
                    ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                }, size: 16.0)
                    .padding(Edge.Set.trailing)
                CompactIconPicker(value: $newCanvasHeight, systemName: "arrow.up.and.down", content: {
                    ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                }, size: 16.0)
                
                RootView.spacerZeroLength
                RoundedButton(sName: "plus.app.fill", action: {
                    canvases.items.append(ArtCanvas(newCanvasWidth, newCanvasHeight, size: source.image.size));
                    if(state.canvas == nil) {
                        state.canvas = canvases.items[0];
                    }
                })
            }
        })
        
        VStack {
            ForEach(canvases.items, id: \.id) { canvas in
                Button(action: { 
                    if(canvas.equals(state.canvas)) {
                        state.canvas = nil
                    } else {
                        state.canvas = canvas;
                    }
                }, label: {
                    CanvasHeader(source: source, canvas: canvas, selected: canvas.equals(state.canvas)).padding(Edge.Set.vertical, 6.0)
                })
                .contextMenu(menuItems: {
                    Button("Delete", action: { 
                        canvases.items.removeAll(where: { item in item.equals(canvas) });
                        if(canvas.equals(state.canvas)) {
                            state.canvas = nil
                        }
                    })
                })
            }
            .onDelete(perform: delete)
        }
        .padding(Edge.Set.leading)
        .padding(Edge.Set.trailing, 6.0)
        
        // only display footer if list has items
        if (canvases.items.count > 0) {
            Divider()
            // bottom content
            HStack {
                RoundedButton(sName: "trash.circle", action: { 
                    canvases.items = []
                    state.canvas = nil
                }, background: Styling.red)
                RootView.spacerZeroLength
            }
            Divider()
        }
    }
    
    func delete(at offsets: IndexSet) {
        canvases.remove(atOffsets: offsets)
    }
    
}
