import SwiftUI

struct MenuToolbar: View {
    @EnvironmentObject var state: AppState;
    
    var isImageSet: Bool = false;
    @State var showAboutView: Bool = false;
    @State var showSourceCodeView: Bool = false;
    @State var showFeedbackView: Bool = false;
    @State var showPreferencesView: Bool = false;
    var onLoad: () -> Void = {};
    var onSave: () -> Void = {};
    var onClear: () -> Void = {};
    
    
    var body: some View {
        HStack {
            RoundedStateButton(systemName: "plus.square", action: { state.setNavState(.load); }, state: state.isNavState(.load), background: .gray)
            Divider()
            if (isImageSet) {
                RoundedStateButton(systemName: "photo.stack", action: { state.setNavState(.setup, true); }, state:  state.isNavState(.setup), background: .gray)
                    .disabled(!isImageSet)
                //                if (state.canvas?.analysis != nil) {
                RoundedStateButton(systemName: "list.bullet.below.rectangle", action: { state.setNavState(.analysis, true); }, state: state.isNavState(.analysis), background: .gray)
                    .disabled(state.canvas == nil)
                Divider()
            }
            Spacer()                
            
            Menu(content: {
                Button("Clear", systemImage: "trash.fill", action: onClear)
                Button("Load", systemImage: "square.and.arrow.up.fill", action: onLoad)
                Button("Save", systemImage: "square.and.arrow.down.fill", action: onSave)
                Divider()
                Button("Preferences...", systemImage: "gearshape.2", action: { showPreferencesView = true })
                Divider()
                Menu(content: {
                    Picker(selection: $state.userMode, label: Text("Mode")) {
                        Label("Guided", systemImage: "info.bubble").tag(UserMode.guided)
                        Label("Simple", systemImage: "rectangle").tag(UserMode.simple)
                        Label("Advanced", systemImage: "rectangle.on.rectangle.badge.gearshape").tag(UserMode.advanced)
                    }
                }, label: {
                    Button("Mode", systemImage: "filemenu.and.selection", action: { })
                })
                
                
            }, label: {
                RoundedButton(systemName: "ellipsis.circle", action: { })
            })
            
            Menu(content: {
                
                
                Button("About", systemImage: "info.square.fill", action: { showAboutView.toggle() })
                Button("Source Code", systemImage: "terminal.fill", action: { showSourceCodeView.toggle() })
                Button("Feedback", systemImage: "bubble.left.and.exclamationmark.bubble.right.fill", action: { showFeedbackView.toggle() })
            }, label: {
                RoundedButton(systemName: "info.circle", action: { })
            })
        }
        .frame(maxHeight: 32)
        .sheet(isPresented: $showAboutView, content: { AboutSheet(isOpen: $showAboutView) })
        .sheet(isPresented: $showSourceCodeView, content: { SourceCodeSheet(isOpen: $showSourceCodeView) })
        
        .sheet(isPresented: $showFeedbackView, content: { FeedbackSheet(isOpen: $showFeedbackView) })
        .sheet(isPresented: $showPreferencesView, content: { PreferencesSheet(isOpen: $showPreferencesView) })
    }
}
