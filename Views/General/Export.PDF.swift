import SwiftUI
import PDFKit
import UniformTypeIdentifiers

struct ExportMenu: View {
    var filename: String = "Instructions.pdf"
    
    let source: ArtSource;
    let canvas: ArtCanvas;
    let palette: Palette

    let width: CGFloat
    
    @State var exportPDF: Bool = false
    
    var body: some View {
        Menu(content: {
            let url = ExportMenu.renderToPDF(filename: filename, canvas: canvas, source: source, palette: palette, width: width)
            ShareLink(item: url, label: {
                Text("Export as PDF")
            })
        }, label: {
            SNImage.squareAndArrowUp
                .rs(fit: true)
                .frame(width: 28.0, height: 28.0)
                .padding([Edge.Set.top, Edge.Set.trailing], 6.0)
                .frame(maxHeight: CGFloat.infinity, alignment: Alignment.topTrailing)
        })
    }
    static func renderToPDF(filename: String, views: [UIImage]) -> URL {
        // 1: Save it to our documents directory
        let url = URL.documentsDirectory.appending(path: filename)
        let doc: PDFDocument = PDFDocument()
        
        for i in 0 ..< views.count {
            guard let page = PDFPage(image: views[i]) else { continue; } 
            doc.insert(page, at: doc.pageCount)
        }
        let data = doc.dataRepresentation()
        do {       
            try data?.write(to: url)       
        } catch(let error) {
            print("error is \(error.localizedDescription)")
        }
        return url
    }
    @MainActor public static func renderToPDF(filename: String, canvas: ArtCanvas, source: ArtSource, palette: Palette, width: CGFloat) -> URL {
        // 1: Save it to our documents directory
        let url = URL.documentsDirectory.appending(path: filename)
        let doc: PDFDocument = PDFDocument()
        
        doc.insert(PDFHeader(canvas: canvas).asPDFPage(width / 2.0)!, at: doc.pageCount)
        doc.insert(PDFColorList(canvas: canvas, palette: palette).asPDFPage(width)!, at: doc.pageCount)
        for coords in canvas.plateCoordinates {
            doc.insert(PDFPlate(source: source, canvas: canvas, palette: palette, coords: coords).asPDFPage(width)!, at: doc.pageCount)   
        }
        doc.insert(PDFFooter().asPDFPage(width)!, at: doc.pageCount)
        // https://betterprogramming.pub/convert-a-uiimage-to-pdf-in-swift-bf9f22b127c5
        
        let data = doc.dataRepresentation()
        do {       
            try data?.write(to: url)       
        } catch(let error) {
            print("error is \(error.localizedDescription)")
        }
        return url
    }
    
}


