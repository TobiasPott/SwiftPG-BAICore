import SwiftUI

struct SplashScreenPanel: View {
    @Binding var isOpen: Bool
    var duration: UInt64 = UInt64(15)
    var isWide: Bool
    
    @State var task: Task<Void, Never>? = nil 
    
    var body: some View {
        ZStack {
            VersionText().zIndex(2)
            BlueprintGrid(baseSpacing: 64.0, lineWidth: isWide ? 1.5 : 0.75)
                .zIndex(1)
                .scaleEffect(isWide ? 2.76 : 4.8)
                .transition(AnyTransition.move(edge: isWide ? Edge.leading : Edge.top))
                .overlay(content: {
                    Button(action: {
                        withAnimation {
                            isOpen = isOpen.not 
                            task?.cancel()
                        }
                    }, label: {
                        ZStack{
                            Styling.appIcon.swuiImage
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .shadow(color: Styling.black.opacity(0.75), radius: 10.0)
                                .overlay(content: {
                                    VStack {
                                        Text("Open Brick Art Instructor")
                                            .modifier(ShadowText())
                                        Text("(will continue in \(duration)s)")
                                            .modifier(ShadowText(font: Styling.caption2Font))
                                        
                                    }
                                    .frameStretch(Alignment.bottom)
                                    .padding(Edge.Set.bottom)
                                    
                                })
                            
                            Styling.roundedRect.stroke(Styling.black.opacity(0.9), lineWidth: 2.0)
                            Styling.roundedRect.stroke(Styling.black.opacity(0.5), lineWidth: 6.0)
                            
                        }                            
                        .frameSquare(256.0)
                        .mask(Styling.roundedRect)
                        .scaleEffect(GlobalState.defaultZoomScale / 100.0 * 4.0)
                        
                    })
                    .onAppear {
                        self.task = delayCover()
                    }
                    
                })
            
            // ToDo: integrate photo sheet into "select from" menus
            //                PhotoSheet()
            //            })
        }
    }
    
    private func delayCover() -> Task<Void, Never>? {
        return Task {
            do {
                try await Task.sleep(nanoseconds: duration * 1_000_000_000)
                withAnimation {
                    if (isOpen) { isOpen = false }
                }
            } catch is CancellationError {
                //                print("Task was cancelled")
            } catch {
                print("Error in splashscreen delay: \(error)")
            }
        }
    }
    
}
