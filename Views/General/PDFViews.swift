import SwiftUI
import Foundation
import PDFKit
import UniformTypeIdentifiers

struct PDFFile: FileDocument {
    // tell the system we support only plain text
    static var readableContentTypes = [UTType.pdf]
    
    // by default our document is empty
    var doc: PDFDocument
    
    // a simple initializer that creates new, empty documents
    init(url: URL) {
        doc = PDFDocument(url: url) ?? PDFDocument()
    }
    
    // this initializer loads data that has been saved previously
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            doc = PDFDocument(data: data)  ?? PDFDocument()
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = doc.dataRepresentation() ?? Data()
        return FileWrapper(regularFileWithContents: data)
    }
}

struct PDFPreview: View {
    @EnvironmentObject var state: GlobalState;
    
    @Binding var isOpen: Bool
    @ObservedObject var canvas: ArtCanvas;
    
    var source: ArtSource
    var width: CGFloat
    @State var pdfExport: Bool = false
    @State var pdfFile: PDFFile?
    @State var pdfUrl: URL?
    
    var body: some View {
        ZStack {
            let views = getViews()
            GroupView(label: { Text("PDF Pages") }, content: {
                ScrollView(content: {
                    ForEach(views, id: \.self) { v in
                        Image(uiImage: v)
                            .resizable()
                            .scaledToFit()
                            .mask(Styling.roundedRect)
                    }
                })
            })
            HStack { Spacer()
                Button("Export", action: { 
                    pdfFile = PDFFile(url: ExportMenu.createPDF("Instructions.pdf", canvas: canvas, source: source, palette: state.palette))
                    pdfExport = pdfExport.not 
                })    
                Button("Close", action: { isOpen = isOpen.not })    
            }.frameStretch(Alignment.topTrailing).padding()
        }
        .padding()
        .fileExporter(isPresented: $pdfExport, document: pdfFile, contentType: .pdf, defaultFilename: "Instructions.pdf", onCompletion: { result in
            isOpen = isOpen.not  
        })
    }
    
    @MainActor func getViews() -> [UIImage] {
        var results: [UIImage] = []
        results.append(PDFHeader(canvas: canvas).asUIImage(width / 2.0))
        results.append(PDFColorList(canvas: canvas, palette: state.palette).asUIImage(width))
        for coords in canvas.plateCoordinates {
            results.append(PDFPlate(source: source, canvas: canvas, palette: state.palette, coords: coords).asUIImage(width))   
        }
        results.append(PDFFooter().asUIImage(width))
        return results
    }
}

struct PDFColorList: View {
    let canvas: ArtCanvas;
    let palette: Palette
    
    var body: some View {
        GroupView(label: {}, content: {
            VStack{
                HStack {
                    Text("You need the following colors").font(Styling.headlineFont)
                    Spacer();
                }                
                ColorSwatchList(colorsWithCount: canvas.analysis!.colorInfo.mappedColorCounts, palette: palette, isWide: true) 
            }
            .foregroundColor(Styling.white)
        }, style: GroupViewStyles.blueprint)
    }
}
struct PDFFooter: View {
    var body: some View {
        GroupView(label: {}, content: {
            HStack {
                let date = Date()
                // Create Date Formatter
                let dateFormatter = DateFormatter(dateFormat: "YY/MM/dd") 
                Text("Created with Brick Art Instructor - \(dateFormatter.string(from: date))").font(Styling.captionFont).fontWeight(Font.Weight.bold)
                Spacer();
            }
            .foregroundColor(Styling.white)
        }, style: GroupViewStyles.blueprint)
    }
}
struct PDFHeader: View {
    let canvas: ArtCanvas;
    var body: some View {
        GroupView(label: {}, content: {
            HStack(alignment: VerticalAlignment.top) {
                canvas.analysis?.image.swuiImage
                    .interpolation(Image.Interpolation.none)
                    .rs(fit: true)
                    .frameMax(128.0)
                    .mask(Styling.roundedRect)
                VStack(alignment: HorizontalAlignment.leading) {
                    Text("Brick Art Instructor").font(Styling.titleFont.bold())
                    Text("Instruction, Parts and Color List").font(Styling.title2Font);
                    Text("for '\(canvas.name)'").font(Styling.title2Font);
                }
                Spacer()
            }
            .foregroundColor(Styling.white)
        }, style: GroupViewStyles.blueprint)
    }
}
struct PDFPlate: View {
    let source: ArtSource;
    let canvas: ArtCanvas;
    let palette: Palette   
    let coords: Int2
    
    var body: some View {
        GroupView(label: { Text("Plate (\(coords.x + 1), \(coords.y + 1))") }, content: {
            HStack {
                VStack(alignment: HorizontalAlignment.leading) {
                    HStack(alignment: VerticalAlignment.top) { 
                        PlatePicker(canvas: canvas, selection: .constant(coords))
                            .frame(maxWidth: 150.0)
                        Spacer()
                        PlateArt(canvas: canvas, tileCoords: coords, display: BrickOutlineMode.outlined)
                    }
                    .frame(height: 240.0)
                    PlateColorList(canvas: canvas, tileCoords: coords, palette: palette, isWide: true)
                    RootView.spacerZeroLength
                }
                .frame(maxHeight: CGFloat.infinity)
                
                PlateArt(canvas: canvas, tileCoords: coords, display: BrickOutlineMode.outlined)
                    .mask(Styling.roundedRect)
            }
        }, style: GroupViewStyles.blueprint)
        .foregroundColor(Styling.white)
    }
}
