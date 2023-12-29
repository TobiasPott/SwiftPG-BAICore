import SwiftUI
import SwiftPG_Palettes
import PDFKit
import UniformTypeIdentifiers

struct ExportMenu<Content: View>: View {
    
    var filename: String = "Instructions.pdf"
    @ViewBuilder let content: () -> Content;
    
    
    @State var exportPDF: Bool = false
    
    var body: some View {
        Menu(content: {
            ShareLink(item: ExportMenu.renderToPDF(filename: filename, content: content), label: {
                Text("Export as PDF")
            })
        }, label: {
            SNImage.squareAndArrowUp
                .rs(fit: true)
                .frame(width: 28, height: 28)
                .padding([.top, .trailing], 6)
                .frame(maxHeight: .infinity, alignment: .topTrailing)
        })
        // ToDo: figure out the wrapping stuff to use macOS <13 fileExporter with FileDocument 
        //        .fileMover(isPresented: $exportPDF, file: ExportMenu.renderToPDF(filename: filename, content: content)) { result in
        //            switch result {
        //            case .success(let file):
        //                print(file.absoluteString)
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            }
        //        }
        
    }
    
    func onCompletion(result: Result<URL, Error>) {
        switch result {
        case .success(let file):
            print(file.absoluteString)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    @MainActor public static func renderToPDF<InnerView: View>(filename: String, @ViewBuilder content: () -> InnerView) -> URL {
        // 1: Save it to our documents directory
        let url = URL.documentsDirectory.appending(path: filename)
        
        // 2: Render Hello World with some modifiers
        let renderer = ImageRenderer(content: content() )
        // 3: Start the rendering process
        renderer.render { size, context in
            // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            // 5: Create the CGContext for our PDF pages
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                print("Failed to create CGContext")
                return
            }
            // 6: Start a new PDF page
            pdf.beginPDFPage(nil)
            // 7: Render the SwiftUI view data onto the page
            context(pdf)
            // 8: End the page and close the file
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
    
}

extension PDFDocument: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .pdf) { pdf in 
            return pdf.dataRepresentation()!
        }
    }
}
