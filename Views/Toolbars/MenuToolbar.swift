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
            RoundedImage(sName: state.isNavState(NavState.load) ? "plus.square.fill" : "plus.square", background: Styling.clear)
            RoundedImage(sName: state.isNavState(NavState.setup) ? "photo.stack.fill" : "photo.stack", background: Styling.clear)
            RoundedImage(sName: state.isNavState(NavState.analysis) ? "square.grid.3x3.fill" : "square.grid.3x3", background: Styling.clear)
            Divider()
            //            }
            Spacer()                
            
            Menu(content: {
                Button("Clear", systemImage: "trash", action: onClear)
                Button("Load last state", systemImage: "square.and.arrow.down", action: onLoad)
                Button("Save current state", systemImage: "square.and.arrow.up", action: onSave)
                Divider()
                Button("Preferences...", systemImage: "gearshape.2", action: { sheets.preferences = sheets.preferences.not })
                Divider()
                Menu(content: {
                    UserModePicker(userMode: $state.userMode)
                }, label: {
                    Button("Mode", systemImage: "ellipsis", action: { })
                })
                
                
            }, label: {
                RoundedButton(sName: "ellipsis.circle", action: { })
            })
            
            Menu(content: {
                
                
                Button("About", systemImage: "info.square.fill", action: {
                    sheets.about = sheets.about.not })
                Button("Source Code", systemImage: "terminal.fill", action: {
                    sheets.sourceCode = sheets.sourceCode.not })
                Button("Feedback", systemImage: "bubble.left.and.exclamationmark.bubble.right.fill", action: {
                    sheets.feedback = sheets.feedback.not })
            }, label: {
                RoundedButton(sName: "info.circle", action: { })
            })
        }
        .frame(maxHeight: 32.0)
    }
}
