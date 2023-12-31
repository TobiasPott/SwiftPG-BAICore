import SwiftUI

struct CanvasesListPanel: View {
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var source: ArtSource;
    @Binding var canvases: Canvases;
    
    @State var newCanvasWidth: Int = 3;
    @State var newCanvasHeight: Int = 3;
    
    
    var body: some View {
        
        
        GroupBox("Canvases", content: { 
            HStack {
                CompactIconPicker(value: $newCanvasWidth, systemName: "arrow.left.and.right", content: {
                    ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                }, size: 16)
                    .padding(.trailing)
                CompactIconPicker(value: $newCanvasHeight, systemName: "arrow.up.and.down", content: {
                    ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                }, size: 16)
                
                Spacer(minLength: 0)
                RoundedButton(systemName: "plus.app.fill", action: {
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
                    CanvasHeader(source: source, canvas: canvas, selected: canvas.equals(state.canvas)).padding(.vertical, 6)
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
        .padding(.leading)
        .padding(.trailing, 6)
        
        // only display footer if list has items
        if (canvases.items.count > 0) {
            Divider()
            // bottom content
            HStack {
                RoundedButton(systemName: "trash.circle", action: { 
                    canvases.items = []
                    state.canvas = nil
                }, background: Styling.red)
                Spacer(minLength: 0)
            }
            Divider()
        }
    }
    
    func delete(at offsets: IndexSet) {
        canvases.remove(atOffsets: offsets)
    }
    
}
