import SwiftUI

struct InventoryItemEntry: View {
    @Binding var item: ArtInventory.Item
    var isEditable: Bool = false
    
    var onDelete: () -> Void = {}
    
    @State private var confirmDeletion: Bool = false
    
    var body: some View {
        HStack(spacing: 4) {
            //            if (item.quantity <= -1) {
            //                Image(systemName: "infinity").frame(width: 50.0, alignment: Alignment.trailing)
            //            } else {
            Group {
                if (isEditable) {
                    TextField("0", value: $item.quantity, formatter: NumberFormatter())
                        .frame(width: 50.0, alignment: Alignment.trailing)
                        .multilineTextAlignment(.trailing)
                        .padding(2).background(Styling.panelColor).mask(Styling.roundedRect)
                        .onSubmit() {
                            // clamp quantity to -1...Int.max
                            item.quantity = item.quantity.clamped(to: -1...Int.max)
                        }
                        .overlay(content: {
                            if (item.quantity <= -1) {
                                Image(systemName: "infinity")
                                    .frame(width: 50.0, alignment: Alignment.leading)
                                    .padding(Edge.Set.leading, 6)
                            }
                        })
                } else {
                    if (item.quantity <= -1) {
                        Image(systemName: "infinity")
                            .frame(width: 50.0, alignment: Alignment.trailing)
                            .padding(2)
                        //                            .padding(Edge.Set.leading, 6)
                    } else {
                        Text("\(item.quantity)")
                            .frame(width: 50.0, alignment: Alignment.trailing)
                            .padding(2)
                    }
                }
            } 
            
            Text("x ")
            //            }
            
            let artClr = ArtPalette.all.artColors.first { $0.name == item.name }!
            artClr.swuiColor.aspectRatio(1.5, contentMode: ContentMode.fill)
                .frameMax(32).mask(Styling.roundedRect)
            Text(item.name)
            Spacer()
            if (isEditable) {
                Button(role: .destructive, 
                       action: { confirmDeletion = true }, 
                       label: { Image(systemName: "trash") })
                .padding(Edge.Set.trailing)
                .confirmationDialog("Delete '\(item.name)'?", isPresented: $confirmDeletion, titleVisibility: Visibility.visible) {
                    Button("Yes, delete '\(item.name)'!", role: .destructive) { onDelete() }
                    Button("No, keep it.", role: .cancel) {}
                }
            }
        }
    }
}
