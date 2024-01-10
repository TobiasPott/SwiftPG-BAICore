import SwiftUI

struct SamplesSheet: View {
    
    @Binding var isOpen: Bool
    let onSelect: (PImage) -> Void
    
    let samples: [String:String] = ["OpenArt-Monet_WomenWithAParasol":"Women with a Parasol", "CC0-Aurora": "Aurora"
    ]
    
    var body: some View {
        ZStack {
            GroupBox(label: Text("Samples"), content: {
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        SampleEntry(resourceName: "SwiftPG-BrickArtInstructor", label: "Brick Art Instructor", onSelect: { image in onSelect(image); isOpen = false; })
                        
                        SampleEntry(resourceName: "BingAI_BrickArt_07a048f0", label: "Brick Art - Dinosaur", onSelect: { image in onSelect(image); isOpen = false; })
                        SampleEntry(resourceName: "BingAI_BrickArt_582a7723", label: "Brick Art - Dinosaur 2", onSelect: { image in onSelect(image); isOpen = false; })
                        SampleEntry(resourceName: "BingAI_BrickArt_f61748d2", label: "Brick Art - Cars", onSelect: { image in onSelect(image); isOpen = false; })
                        SampleEntry(resourceName: "BingAI_Minimalistic_f7322a06", label: "Shapes - Minimalisic", onSelect: { image in onSelect(image); isOpen = false; })
                        
                        SampleEntry(resourceName: "BingAI_ComicHero_76bfa51b", label: "Comic - Hero", onSelect: { image in onSelect(image); isOpen = false; })
                        SampleEntry(resourceName: "BingAI_ComicHero_a32dad44", label: "Comic - Hero2", onSelect: { image in onSelect(image); isOpen = false; })
                        SampleEntry(resourceName: "BingAI_Family_4aa9c907", label: "Comic - Family", onSelect: { image in onSelect(image); isOpen = false; })
                        SampleEntry(resourceName: "BingAI_Family_07f8f7b6", label: "Comic - Family 2", onSelect: { image in onSelect(image); isOpen = false; })
                        
                        SampleEntry(resourceName: "BingAI_Portrait_250b00e3", label: "Portrait - Mullet", onSelect: { image in onSelect(image); isOpen = false; })
                        SampleEntry(resourceName: "BingAI_Portrait_a4a475ae", label: "Portrait - Selfie", onSelect: { image in onSelect(image); isOpen = false; })
                        
                        SampleEntry(resourceName: "OpenArt-Monet_WomenWithAParasol", label: "Women with a Parasol", onSelect: { image in onSelect(image); isOpen = false; })
                        SampleEntry(resourceName: "CC0-Aurora", label: "Aurora", onSelect: { image in onSelect(image); isOpen = false; })
                    }
                }
                Spacer()
            }).padding()
            
            
            HStack { Spacer()
                Button("Close", action: { isOpen = isOpen.not })    
            }.frameStretch(Alignment.topTrailing).padding().padding()
        }
        
    }    
}

struct SampleEntry: View {
    
    let resourceName: String
    let label: String
    let onSelect: (PImage) -> Void
    
    var body: some View {
        let image = PImage(imageLiteralResourceName: resourceName);
        return Button(action: {
            onSelect(image)
        }, label: {
            HStack { image.swuiImage.rs(fit: true).frame(maxWidth: CGFloat.infinity) }
                .labelOverlay(label: label, alignment: Alignment.bottomLeading)
                .frame(maxWidth: CGFloat.infinity, maxHeight: 240.0)
        }) 
    }
}
