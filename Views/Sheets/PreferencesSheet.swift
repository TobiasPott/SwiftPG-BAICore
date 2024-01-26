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
    
    @StateObject public var inventory: ArtInventory = ArtInventory.empty
    
    @State var newInventoryName: String = ""
    var inventoryNames: [String] { get {
        var names = UserData.userInventories()
        names.append(contentsOf: UserData.systemInventories())
        return names
    } }
    
    
    var body: some View {
        ZStack {
            GroupView(label: { Text("Preferences") }, content: {
                Divider().padding(Edge.Set.bottom)
                GuideText(text: "Select the color palette you want to use. The first set of palettes is derived from Lego construction sets and the colors available in them, others origin from other color palettes like retro pcs, consoles or other media.\nThe preview will show you the colors included in each palette and your brick art will be limited to those colors.")
                paletteMenu
                Divider()
                    .padding(Edge.Set.bottom)
                GuideText(text: "The inventory will be available in the future. Use it to track your bricks and check if your art work is possible or which bricks you are missing.")
                inventoryMenu
                Divider()
                    .padding(Edge.Set.bottom)
                
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
    
    var inventoryMenu: some View {
        ScrollView(content: {
            VStack(alignment: HorizontalAlignment.leading) {
                HStack {
                    Text("Your Inventories")
                    Spacer()
                    Text("Active: '\(state.inventory.name)'").font(Styling.captionFont)
                }
                .padding(Edge.Set.bottom, 6)
                .onAppear(perform: {
                    inventory.unload()
                })
                
                let userInv = UserData.userInventories()
                ForEach(0..<userInv.count, id: \.self) { i in
                    let name = userInv[i]
                    let invByName: ArtInventory = ArtInventory.inventory(name)
                    let isSelectedForEdit = name == inventory.name
                    DisclosureGroup(
                        content: { 
                            InventoryReadView(editableInventory: inventory, invByName: invByName)
                            if (inventory.isEditable && isSelectedForEdit) {
                                InventoryEditView(editableInventory: inventory)
                                Divider()
                            }
                        },
                        label: {
                            InventoryEditHeader(editableInventory: inventory, invByName: invByName).font(Styling.subheadlineFont)
                        }
                    )
                    
                    Group {
                        if (inventory.isEditable && isSelectedForEdit) {
                            InventoryEdit_AddByName(editableInventory: inventory)
                            InventoryEdit_AddPalette(editableInventory: inventory, names: inventoryNames)
                            InventoryEdit_Delete(editableInventory: inventory, index: i)
                                .padding(Edge.Set.bottom)
                            
                        }
                    }
                    .padding(Edge.Set.leading)
                }
                Divider()
                    .padding(Edge.Set.vertical)
                Text("Add a new Inventory")
                HStack {
                    TextField("Inventory Name", text: $newInventoryName)
                    Button("Add", action: {
                        var userInv = UserData.userInventories()
                        if (!newInventoryName.isEmpty
                            && !userInv.contains(where: { $0 == newInventoryName })) {
                            let newInv = ArtInventory.inventory(newInventoryName, inventory: ArtInventory(name: newInventoryName, items: []))
                            userInv.append(newInventoryName)
                            UserData.userInventories(userInv)
                            inventory.load(newInv)
                            newInventoryName = ""
                        }
                    })
                }.padding(Edge.Set.horizontal)
                
                Divider()
                    .padding(Edge.Set.vertical)
                Text("System Inventories")
                let sysInv = UserData.systemInventories()
                ForEach(0..<sysInv.count, id: \.self) { i in
                    let name = sysInv[i]
                    let invByName: ArtInventory = ArtInventory.inventory(name)
                    InventoryEditableGroup(editableInventory: inventory, invByName: invByName)
                        .padding(Edge.Set.leading)
                }
                
            }
        })
    }
    
}
struct InventoryEdit_Delete: View {
    @ObservedObject var editableInventory: ArtInventory = ArtInventory.empty
    let index: Int
    
    var body: some View {
        Button(role: ButtonRole.destructive, action: {
            var userInv = UserData.userInventories()
            userInv.remove(at: index)
            UserData.userInventories(userInv)
            editableInventory.unload()
        }, label: {
            Text("Delete inventory")
        })
        .disabled(editableInventory.name == ArtInventory.nameDefault)
        .frameStretch(Alignment.center)
    }
    
}

struct InventoryEdit_AddByName: View {
    @ObservedObject var editableInventory: ArtInventory = ArtInventory.empty
    
    @State var filter: ListFilter = ListFilter(filterBy: "", sortBy: ListSortBy.name, sortMode: ListSortMode.asc)
    
    var body: some View {
        DisclosureGroup(
            content: { 
                ListFilterHeader(filter: $filter, onFilterSubmit: {
                    let newName = filter.filterBy
                    if (ArtPalette.all.artColors.contains(where: { $0.name == newName}) && editableInventory.isEditable && !editableInventory.contains(newName)) {
                        editableInventory.items.insert(ArtInventory.Item(newName, 0), at: 0)
                        filter.filterBy = ""
                    }
                })
                ScrollView(content: {
                    let filteredColors = ArtPalette.all.artColors.filter({ filter.filterBy.isEmpty || $0.name.lowercased().contains(filter.filterBy.lowercased()) })
                    LazyVGrid(columns: [GridItem(GridItem.Size.flexible()), GridItem(GridItem.Size.flexible())], content: {
                        
                        ForEach(filteredColors) { item in
                            if (editableInventory.isEditable && !editableInventory.contains(item.name)) {
                                Button("\(item.name)", action: {
                                    editableInventory.items.append(ArtInventory.Item(item.name, 0))
                                })
                            }
                        }
                    })
                })
                .font(Styling.captionMono)
                .frame(maxHeight: 115.0, alignment: Alignment.topLeading)   
                
            },
            label: { 
                Text("Add by name").foregroundColor(Styling.primary)
            }
        )
        Divider()
    }
}


struct InventoryEdit_AddPalette: View {
    @ObservedObject var editableInventory: ArtInventory = ArtInventory.empty
    let names: [String]
    
    var body: some View {
        DisclosureGroup(
            content: { 
                ScrollView(content: {
                    LazyVGrid(columns: [GridItem(GridItem.Size.flexible())], content: {
                        ForEach(0..<names.count, id: \.self) { i in
                            let name = names[i]
                            Button(action: {
                                editableInventory.add(ArtInventory.inventory(name))
                            }, label: {
                                HStack { Text("\(name)"); Spacer() }.padding(Edge.Set.leading)
                            })
                            .padding(1)
                            .font(Styling.subheadlineFont)
                        }
                    })
                })
                .padding(Edge.Set.top, 6)
            },
            label: { 
                Text("Add Palette").foregroundColor(Styling.primary)
            })
        Divider()
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
