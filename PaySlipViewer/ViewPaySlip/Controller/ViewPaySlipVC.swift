//
//  ViewPaySlipVC.swift
//  PaySlipViewer
//
//  Created by karthik on 23/11/21.
//

import UIKit
import PDFKit

class ViewPaySlipVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        displayPdf()

        // Do any additional setup after loading the view.
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }

    private func createPdfView(withFrame frame: CGRect) -> PDFView {
        let pdfView = PDFView(frame: frame)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.autoScales = true
        
        return pdfView
    }
    
    func showSavedPdf(fileName:String) -> PDFDocument?{
        if #available(iOS 10.0, *) {
            do {
                let resourceUrl = getDocumentsDirectory()
                let pdfFolderURl = resourceUrl.appendingPathComponent("Diksha/July/")
                // let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: pdfFolderURl, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains(".pdf") {
                        // its your file! do what you want with it!
                        return PDFDocument(url: url)
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
                return nil
            }
        }
        return nil
    }

    
    /* private func createPdfDocument(forFileName fileName: String) -> PDFDocument? {
        let resourceUrl = getDocumentsDirectory()
        let pdfFolderURl = resourceUrl.appendingPathComponent("Diksha/July/")
        if let resourceUrl = pdfFolderURl(forFileName: fileName) {
            return PDFDocument(url: resourceUrl)
        }
        
        return nil
    } */
    
    private func displayPdf() {
        let pdfView = self.createPdfView(withFrame: self.view.bounds)
        
        if let pdfDocument = self.showSavedPdf(fileName: "sample") {
            self.view.addSubview(pdfView)
            pdfView.document = pdfDocument
        }
    }
    
}
