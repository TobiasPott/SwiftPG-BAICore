import SwiftUI

struct SplashScreenPanel: View {
    @Binding var isOpen: Bool
    var duration: UInt64 = UInt64(15)
    var isWide: Bool
    
    @State var task: Task<Void, Never>? = nil 
    
    var body: some View {
        BlueprintGrid(baseSpacing: 64.0, lineWidth: isWide ? 1.5 : 0.75)
            .zIndex(1)
            .scaleEffect(isWide ? 2.76 : 4.8)
            .transition(AnyTransition.move(edge: isWide ? Edge.leading : Edge.top))
            .overlay(content: {
                GroupBox(content: {
                    Button(action: {
                        withAnimation {
                            isOpen.toggle() 
                            task?.cancel()
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
                    .onAppear {
                        self.task = delayCover()
                    }
                })
                .padding()
                // ToDo: integrate photo sheet into "select from" menus
//                PhotoSheet()
            })
    }
    
    private func delayCover() -> Task<Void, Never>? {
        return Task {
            do {
                try await Task.sleep(nanoseconds: duration * 1_000_000_000)
                withAnimation {
                    if (isOpen) {
                        isOpen = false
                    }
                }
            } catch is CancellationError {
                print("Task was cancelled")
            } catch {
                print("ooops! \(error)")
            }
        }
    }
    
}
