import SwiftUI

struct BrickArtToolbar: View {
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var load: LoadInfo;
    @Binding var canvases: Canvases;
    @ObservedObject var source: SourceInfo;
    
    @State var showLicenseView: Bool = false;
    var onLoad: () -> Void = {};
    var onSave: () -> Void = {};
    var onClear: () -> Void = {};
    
    
    var body: some View {
        HStack {
            RoundedStateButton(systemName: "plus.square", action: { state.setNavState(.load); }, state: state.isNavState(.load), background: .gray)
            Divider()
            if (source.isImageSet) {
                RoundedStateButton(systemName: "photo.stack", action: { state.setNavState(.setup, true); }, state:  state.isNavState(.setup), background: .gray)
                    .disabled(!source.isImageSet)
                //                if (state.canvas?.analysis != nil) {
                RoundedStateButton(systemName: "list.bullet.below.rectangle", action: { state.setNavState(.analysis, true); }, state: state.isNavState(.analysis), background: .gray)
                    .disabled(state.canvas == nil)
                Divider()
            }
            Spacer()                
            
            Menu(content: {
                Button("Clear", systemImage: "trash.fill", action: onClear)
                
                Button("Load", systemImage: "square.and.arrow.up.fill", action: onLoad).disabled(true)
                Button("Save", systemImage: "square.and.arrow.down.fill", action: onSave).disabled(true)                    
            }, label: {
                RoundedButton(systemName: "ellipsis.circle", action: { })
            })
            RoundedButton(systemName: "info.circle", action: { showLicenseView = true })
        }
        .frame(maxHeight: 32)
        .sheet(isPresented: $showLicenseView, content: {
            AboutSheet(isOpen: $showLicenseView)
        })        
    }
}
