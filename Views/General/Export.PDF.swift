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
        for i in stride(from: 0, to: canvas.plateCoordinates.count, by: 2) {
            let coords = canvas.plateCoordinates[i];
            if ((i+1) < canvas.plateCoordinates.count) {
                let coords2 = canvas.plateCoordinates[i+1];
                VStack {
                    PDFPlate(source: source, canvas: canvas, palette: palette, coords: coords).frameStretch(Alignment.topLeading)
                    PDFPlate(source: source, canvas: canvas, palette: palette, coords: coords2).frameStretch(Alignment.topLeading)
                }
                .drawAsPDFPage(in: context, size: box.size)
            } else {
                PDFPlate(source: source, canvas: canvas, palette: palette, coords: coords).frameStretch(Alignment.topLeading)
                    .drawAsPDFPage(in: context, size: box.size)
            }
        }
        
        context.closePDF()
        return url
    }
    
}
