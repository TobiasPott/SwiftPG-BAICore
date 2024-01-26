import SwiftUI

struct InventoryEdit_Delete: View {
    @EnvironmentObject var state: GlobalState
    
    @ObservedObject var inventory: ArtInventory = ArtInventory.empty
    let index: Int
    
    var onDelete: (String) -> Void = { _ in }
    
    @State private var confirmDeletion: Bool = false
    
    var body: some View {
        Button(role: ButtonRole.destructive, action: {
            confirmDeletion = true
        }, label: {
            Text("Delete '\(inventory.name)'")
        })
        .confirmationDialog("Delete '\(inventory.name)' inventory?", isPresented: $confirmDeletion, titleVisibility: Visibility.visible) {
            Button("Yes, delete '\(inventory.name)'!", role: .destructive) { deleteInventory() }
            Button("No, keep it.", role: .cancel) {}
        }
        .disabled(inventory.name == ArtInventory.nameDefault)
        .frameStretch(Alignment.center)
    }
    
    func deleteInventory() {
        let name = inventory.name
        var userInv = UserData.userInventories()
        userInv.remove(at: index)
        UserData.userInventories(userInv)
        inventory.unload()
        
        var activeInv = UserData.activeInventory()
        if (activeInv == inventory.name) {
            activeInv = ArtInventory.nameDefault
            UserData.activeInventory(activeInv)
        }
        // invoke callback
        onDelete(name)
    }
}

struct InventoryEdit_AddByColorName: View {
    @ObservedObject var inventory: ArtInventory = ArtInventory.empty
    
    @State var filter: ListFilter = ListFilter(filterBy: "", sortBy: ListSortBy.name, sortMode: ListSortMode.asc)
    
    var body: some View {
        DisclosureGroup(
            content: { 
                ListFilterHeader(filter: $filter, onFilterSubmit: {
                    let newName = filter.filterBy
                    if (ArtPalette.all.artColors.contains(where: { $0.name == newName}) && inventory.isEditable && !inventory.contains(newName)) {
                        inventory.items.insert(ArtInventory.Item(newName, 0), at: 0)
                        filter.filterBy = ""
                    }
                })
                ScrollView(content: {
                    let filteredColors = ArtPalette.all.artColors.filter({ filter.filterBy.isEmpty || $0.name.lowercased().contains(filter.filterBy.lowercased()) })
                    LazyVGrid(columns: [GridItem(GridItem.Size.flexible()), GridItem(GridItem.Size.flexible())], content: {
                        
                        ForEach(filteredColors) { item in
                            if (inventory.isEditable && !inventory.contains(item.name)) {
                                Button("\(item.name)", action: {
                                    inventory.items.append(ArtInventory.Item(item.name, 0))
                                })
                            }
                        }
                    })
                })
                .font(Styling.captionMono)
                .frame(maxHeight: 115.0, alignment: Alignment.topLeading)   
                
            },
            label: { 
                Text("Add color by Name")
            }
        )
        .font(Styling.subheadlineFont)
        Divider()
    }
}


struct InventoryEdit_AddOtherInventory: View {
    @ObservedObject var inventory: ArtInventory = ArtInventory.empty
    let names: [String]
    
    
    @State private var confirmAdd: Bool = false
    @State private var confirmName: String = ""
    
    var body: some View {
        DisclosureGroup(
            content: { 
                ScrollView(content: {
                    LazyVGrid(columns: [GridItem(GridItem.Size.flexible())], content: {
                        ForEach(0..<names.count, id: \.self) { i in
                            let name = names[i]
                            Button(action: { 
                                confirmName = name
                                confirmAdd = true
                            }, label: {
                                HStack { Text("\(name)"); Spacer() }.padding(Edge.Set.leading)
                            })
                            .padding(1)
                            .confirmationDialog("Add '\(confirmName)' to '\(inventory.name)'?", isPresented: $confirmAdd, titleVisibility: Visibility.visible) {
                                Button("Yes, add '\(confirmName)'!") { inventory.add(ArtInventory.inventory(confirmName)) }
                                Button("No, don't add it.", role: .cancel) {}
                            }
                        }
                    })
                    
                })
                .padding(Edge.Set.top, 6)
            },
            label: { 
                Text("Add other Inventory")
            }
        )
        .font(Styling.subheadlineFont)
        Divider()
    }
    
}
