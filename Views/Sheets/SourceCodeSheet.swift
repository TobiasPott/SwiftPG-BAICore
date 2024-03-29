import SwiftUI

struct SourceCodeSheet: View {
    
    @Binding var isOpen: Bool
    
    var body: some View {
        ZStack {
            
            GroupView(label: { Text("Source Code and FOSS") }, content: {
                ScrollView {
                    Divider()
                    
                    Text("FOSS").font(Styling.headlineFont).padding(Edge.Set.bottom, 6.0).padding(Edge.Set.top)
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("Brick Art Instructor (BAI) is a free and open source software. It is made with the intent to share knowledge and joy with others and give you everything necessary to derive it and do whatever you see fit.")
                            .padding(Edge.Set.bottom, 3.0)
                        Text("The original app is written in Swift using the SwiftPlayground app. The full source code is available on github for anyone to use.")
                            .padding(Edge.Set.bottom, 3.0)
                    }
                    Divider()
                    
                    Text("Source Code").font(Styling.headlineFont).padding(Edge.Set.bottom, 6.0).padding(Edge.Set.top)
                    Text("BAI is split into a core repository and wrapper repositories for different development platforms I use for distribution or transpilation for other platforms.")
                        .frameRow()
                        .padding(Edge.Set.bottom, 3.0)
                    HStack {
                        Text("BAI Core"); RootView.spacerZeroLength; Link("on GitHub", destination: URL(string: "https://github.com/TobiasPott/SwiftPG-BAICore/")!)
                    }
                    .padding(Edge.Set.bottom, 3.0)
                    HStack {
                        Text("BAI Swift Playground"); RootView.spacerZeroLength; Link("on GitHub", destination: URL(string: "https://github.com/TobiasPott/SwiftPG-BrickArtInstructor/")!)
                    }
                    Divider()
                    
                    Text("References and Resources").font(Styling.headlineFont).padding(Edge.Set.bottom, 6.0).padding(Edge.Set.top)
                    VStack(alignment: HorizontalAlignment.leading, spacing: 6.0) {
                        DisclosureGroup("Pexels") {
                            Text("Pexels is used as a source for public domain and creative-common licensed images. Some of the sample images are source from pexels.com")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: URL(string: "https://www.pexels.com")!)
                            }
                        }
                        DisclosureGroup("Color-Term") {
                            Text("Color-Term is the source of the extensive list of lego colors and their respective component values and names. It also has other interesting color palettes available online.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: URL(string: "https://color-term.com/lego-colors")!)
                            }
                        }
                        DisclosureGroup("VSlider") {
                            Text("VSlider by John Mueller is used for the HUD/On-Screen controls. It provides a low profile slider for the zoom controls.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: URL(string: "https://github.com/john-mueller/SwiftUI-Examples/blob/master/SwiftUI-Examples/VSlider/VSlider.swift")!)
                            }
                        }
                        DisclosureGroup("National Gallery of Art") {
                            Text("The National Gallery of Art provided open art images which are used as samples.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: URL(string: "https://www.nga.gov/global-site-search-page.html?searchterm=")!)
                            }
                        }
                        DisclosureGroup("Microsoft Bing Image Creator") {
                            Text("The Dall-E powered Bing Image Creator is used to create some of the provided samples and graphics.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: URL(string: "https://www.bing.com/images/create?FORM=GENILP")!)
                            }
                        }
                        DisclosureGroup("Hacking with Swift") {
                            Text("Hacking with Swift is my go to resource four short concise sample of SwiftUI features and types.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: URL(string: "https://www.hackingwithswift.com")!)
                            }
                        }
                        DisclosureGroup("Rebrickable") {
                            Text("Rebrickable is a great source for all info about parts, items, colors, sets. The color palettes are based on the inventories of sets listed on rebrickable.")
                                .frameRow()
                            HStack {
                                Spacer(); Link("Visit Website", destination: URL(string: "https://rebrickable.com")!)
                            }
                        }
                    }
                    
                }
                
            }).padding()
            
            
            HStack { Spacer()
                Button("Close", action: { isOpen = isOpen.not })    
            }.frameStretch(Alignment.topTrailing).padding().padding()
        }
        
    }
}
