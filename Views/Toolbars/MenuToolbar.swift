import SwiftUI

struct MenuToolbar: View {
    @EnvironmentObject var state: GlobalState;
    @EnvironmentObject var sheets: SheetsState;
    
    var isImageSet: Bool = false;
    var onLoad: () -> Void = {};
    var onSave: () -> Void = {};
    var onClear: () -> Void = {};
    
    var body: some View {
        HStack {
            RoundedStateButton(systemName: "plus.square", action: { state.setNavState(NavState.load); }, state: state.isNavState(NavState.load), background: Styling.gray)
            Divider()
            if (isImageSet) {
                RoundedStateButton(systemName: "photo.stack", action: { state.setNavState(NavState.setup, true); }, state:  state.isNavState(NavState.setup), background: Styling.gray)
                    .disabled(!isImageSet)
                RoundedStateButton(systemName: "list.bullet.below.rectangle", action: { state.setNavState(NavState.analysis, true); }, state: state.isNavState(NavState.analysis), background: Styling.gray)
                    .disabled(state.canvas == nil)
                Divider()
            }
            Spacer()                
            
            Menu(content: {
                Button("Clear", systemImage: "trash.fill", action: onClear)
                Button("Load", systemImage: "square.and.arrow.up.fill", action: onLoad)
                Button("Save", systemImage: "square.and.arrow.down.fill", action: onSave)
                Divider()
                Button("Preferences...", systemImage: "gearshape.2", action: { sheets.preferences.toggle() })
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
                
                
                Button("About", systemImage: "info.square.fill", action: { sheets.about.toggle() })
                Button("Source Code", systemImage: "terminal.fill", action: { sheets.sourceCode.toggle() })
                Button("Feedback", systemImage: "bubble.left.and.exclamationmark.bubble.right.fill", action: { sheets.feedback.toggle() })
            }, label: {
                RoundedButton(systemName: "info.circle", action: { })
            })
        }
        .frame(maxHeight: 32.0)
        .sheet(isPresented: $sheets.about, content: { AboutSheet(isOpen: $sheets.about) })
        .sheet(isPresented: $sheets.sourceCode, content: { SourceCodeSheet(isOpen: $sheets.sourceCode) })
        .sheet(isPresented: $sheets.feedback, content: { FeedbackSheet(isOpen: $sheets.feedback) })
        .sheet(isPresented: $sheets.preferences, content: { PreferencesSheet(isOpen: $sheets.preferences).environmentObject(state) })
        
    }
}
