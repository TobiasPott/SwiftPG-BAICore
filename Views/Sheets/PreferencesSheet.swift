import SwiftUI

struct PreferencesSheet: View {
    @EnvironmentObject var state: GlobalState;
    
    @Binding var isOpen: Bool
    
    
    var body: some View {
        ZStack {
            GroupBox(label: Text("Preferences"), content: {
                Text(" ")
                GuideText(text: "'Guided' shows help info about your options and interaction with the app.\n'Simple' is meant to create a single instruction from your picture.\n'Advanced' enables additional options like image filters and multiple canvases.")
                userModeMenu
                Divider()        
                GuideText(text: "Select the color palette you want to use. The first set of palettes is derived from Lego construction sets and the colors available in them, others origin from other color palettes like retro pcs, consoles or other media.\nThe preview will show you the colors included in each palette and your brick art will be limited to those colors.")
                paletteMenu
                
                // ToDo: Fully implement inventory handling in preferences (if possible)
                Divider()
                inventoryMenu
            }).padding()
            
            
            HStack { Spacer()
                Button("Close", action: { isOpen.toggle() })    
            }.frameStretch(.topTrailing).padding().padding()
        }
        
    }
    
    var userModeMenu: some View {
        HStack(alignment: VerticalAlignment.center) {
            Text("Mode")
            Spacer(minLength: 0)
            UserModePicker(userMode: $state.userMode)
                .font(Styling.captionFont)
        }
    }
    
    var paletteMenu: some View {
        HStack(alignment: VerticalAlignment.top) {
            Text("Palette").frame(width: Styling.labelWidth, alignment: Alignment.leading)
            Spacer()
            VStack(alignment: HorizontalAlignment.trailing) {
                PalettePicker(selection: $state.builtInPalette)
                    .padding(.top, -6)
                PalettePreview(palette: state.palette, size: 14)
            }
        }.onChange(of: state.builtInPalette, perform: { value in
            state.palette = Palette.getPalette(state.builtInPalette)
        })
    }
    
    func inventoryItemEntry(_ i: Int) -> some View {
        let item = state.inventory.items[i]
        return HStack(spacing: 0) {
            TextField("", value: $state.inventory.items[i].quantity, format: .number)
                .multilineTextAlignment(.trailing)
                .padding(3).padding(.trailing, 3)
                .frame(width: Styling.labelWidth - 10)
                .background(.black.opacity(0.25))
                .mask(Styling.roundedRect)
                .padding(.trailing, 6)
            Text("\(item.name)").allowsTightening(true).truncationMode(.tail)
        }
    }
    @State var inventoryItemSelection: String = ""
    @State var inventoryFilter: String = ""
    func inventorySelection() -> some View {
        return Picker(selection: $inventoryItemSelection, content: {
            ForEach(ArtPalette.all.artColors) { item in
                if (!state.inventory.contains(item.name)) {
                    HStack {
                        Text("\(item.name)")
                        Spacer()
                        item.swuiColor.aspectRatio(1.0, contentMode: .fit)
                    }
                    .tag(item.name)
                }
            }
            
        }, label: {
            //            Text("Add")
        }).pickerStyle(.wheel)
        //            .frame(width: 180)
            .frame(maxHeight: 100)
        
    }
    
    var inventoryMenu: some View {
        Group {
            VStack(alignment: HorizontalAlignment.leading) {
                HStack {
                    Text("Inventory").frame(width: Styling.labelWidth, alignment: Alignment.leading)
                    Spacer()
                    Button("", systemImage: "square.and.arrow.down", action: { 
                        state.inventory.load(state.palette) })
                }
                //                VStack(alignment: HorizontalAlignment.leading) {
                //                    Text("\(state.inventory.name)")
                ScrollView(content: {
                    VStack (alignment: HorizontalAlignment.leading, spacing: 4) {
                        
                        // ToDo: check how to reset focus to textfield on successfull submit
                        // ToDo: Add sorting options (by name/quantity, asc/desc)
                        // ToDo: Add deletion
                        // ToDo: Change filter to filter both existing/available lists
                        
                        TextField("Filter", text: $inventoryFilter)
                            .multilineTextAlignment(.leading)
                            .padding(3).padding(.leading, 3)
                            .background(.black.opacity(0.25))
                            .mask(Styling.roundedRect)
                            .padding(.trailing, 6)
                            .onSubmit() {
                                let newName = inventoryFilter 
                                if (ArtPalette.all.artColors.contains(where: { $0.name == newName}) && !state.inventory.contains(newName)) {
                                    state.inventory.items.append(ArtInventory.Item(newName, 0))
                                    inventoryFilter = ""
                                }
                            }
                        
                        ForEach(state.inventory.items) { item in
                            let i = state.inventory.items.firstIndex(of: item) ?? -1
                            if (i >= 0) { inventoryItemEntry(i) }
                        }
                        Divider()
                        
                        TextField("Filter", text: $inventoryFilter)
                            .multilineTextAlignment(.leading)
                            .padding(3).padding(.leading, 3)
                            .background(.black.opacity(0.25))
                            .mask(Styling.roundedRect)
                            .padding(.trailing, 6)
                            .onSubmit() {
                                let newName = inventoryFilter 
                                if (ArtPalette.all.artColors.contains(where: { $0.name == newName}) && !state.inventory.contains(newName)) {
                                    state.inventory.items.append(ArtInventory.Item(newName, 0))
                                    inventoryFilter = ""
                                }
                            }
                        
                        let filteredColors = ArtPalette.all.artColors.filter({ inventoryFilter.isEmpty || $0.name.lowercased().contains(inventoryFilter.lowercased()) })
                        let limitedColors = filteredColors.prefix(10)
                        
                        ForEach(limitedColors) { item in
                            if (!state.inventory.contains(item.name)) {
                                Button("\(item.name)", action: { state.inventory.items.append(ArtInventory.Item(item.name, 0))  })
                            }
                        }
                        if (limitedColors.count >= 10) { 
                            Text("...")
                        }
                    }
                }).font(Styling.captionFont.monospaced())
            }
        }
    }
    
}
