import SwiftUI
import SwiftPG_Palettes

struct PreferencesSheet: View {
    @EnvironmentObject var state: AppState;
    
    @Binding var isOpen: Bool
    
    
    var body: some View {
        ZStack {
            GroupBox(label: Text("Preferences"), content: {
                Text(" ")
                HStack(alignment: .center) {
                    Text("Mode")
                    Spacer(minLength: 0)
                    Picker(selection: $state.userMode, content: {
                        Label("Guided", systemImage: "info.bubble").tag(UserMode.guided)
                            .font(.system(size: 14))
                        Label("Simple", systemImage: "rectangle").tag(UserMode.simple)
                            .font(.system(size: 14))
                        Label("Advanced", systemImage: "rectangle.on.rectangle.badge.gearshape").tag(UserMode.advanced)
                            .font(.system(size: 14))
                    }, label: {
                    })
                }
                Divider()
                PalettePicker(selection: $state.builtInPalette)                    
                    .onChange(of: state.builtInPalette, perform: { value in
                    state.palette = Palette.getPalette(state.builtInPalette)
                })
                PalettePreview(palette: state.palette)
                
                Divider()
                Spacer()
            }).padding()
            
            
            HStack { Spacer()
                Button("Close", action: { isOpen.toggle() })    
            }.frameInfinity(.topTrailing).padding().padding()
        }
        
    }
    
}
