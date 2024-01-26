import SwiftUI

struct InventoryEditableGroup: View {    
    @ObservedObject var editableInventory: ArtInventory = ArtInventory.empty
    let invByName: ArtInventory
    
    var body: some View {
        DisclosureGroup(
            content: { InventoryReadView(editableInventory: editableInventory, invByName: invByName) },
            label: { InventoryEditHeader(editableInventory: editableInventory, invByName: invByName) }
        )
        .font(Styling.subheadlineFont)
        
        let isSelectedForEdit = invByName.name == editableInventory.name
        if (editableInventory.isEditable && isSelectedForEdit) {
            InventoryEditView(editableInventory: editableInventory)
            Divider()
        }
    }
}

struct InventoryEditView: View {    
    @ObservedObject var editableInventory: ArtInventory = ArtInventory.empty
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], content: {
            ForEach(0..<editableInventory.items.count, id: \.self) { j in
                InventoryItemEntry(item: $editableInventory.items[j], isEditable: true, onDelete: { editableInventory.items.remove(at: j) 
                })
            }
        })
        .font(Styling.captionFont)
    }
}

struct InventoryReadView: View {
    @ObservedObject var editableInventory: ArtInventory = ArtInventory.empty
    let invByName: ArtInventory
    
    var body: some View {
        let hasItems = invByName.items.count > 0
        let isSelectedForEdit = invByName.name == editableInventory.name
        
        if (!(invByName.isEditable && isSelectedForEdit)) {
            if (!hasItems) { Text("Nothing here. Tap 'edit' and add some colors.").font(Styling.captionFont) }
            Divider()
            LazyVGrid(columns: [GridItem(.flexible())], content: {
                ForEach(0..<invByName.items.count, id: \.self) { j in
                    InventoryItemEntry(item: .constant(invByName.items[j]))
                }
            })
            .font(Styling.captionFont)
            if (hasItems) { Divider() }
        } else {
            Divider()
        }
    }
}

struct InventoryEditHeader: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var editableInventory: ArtInventory = ArtInventory.empty
    let invByName: ArtInventory
    
    var onEdit: () -> Void = {}
    
    var body: some View {
        HStack { 
            let isSelectedForEdit = invByName.name == editableInventory.name
            let isEditable = invByName.isEditable
            if (isEditable) {
                Button(
                    action: { state.inventoryName = invByName.name }, 
                    label: { Image(systemName: state.inventoryName == invByName.name ? "checkmark.circle.fill" : "circle") }
                )
            }
            Text(invByName.name)
            let itemCountStr = isSelectedForEdit ? "editing..." : (invByName.items.count > 0 ? "\(invByName.items.count)" : "empty")
            Text("(\(itemCountStr))").foregroundColor(Styling.secondary).font(Styling.caption2Font)
            
            if (isEditable) {
                Spacer()
                
                if (isSelectedForEdit && editableInventory.items.count > 0) {
                    Button("All", systemImage: "trash", role: ButtonRole.destructive, action: { editableInventory.items = []; })
                }
                Button(isSelectedForEdit ? "Save" : "Edit", action: {
                    //                    onEdit()
                    // ToDo: store back inventory before unloading
                    if (isSelectedForEdit) {
                        // store to user data (global inventory store)
                        _ = ArtInventory.inventory(editableInventory.name, inventory: editableInventory)
                        // unload working inventory
                        editableInventory.unload()
                    } else {
                        editableInventory.load(invByName) 
                    }
                }).frame(width: 35.0, alignment: Alignment.trailing)
            }
        }
    }
}


