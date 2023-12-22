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
                        .frame(maxHeight: 240)
                        
                    Text("About this App").font(.headline).padding(.bottom, 6).padding(.top)
                    VStack(alignment: .leading) {
                        Text("Welcome to Brick Art Instructor. \nAn utility app to help you create instructions and part lists for artworks you can build with your construction bricks at home.")
                            .padding(.bottom, 3)
                        Text("The inspiration for this app came from a Batman artwork I build a few months ago. I wanted to use a different topic. I was simply too lazy to figure out a manual process instead I started writing this app.")
                            .padding(.bottom, 3)
                        Text("I hope you find it useful and get your own brick artwork ideas built.")
                            .padding(.bottom, 3)
                    }
                    Divider()
                    
                    Text("References").font(.headline).padding(.bottom, 6).padding(.top)
                    DisclosureGroup("Pexels") {
                        Text("Pexels is used as a source for public domain and creative-common licensed images. Some of the sample images are source from pexels.com")
                        HStack {
                            Spacer(); Link("Visit Website", destination: .init(string: "https://www.pexels.com")!)
                        }
                    }
                    .padding(.bottom)
                    DisclosureGroup("Color-Term") {
                        Text("Color-Term is the source of the extensive list of lego colors and their respective component values and names. It also has other interesting color palettes available online.")
                        HStack {
                            Spacer(); Link("Visit Website", destination: .init(string: "https://color-term.com/lego-colors")!)
                        }
                    }
                    .padding(.bottom)
                    DisclosureGroup("VSlider") {
                        Text("VSlider by John Mueller is used for the HUD/On-Screen controls. It provides a low profile slider for the zoom controls.")
                        HStack {
                            Spacer(); Link("Visit Website", destination: .init(string: "https://github.com/john-mueller/SwiftUI-Examples/blob/master/SwiftUI-Examples/VSlider/VSlider.swift")!)
                        }
                    }
                    .padding(.bottom)
                    DisclosureGroup("National Gallery of Art") {
                        Text("The National Gallery of Art provided open art images which are used as samples.")
                        HStack {
                            Spacer(); Link("Visit Website", destination: .init(string: "https://www.nga.gov/global-site-search-page.html?searchterm=")!)
                        }
                    }
                    .padding(.bottom)
                    DisclosureGroup("Microsoft Bing Image Creator") {
                        Text("The Dall-E powered Bing Image Creator is used to create some of the provided samples and graphics.")
                        HStack {
                            Spacer(); Link("Visit Website", destination: .init(string: "https://www.bing.com/images/create?FORM=GENILP")!)
                        }
                    }
                    .padding(.bottom)
                    
                    // ToDo: Add rebrickable for color lists & references 
                    // http://www.peeron.com/inv/colors
                    // http://www.peeron.com/cgi-bin/invcgis/colorguide.cgi
                    
                    Divider()
                    Image(systemName: "heart.circle").resizable().frame(width: 32, height: 32).padding(.top)
                    Text("My Plea to You").font(.headline).padding(.bottom, 6)
                    VStack(alignment: .leading) {
                        Text("I'm working for fun on this app and want to share it with the world. Thus I have no direct need to monitize this app.")
                            .padding(.bottom, 3)
                        Text("This said, you may find value in this app, I ask you to direct any appreciation towards people in need near you. \nThere are many out there who need help, be it some money toeat and drink or be it a short time of campanionship. Please take a moment and reconsider if you want to help someone in need.")
                    }
                    Spacer()
                }
                
            }).padding()
            
            
            HStack { Spacer()
                Button("Close", action: { isOpen.toggle() })    
            }.frameInfinity(.topTrailing).padding().padding()
        }
        
    }
}
