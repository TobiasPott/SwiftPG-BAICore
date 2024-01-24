import SwiftUI

public struct ListFilter {
    public var filterBy: String
    public var sortBy: ListSortBy
    public var sortMode: ListSortMode
}

public enum ListSortBy: Int, Equatable, Codable {
    case name, quantity
}
public enum ListSortMode: Int, Equatable, Codable {
    case asc, desc
}

struct PreferencesSheet: View {
    @EnvironmentObject var state: GlobalState;
    
    @Binding var isOpen: Bool
    @ObservedObject var project: ArtProject
    
    
    @ObservedObject var inventory: ArtInventory = ArtInventory.empty
    
    var body: some View {
        ZStack {
            GroupView(label: { Text("Preferences") }, content: {
                Divider().padding(Edge.Set.bottom)
                GuideText(text: "Select the color palette you want to use. The first set of palettes is derived from Lego construction sets and the colors available in them, others origin from other color palettes like retro pcs, consoles or other media.\nThe preview will show you the colors included in each palette and your brick art will be limited to those colors.")
                paletteMenu
                
                // ToDo: Fully implement inventory handling in preferences (if possible)
                Divider()
                GuideText(text: "The inventory will be available in the future. Use it to track your bricks and check if your art work is possible or which bricks you are missing.")
                inventoryMenu
                
                Spacer()
            }).padding()
            
            
            HStack { Spacer()
                Button("Close", action: { isOpen = isOpen.not })    
            }.frameStretch(Alignment.topTrailing).padding().padding()
        }
        
    }
    
    var userModeMenu: some View {
        HStack(alignment: VerticalAlignment.center) {
            Text("Mode")
            
            RootView.spacerZeroLength
            UserModePicker(userMode: $state.userMode)
                .font(Styling.captionFont)
        }
    }
    
    var paletteMenu: some View {
        HStack(alignment: VerticalAlignment.top) {
            Text("Palette").frame(width: Styling.labelWidth, alignment: Alignment.leading)
            Spacer()
            VStack(alignment: HorizontalAlignment.trailing) {
                PalettePicker(selection: $project.builtInPalette)
                    .padding(Edge.Set.top, -6.0)
                PalettePreview(palette: state.palette, size: 14.0)
            }
        }.onChange(of: project.builtInPalette, perform: { value in
            state.palette = Palette.getPalette(project.builtInPalette)
        })
    }
    
    @State var filter: ListFilter = ListFilter(filterBy: "", sortBy: ListSortBy.name, sortMode: ListSortMode.asc)
    var inventoryMenu: some View {
        ScrollView(content: {
            VStack(alignment: HorizontalAlignment.leading) {
                HStack {
                    Text("Inventory").frame(width: Styling.labelWidth, alignment: Alignment.leading)
                    Spacer()
                    Text("All Colors").font(Styling.captionFont)
                    Image(systemName: "infinity")
                }
                .onAppear(perform: {
                    inventory.unload()
                })
                let inventoryNames: [String] = ["Default", ArtPalette.dcBatmanName, ArtPalette.mosaicMakerName, ArtPalette.worldMapName, ArtPalette.floarlArtName, ArtPalette.dotsName, ArtPalette.reducedName]
                
                ForEach(0..<inventoryNames.count, id: \.self) { i in
                    let invByName: ArtInventory = ArtInventory.inventory(inventoryNames[i])
                    let hasItems = invByName.items.count > 0
                    DisclosureGroup(
                        content: {
                            if (invByName.isEditable && invByName.name == inventory.name) {
                                Text("Editing...")
                                if (hasItems) { Divider() }
                            } else {
                                LazyVGrid(columns: [GridItem(.flexible())], content: {
                                    ForEach(0..<invByName.items.count, id: \.self) { j in
                                        InventoryItemEntry(item: invByName.items[j], quantity: invByName.items[j].quantity)
                                    }
                                })
                                .font(Styling.captionFont)
                                if (hasItems) { Divider() }
                            }
                        },
                        label: { 
                            HStack { 
                                Text(inventoryNames[i])
                                if (invByName.isEditable) {
                                    Spacer()
                                    Button(invByName.name == inventory.name ? "Save" : "Edit", action: {
                                        // ToDo: store back inventory before unloading
                                        if (invByName.name == inventory.name) {
                                            // load into edited inventory
                                            invByName.load(inventory)
                                            print(inventory.items)
                                            // store to user data (global inventory store)
                                            _ = ArtInventory.inventory(invByName.name, inventory: invByName)
                                            // unload working inventory
                                            inventory.unload()
                                        } else { inventory.load(invByName) }
                                    })
                                }
                            }
                        }
                    )
                    .font(Styling.subheadlineFont)
                    .padding(Edge.Set.top, -6)
                    
                    if (inventory.isEditable && invByName == inventory) {
                        
                        if (inventory.items.count > 0) {
                            Divider()
                                .padding(Edge.Set.bottom, 6)
                            HStack {
                                Spacer()
                                Button("Delete All", systemImage: "trash", role: ButtonRole.destructive, action: { inventory.items.removeAll(); })
                            }
                            Divider()
                        }
                        LazyVGrid(columns: [GridItem(.flexible())], content: {
                            ForEach(0..<inventory.items.count, id: \.self) { j in
                                let item: ArtInventory.Item = inventory.items[j]
                                InventoryItemEntry(item: item, quantity: item.quantity, isEditable: true, onEditQuantity: { qty in
                                    inventory.items[j].quantity = qty
                                }, onDelete: { inventory.items.remove(at: j) 
                                })
                            }
                        })
                        .font(Styling.captionFont)
                        
                        
                        Divider()
                        HStack { Text("Add by Name"); Spacer() }
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
                                            print("added: \(item.name) to \(inventory.items)")
                                        }).frame(maxWidth: CGFloat.infinity)
                                    }
                                }
                            })
                        })
                        .font(Styling.captionMono)
                        .frame(maxHeight: 115.0, alignment: Alignment.topLeading)   
                        
                        Divider()                        
                        HStack { Text("Add from Palette"); Spacer() }
                        
                        
                        ScrollView(content: {
                            LazyVGrid(columns: [GridItem(GridItem.Size.flexible())], content: {
                                
                                
                                ForEach(0..<inventoryNames.count, id: \.self) { k in
                                    let name = inventoryNames[k]
                                    Button(action: {
                                        // ToDo: check why changing quantity via 'add' does not affect refresh of list
                                        inventory.add(ArtInventory.inventory(name))
                                        if (inventory.items.count > 0) {
                                            inventory.items[0].quantity += 1
                                            inventory.items[0].quantity -= 1
                                        }
                                    }, label: {
                                        Text("Add \(name)")
                                    })
                                }
                            })
                        })
                    }
                }
                
                
                
            }
        })
    }
    
}

struct InventoryItemEntry: View {
    var item: ArtInventory.Item
    @State var quantity: Int = 0
    var isEditable: Bool = false
    
    var onEditQuantity: (Int) -> Void = { _ in }
    var onDelete: () -> Void = {}
    
    
    var body: some View {
        HStack(spacing: 4) {
            if (item.quantity <= -1) {
                Image(systemName: "infinity").frame(width: 50.0, alignment: Alignment.trailing)
            } else {
                if (isEditable) {
                    TextField("0", value: $quantity, formatter: NumberFormatter()).frame(width: 50.0, alignment: Alignment.trailing).multilineTextAlignment(.trailing)
                        .padding(2).background(Styling.panelColor).mask(Styling.roundedRect)
                        .onSubmit() { onEditQuantity(quantity) }
                    Text("x ")
                } else {
                    Text("\(quantity) x").frame(width: 50.0, alignment: Alignment.trailing)
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

struct ListFilterHeader: View {
    
    @Binding var filter: ListFilter
    let onFilterSubmit: () -> Void
    
    var body: some View {
        HStack {
            TextField("Filter", text: $filter.filterBy)
                .multilineTextAlignment(TextAlignment.leading)
                .padding(3.0).padding(Edge.Set.leading, 3.0)
                .background(Styling.black.opacity(0.25))
                .mask(Styling.roundedRect)
                .padding(Edge.Set.trailing, 6.0)
                .onSubmit(onFilterSubmit)
        }
    }
}
