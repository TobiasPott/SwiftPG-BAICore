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
                
//                
//                HStack(alignment: VerticalAlignment.center) {
//                    Text("Inventory")
//                    Spacer(minLength: 0)
//                    UserModePicker(userMode: $state.userMode)
//                        .font(Styling.captionFont)
//                }
                Spacer()
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
    
}
