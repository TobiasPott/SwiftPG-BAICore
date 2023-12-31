import SwiftUI

struct SourceCodeSheet: View {
    
    @Binding var isOpen: Bool
    
    var body: some View {
        ZStack {
            GroupBox(label: Text("Source Code and FOSS"), content: {
                ScrollView {
                    Divider()
                    
                    Text("FOSS").font(Styling.headlineFont).padding(.bottom, 6).padding(.top)
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("Brick Art Instructor (BAI) is a free and open source software. It is made with the intent to share knowledge and joy with others and give you everything necessary to derive it and do whatever you see fit.")
                            .padding(.bottom, 3)
                        Text("The original app is written in Swift using the SwiftPlayground app. The full source code is available on github for anyone to use.")
                            .padding(.bottom, 3)
                    }
                    Divider()
                    
                    // ToDo: Add source code link to :
                    // requires repo to be set to public
                    
                    Text("Source Code").font(Styling.headlineFont).padding(.bottom, 6).padding(.top)
                    Text("BAI is split into a core repository and wrapper repositories for different development platforms I use for distribution or transpilation for other platforms.")
                        .frameRow()
                        .padding(.bottom, 3)
                    HStack {
                        Text("BAI Core"); Spacer(minLength: 0); Link("on GitHub", destination: .init(string: "https://github.com/TobiasPott/SwiftPG-BAICore/")!)
                    }
                    .padding(.bottom, 3)
                    HStack {
                        Text("BAI Swift Playground"); Spacer(minLength: 0); Link("on GitHub", destination: .init(string: "https://github.com/TobiasPott/SwiftPG-BrickArtInstructor/")!)
                    }
                    Divider()
                    
                    Text("References and Resources").font(Styling.headlineFont).padding(.bottom, 6).padding(.top)
                    VStack(alignment: HorizontalAlignment.leading, spacing: 6) {
                        DisclosureGroup("Pexels") {
                            Text("Pexels is used as a source for public domain and creative-common licensed images. Some of the sample images are source from pexels.com")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: .init(string: "https://www.pexels.com")!)
                            }
                        }
                        DisclosureGroup("Color-Term") {
                            Text("Color-Term is the source of the extensive list of lego colors and their respective component values and names. It also has other interesting color palettes available online.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: .init(string: "https://color-term.com/lego-colors")!)
                            }
                        }
                        DisclosureGroup("VSlider") {
                            Text("VSlider by John Mueller is used for the HUD/On-Screen controls. It provides a low profile slider for the zoom controls.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: .init(string: "https://github.com/john-mueller/SwiftUI-Examples/blob/master/SwiftUI-Examples/VSlider/VSlider.swift")!)
                            }
                        }
                        DisclosureGroup("National Gallery of Art") {
                            Text("The National Gallery of Art provided open art images which are used as samples.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: .init(string: "https://www.nga.gov/global-site-search-page.html?searchterm=")!)
                            }
                        }
                        DisclosureGroup("Microsoft Bing Image Creator") {
                            Text("The Dall-E powered Bing Image Creator is used to create some of the provided samples and graphics.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: .init(string: "https://www.bing.com/images/create?FORM=GENILP")!)
                            }
                        }
                    }
                    
                    // ToDo: Add rebrickable for color lists & references 
                    // http://www.peeron.com/inv/colors
                    // http://www.peeron.com/cgi-bin/invcgis/colorguide.cgi
                    
                    
                }
                
            }).padding()
            
            
            HStack { Spacer()
                Button("Close", action: { isOpen.toggle() })    
            }.frameStretch(Alignment.topTrailing).padding().padding()
        }
        
    }
}
