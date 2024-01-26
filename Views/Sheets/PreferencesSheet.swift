import SwiftUI


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
                    let isSelectedForEdit = name == inventory.name && inventory.isEditable
                    DisclosureGroup(
                        content: { 
                            InventoryReadView(editableInventory: inventory, invByName: invByName)
                            if (isSelectedForEdit) {
                                InventoryEditView(editableInventory: inventory)
                                Divider()
                            }
                        },
                        label: {
                            InventoryEditHeader(editableInventory: inventory, invByName: invByName).font(Styling.subheadlineFont)
                        }
                    )
                    
                    Group {
                        if (isSelectedForEdit) {
                            InventoryEdit_AddByColorName(inventory: inventory)
                            InventoryEdit_AddOtherInventory(inventory: inventory, names: inventoryNames)
                            InventoryEdit_Delete(inventory: inventory, index: i, onDelete: { invName in 
                                if (state.inventoryName == invName) {
                                    state.inventoryName = ArtInventory.nameDefault
                                    state.inventory.load(ArtInventory.inventory(ArtInventory.nameDefault))
                                }
                            })
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
