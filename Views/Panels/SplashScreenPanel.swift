import SwiftUI

struct SplashScreenPanel: View {
    @Binding var isOpen: Bool
    var duration: UInt64 = 15
    var isLandscape: Bool
    
    var body: some View {
        BlueprintGrid(baseSpacing: 64, lineWidth: isLandscape ? 1.5 : 0.75)
            .task(priority: .medium, delayCover)
            .zIndex(1)
            .scaleEffect(isLandscape ? 2.76 : 4.8)
            .transition(.move(edge: isLandscape ? .leading : .top))
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
                                .shadow(color: Styling.black.opacity(0.75), radius: 10)
                            Text("Open Brick Art Instructor").font(Styling.titleFont)
                            Text("(will continue in \(duration)s)").font(Styling.caption2Font)
                        }
                        .frameRow(300, Alignment.center)
                    })
                    
                })
                .padding()
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
