import SwiftUI

struct AboutSheet: View {
    
    @Binding var isOpen: Bool
    
    var body: some View {
        ZStack {
            GroupBox(label: Text("About"), content: {
                ScrollView {
                    Divider()
                    Styling.appIcon.swuiImage.rs(fit: true)
                        .mask(Styling.roundedRect)
                        .frame(maxHeight: 200)
                    
                    Text("About Brick Art Instructor").font(Styling.headlineFont).padding(Edge.Set.bottom, 6).padding(Edge.Set.top, 0)
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("Welcome to Brick Art Instructor. \nAn utility app to help you create instructions and part lists for artworks you can build with your construction bricks at home.")
                            .padding(Edge.Set.bottom, 3)
                        Text("The inspiration for this app came from a Batman artwork I build a few months ago. I wanted to use a different topic. I was simply too lazy to figure out a manual process instead I started writing this app.")
                            .padding(Edge.Set.bottom, 3)
                        Text("I hope you find it useful and get your own brick artwork ideas built.")
                            .padding(Edge.Set.bottom, 3)
                    }
                    Divider()
                    Image(systemName: "heart.circle").resizable().frame(width: 32, height: 32).padding(Edge.Set.top)
                    Text("My Plea to You").font(Styling.headlineFont).padding(Edge.Set.bottom, 6)
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("I'm working for fun on this app and want to share it with the world. Thus I have no direct need to monitize this app.")
                            .padding(Edge.Set.bottom, 3)
                        Text("This said, you may find value in this app, I ask you to direct any appreciation towards people in need near you. \nThere are many out there who need help, be it some money toeat and drink or be it a short time of campanionship. Please take a moment and reconsider if you want to help someone in need.")
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
