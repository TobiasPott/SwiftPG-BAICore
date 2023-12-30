import SwiftUI
import SwiftPG_Palettes

struct PreferencesSheet: View {
    @EnvironmentObject var state: AppState;
    
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
                Spacer()
            }).padding()
            
            
            HStack { Spacer()
                Button("Close", action: { isOpen.toggle() })    
            }.frameInfinity(.topTrailing).padding().padding()
        }
        
    }
    
    var userModeMenu: some View {
        HStack(alignment: .center) {
            Text("Mode")
            Spacer(minLength: 0)
            UserModePicker(userMode: $state.userMode)
                .font(Styling.captionFont)
        }
    }
    
    var paletteMenu: some View {
        HStack(alignment: .top) {
            Text("Palette").frame(width: Styling.labelWidth, alignment: .leading)
            Spacer()
            VStack(alignment: .trailing) {
                PalettePicker(selection: $state.builtInPalette)
                    .padding(.top, -6)
                PalettePreview(palette: state.palette, size: 10)
            }
        }.onChange(of: state.builtInPalette, perform: { value in
            state.palette = Palette.getPalette(state.builtInPalette)
        })
    }
    
}
