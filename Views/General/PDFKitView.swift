import SwiftUI
import Foundation
import PDFKit

struct PDFContentView: View {
    // Main UI
    var body: some View {
        HStack {
            Text("Generate PDF using PDFKit").font(.title)
            Button("Save PDF") {
                savePDF()
            }
        }
        PDFKitView(pdfData: PDFDocument(data: generatePDF())!)
    }
    
    // Generating PDF
    @MainActor
    private func generatePDF() -> Data {
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842)) // A4 paper size
        
        let data = pdfRenderer.pdfData { context in
            
            context.beginPage()
            
            let attributes = [
                NSAttributedString.Key.backgroundColor: UIColor.red,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72)
            ]
            // adding text to pdf
            let text = "I'm a PDF!"
            text.draw(at: CGPoint(x: 20, y: 50), withAttributes: attributes)
            
            
            
            // adding image to pdf from assets
            // add an image to xcode assets and rename this.
            let appleLogo = UIImage.init(named: "circle")
            let appleLogoRect = CGRect(x: 20, y: 150, width: 400, height: 350)
            if (appleLogo != nil) {
                appleLogo!.draw(in: appleLogoRect)
            }
            
            // adding image from SF Symbols
            let globeIcon = UIImage(systemName: "circle")
            let globeIconRect = CGRect(x: 150, y: 550, width: 100, height: 100)
            if (globeIcon != nil) {
                globeIcon!.draw(in: globeIconRect)
            }
            
        }
        
        return data
        
    }
    
    
    
    // Saving PDF
    @MainActor func savePDF() {
        let fileName = "GeneratedPDF.pdf"
        let pdfData = generatePDF()
        
        if let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let documentURL = documentDirectories.appendingPathComponent(fileName)
            do {
                try pdfData.write(to: documentURL)
                print("PDF saved at: \(documentURL)")
            } catch {
                print("Error saving PDF: \(error.localizedDescription)")
            }
        }
    }
    @MainActor func savePDFAsURL() -> URL {
        let fileName = "GeneratedPDF.pdf"
        let pdfData = generatePDF()
        
        let documentURL = URL.documentsDirectory.appending(path: fileName)
        do {
            try pdfData.write(to: documentURL)
            print("PDF saved at: \(documentURL)")
        } catch {
            print("Error saving PDF: \(error.localizedDescription)")
        }
        return documentURL
        
    }
}

// PDF Viewer
struct PDFKitView: UIViewRepresentable {
    
    let pdfDocument: PDFDocument
    
    init(pdfData pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}
