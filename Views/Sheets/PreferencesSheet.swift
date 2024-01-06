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
                GuideText(text: "The inventory will be available in the future. Use it to track your bricks and check if your art work is possible or which bricks you are missing.")
                inventoryMenu
                
                Spacer()
            }).padding()
            
            
            HStack { Spacer()
                Button("Close", action: { isOpen.toggle() })    
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
                PalettePicker(selection: $state.builtInPalette)
                    .padding(Edge.Set.top, -6.0)
                PalettePreview(palette: state.palette, size: 14.0)
            }
        }.onChange(of: state.builtInPalette, perform: { value in
            state.palette = Palette.getPalette(state.builtInPalette)
        })
    }
    
    @State var filter: ListFilter = ListFilter(filterBy: "", sortBy: ListSortBy.name, sortMode: ListSortMode.asc)
    var inventoryMenu: some View {
        Group {
            VStack(alignment: HorizontalAlignment.leading) {
                HStack {
                    Text("Inventory").frame(width: Styling.labelWidth, alignment: Alignment.leading)
                    Spacer()
                    Text("Uses Palette").font(Styling.captionFont)
                }
                
                // ToDo: check how to reset focus to textfield on successfull submit
                // ToDo: Add deletion from active inventory
                
                DisclosureGroup("Active inventory") {
                    Divider()
                    ScrollView(content: {
                        
                        VStack (alignment: HorizontalAlignment.leading, spacing: 4.0) {
                            ForEach(state.inventory.items) { item in
                                let i = state.inventory.items.firstIndex(of: item) ?? -1
                                if (i >= 0) { inventoryItemEntry($state.inventory.items[i]) }
                            }
                        }
                        .frame(maxWidth: CGFloat.infinity)
                        .font(Styling.captionFont.monospaced())
                    })
                    .frame(maxHeight: state.inventory.items.count > 0 ? 115.0 : 0.0, alignment: Alignment.topLeading)
                    Divider()
                }.disabled(true)
                DisclosureGroup("Add from Palette") {
                    Divider()
                    ListFilterHeader(filter: $filter, onFilterSubmit: {
                        let newName = filter.filterBy
                        if (ArtPalette.all.artColors.contains(where: { $0.name == newName}) && !state.inventory.contains(newName)) {
                            state.inventory.items.append(ArtInventory.Item(newName, 0))
                            filter.filterBy = ""
                        }
                    })
                    
                    ScrollView(content: {
                        
                        let filteredColors = ArtPalette.all.artColors.filter({ filter.filterBy.isEmpty || $0.name.lowercased().contains(filter.filterBy.lowercased()) })
                        LazyVGrid(columns: [GridItem(GridItem.Size.flexible()), GridItem(GridItem.Size.flexible())], content: {
                            
                            ForEach(filteredColors) { item in
                                if (!state.inventory.contains(item.name)) {
                                    Button("\(item.name)", action: { state.inventory.items.append(ArtInventory.Item(item.name, 0))  }).frame(maxWidth: CGFloat.infinity)
                                }
                            }
                        })
                    })
                    .font(Styling.captionFont.monospaced())
                    .frame(maxHeight: 115.0, alignment: Alignment.topLeading)   
                }.disabled(true)
            }
        }
    }
    
    func inventoryItemEntry(_ item: Binding<ArtInventory.Item>) -> some View {
        //        let item = state.inventory.items[i]
        return HStack(spacing: 0.0) {
            TextField("", value: item.quantity, format: .number)
                .multilineTextAlignment(TextAlignment.trailing)
                .padding(3.0).padding(Edge.Set.trailing, 3.0)
                .frame(width: Styling.labelWidth / 1.25 - 10.0)
                .background(Color.black.opacity(0.25))
                .mask(Styling.roundedRect)
                .padding(Edge.Set.trailing, 6.0)
            Text("\(item.name.wrappedValue)")
                .allowsTightening(true).truncationMode(Text.TruncationMode.tail)
            Spacer()
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
                .background(Color.black.opacity(0.25))
                .mask(Styling.roundedRect)
                .padding(Edge.Set.trailing, 6.0)
                .onSubmit(onFilterSubmit)
        }
    }
}
