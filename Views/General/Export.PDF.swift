import SwiftUI
import PDFKit
import UniformTypeIdentifiers

struct ExportMenu {
    
    @MainActor
    public static func createPDF(_ filename: String = "MyPDF.pdf", canvas: ArtCanvas, source: ArtSource, palette: Palette) -> URL {
        
        let url = URL.documentsDirectory.appending(path: filename)
        var box = CGRect(
            origin: .zero,
            size: .init(width: 595 * 2, height: 842 * 2) // A4 sheet
        )
        let metadata: [CFString: String] = [:]
        
        guard let context = CGContext(url as CFURL, mediaBox: &box, metadata as CFDictionary) else {
            return url
        }
        VStack {
            PDFHeader(canvas: canvas)
            PDFColorList(canvas: canvas, palette: palette)
            GroupView(label: {}, content: {
                VStack { Spacer() }.frameStretch()
            }, style: GroupViewStyles.blueprint)
            PDFFooter()      
        }
        .drawAsPDFPage(in: context, size: box.size)
        for coords in canvas.plateCoordinates {
            PDFPlate(source: source, canvas: canvas, palette: palette, coords: coords).frameStretch(Alignment.topLeading).drawAsPDFPage(in: context, size: box.size)
        }  
        
        context.closePDF()
        return url
    }
        
}
