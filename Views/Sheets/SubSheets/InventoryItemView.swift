import SwiftUI

struct InventoryItemEntry: View {
    @Binding var item: ArtInventory.Item
    var isEditable: Bool = false
    
    var onDelete: () -> Void = {}
    
    
    var body: some View {
        HStack(spacing: 4) {
            if (item.quantity <= -1) {
                Image(systemName: "infinity").frame(width: 50.0, alignment: Alignment.trailing)
            } else {
                if (isEditable) {
                    TextField("0", value: $item.quantity, formatter: NumberFormatter()).frame(width: 50.0, alignment: Alignment.trailing).multilineTextAlignment(.trailing)
                        .padding(2).background(Styling.panelColor).mask(Styling.roundedRect)
                    //                        .onSubmit() { onEditQuantity(quantity) }
                    Text("x ")
                } else {
                    Text("\(item.quantity)").frame(width: 50.0, alignment: Alignment.trailing)
                        .padding(2)
                    Text("x ")
                }
            }
            let artClr = ArtPalette.all.artColors.first { $0.name == item.name }!
            artClr.swuiColor.aspectRatio(1.5, contentMode: ContentMode.fill)
                .frameMax(32).mask(Styling.roundedRect)
            Text(item.name)
            Spacer()
            if (isEditable) {
                Button(role: .destructive, action: {
                    onDelete()
                }, label: {
                    Image(systemName: "trash")
                }).padding(Edge.Set.trailing)
            }
        }
    }
}
