import SwiftUI
import SwiftPG_CIFilters

struct SourceFilterListPanel: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var source: ArtSource;
    
    
    
    var body: some View {
        let addFilterMenu = Menu(content: {
            Button("Scale", action: {source.filters.append(Filter.scale(inScale: 1.0))})
            Button("Posterize", action: {source.filters.append(Filter.posterize(inInputLevels: 32.0))})
            Button("XRay", action: {source.filters.append(Filter.xray())})
            Button("Thermal", action: {source.filters.append(Filter.thermal())})
            Button("Comic Effect", action: {source.filters.append(Filter.comicEffect())})
            Button("Sepia Tone", action: {source.filters.append(Filter.sepiaTone(inInputIntensity: 1.0))})
            Button("Hue Adjust", action: {source.filters.append(Filter.hueAdjust(inInputAngle: 0.0))})
        }, label: {
            RoundedButton(systemName: "plus.app.fill", action: { })
        })
        
        
        
        GroupBox("Filters", content: { })
            .overlay(content: {
                HStack {
                    Spacer()
                    addFilterMenu
                }.padding(Edge.Set.trailing)
                
            })
        let bgColor: Color = Styling.black.opacity(0.01)
        VStack {
            ForEach(0..<source.filters.count, id: \.self) { i in
                FilterView(filter: $source.filters[i])
                    .background(bgColor)
                    .contextMenu(menuItems: {
                        Button("Delete", action: { source.filters.remove(at: i) })
                    })
            }
            .onDelete(perform: deleteFilter)
        }
        .frame(maxWidth: CGFloat.infinity)    
        // only display footer if list has items
        if (source.filters.count > 0) {
            Divider()
            HStack {
                RoundedButton(systemName: "trash.circle", action: { source.filters.reset() }, background: Styling.red)
                Spacer()
                RoundedButton(systemName: "arrow.counterclockwise.square.fill", action: { source.resetImage(); }, background: Styling.red).rotationEffect(Angle.degrees(-180))
                RoundedButton(systemName: "play.square.fill", action: { source.applyFilter(); })
            }
            Divider()
        }
    }
    
    func deleteFilter(at offsets: IndexSet) {
        source.filters.remove(atOffsets: offsets)
    }
    
}
