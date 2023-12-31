import SwiftUI

struct MenuToolbar: View {
    @EnvironmentObject var state: AppState;
    
    var isImageSet: Bool = false;
    @State var showAbout: Bool = false;
    @State var showSourceCode: Bool = false;
    @State var showFeedback: Bool = false;
    @State var showPreferences: Bool = false;
    var onLoad: () -> Void = {};
    var onSave: () -> Void = {};
    var onClear: () -> Void = {};
    
    
    var body: some View {
        HStack {
            RoundedStateButton(systemName: "plus.square", action: { state.setNavState(.load); }, state: state.isNavState(.load), background: Styling.gray)
            Divider()
            if (isImageSet) {
                RoundedStateButton(systemName: "photo.stack", action: { state.setNavState(.setup, true); }, state:  state.isNavState(.setup), background: Styling.gray)
                    .disabled(!isImageSet)
                RoundedStateButton(systemName: "list.bullet.below.rectangle", action: { state.setNavState(.analysis, true); }, state: state.isNavState(.analysis), background: Styling.gray)
                    .disabled(state.canvas == nil)
                Divider()
            }
            Spacer()                
            
            Menu(content: {
                Button("Clear", systemImage: "trash.fill", action: onClear)
                Button("Load", systemImage: "square.and.arrow.up.fill", action: onLoad)
                Button("Save", systemImage: "square.and.arrow.down.fill", action: onSave)
                Divider()
                Button("Preferences...", systemImage: "gearshape.2", action: { showPreferences.toggle() })
                Divider()
                Menu(content: {
                    UserModePicker(userMode: $state.userMode)
                }, label: {
                    Button("Mode", systemImage: "filemenu.and.selection", action: { })
                })
                
                
            }, label: {
                RoundedButton(systemName: "ellipsis.circle", action: { })
            })
            
            Menu(content: {
                
                
                Button("About", systemImage: "info.square.fill", action: { showAbout.toggle() })
                Button("Source Code", systemImage: "terminal.fill", action: { showSourceCode.toggle() })
                Button("Feedback", systemImage: "bubble.left.and.exclamationmark.bubble.right.fill", action: { showFeedback.toggle() })
            }, label: {
                RoundedButton(systemName: "info.circle", action: { })
            })
        }
        .frame(maxHeight: 32)
        .sheet(isPresented: $showAbout, content: { AboutSheet(isOpen: $showAbout) })
        .sheet(isPresented: $showSourceCode, content: { SourceCodeSheet(isOpen: $showSourceCode) })
        .sheet(isPresented: $showFeedback, content: { FeedbackSheet(isOpen: $showFeedback) })
        .sheet(isPresented: $showPreferences, content: { PreferencesSheet(isOpen: $showPreferences).environmentObject(state) })
        
    }
}
