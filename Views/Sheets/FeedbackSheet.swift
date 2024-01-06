import SwiftUI

struct FeedbackSheet: View {
    
    @Binding var isOpen: Bool
    
    var body: some View {
        ZStack {
            GroupBox(label: Text("Feedback"), content: {
                ScrollView {
                    Divider()
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("Feel free to give me feedback to this app and share your ideas, feature suggestions and problems you have.")
                            .padding(Edge.Set.bottom, 3.0)
                        Text("You can do so with the review and feedback function of your device's app store or open a new issue on the GitHub repository.")
                            .padding(Edge.Set.bottom, 3.0)
                    }
                    Divider()
                    HStack {
                        Spacer(); Link("Go to Github", destination: URL(string: "https://github.com/TobiasPott/SwiftPG-BrickArtInstructor")!)
                    }
                    Spacer()
                }
                
            }).padding()
            HStack { Spacer()
                Button("Close", action: { isOpen.toggle() })    
            }.frameStretch(Alignment.topTrailing).padding().padding()
        }
        
    }
}
