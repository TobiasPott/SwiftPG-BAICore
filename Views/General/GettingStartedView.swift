import SwiftUI

struct GettingStartedView: View {
    
    var body: some View {
        
        GroupBox(label: Text(" "), content: {
            ScrollView {
                Divider()
                Styling.appIcon.swuiImage.rs(fit: true).frame(maxHeight: 240)
                Text("Welcome").font(Styling.headlineFont).padding(Edge.Set.bottom, 6)
                VStack(alignment: HorizontalAlignment.leading) {
                    Text("Welcome to Brick Art Instructor. \nAn utility app to help you create instructions and part lists for artworks you can build with your construction bricks at home.")
                        .padding(Edge.Set.bottom, 3)
                    Text("The inspiration for this app came from a Batman artwork I build a few months ago. I wanted to use a different topic. I was simply too lazy to figure out a manual process instead I started writing this app.")
                        .padding(Edge.Set.bottom, 3)
                    Text("I hope you find it useful and get your own brick artwork ideas built.")
                        .padding(Edge.Set.bottom, 3)
                }
                Divider()
                Spacer()
            }
            
        })
        
        
    }
}
