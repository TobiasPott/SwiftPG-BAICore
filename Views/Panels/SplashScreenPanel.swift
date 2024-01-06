import SwiftUI

struct SplashScreenPanel: View {
    @Binding var isOpen: Bool
    var duration: UInt64 = UInt64(15)
    var isWide: Bool
    
    var body: some View {
        BlueprintGrid(baseSpacing: 64.0, lineWidth: isWide ? 1.5 : 0.75)
            .task(priority: TaskPriority.medium, delayCover)
            .zIndex(1)
            .scaleEffect(isWide ? 2.76 : 4.8)
            .transition(AnyTransition.move(edge: isWide ? Edge.leading : Edge.top))
            .overlay(content: {
                GroupBox(content: {
                    Button(action: {
                        withAnimation {
                            isOpen.toggle()
                        }
                    }, label: {
                        VStack{
                            Styling.appIcon.swuiImage
                                .rs(fit: true)
                                .mask(Styling.roundedRect)
                                .shadow(color: Styling.black.opacity(0.75), radius: 10.0)
                            Text("Open Brick Art Instructor").font(Styling.titleFont)
                            Text("(will continue in \(duration)s)").font(Styling.caption2Font)
                        }
                        .frameRow(300.0, Alignment.center)
                    })
                })
                .padding()
                // ToDo: integrate photo sheet into "select from" menus
//                PhotoSheet()
            })
    }
    
    @Sendable private func delayCover() async {
        // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
        try? await Task.sleep(nanoseconds: (duration * 1_000_000_000))
        withAnimation {
            isOpen = false
        }
    }
    
    
}
