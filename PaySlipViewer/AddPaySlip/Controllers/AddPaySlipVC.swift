//
//  AddPaySlipVC.swift
//  PaySlipViewer
//
//  Created by karthik on 23/11/21.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class AddPaySlipVC: UIViewController {

    @IBOutlet weak var compNameTxtField: UITextField!
    @IBOutlet weak var monthTxtField: UITextField!
    @IBOutlet weak var yearTxtField: UITextField!
    
    @IBOutlet weak var monthLbl: UILabel!{
        didSet{
            monthLbl.layer.borderColor = UIColor.lightGray.cgColor
            monthLbl.layer.borderWidth = 0.5
            monthLbl.layer.cornerRadius = 5
            monthLbl.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var yearLbl: UILabel!{
        didSet{
            yearLbl.layer.borderColor = UIColor.lightGray.cgColor
            yearLbl.layer.borderWidth = 0.5
            yearLbl.layer.cornerRadius = 5
            yearLbl.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var fileNameTxtField: UITextField!
    
    
    @IBOutlet weak var uploadBtn: UIButton!{
        didSet{
            uploadBtn.layer.borderWidth = 1.0
            uploadBtn.layer.cornerRadius = 10
            // uploadBtn.layer.borderColor = #colorLiteral(red: 0.4588235294, green: 0.8274509804, blue: 0.8549019608, alpha: 1)
            uploadBtn.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var clearBtn: UIButton!{
        didSet{
            clearBtn.layer.borderWidth = 1.0
            clearBtn.layer.cornerRadius = 10
            // clearBtn.layer.borderColor = #colorLiteral(red: 0.4588235294, green: 0.8274509804, blue: 0.8549019608, alpha: 1)
            clearBtn.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var addBtn: UIButton!{
        didSet{
            addBtn.layer.borderWidth = 1.0
            addBtn.layer.cornerRadius = 10
            // addBtn.layer.borderColor = #colorLiteral(red: 0.4588235294, green: 0.8274509804, blue: 0.8549019608, alpha: 1)
            addBtn.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    let supportedTypes = [UTType.pdf]
    var uploadFileURL: URL?
    var companyName:String?
    var year:String?
    var month:String?
    let datePickerView = UIView()
    let monthPicker: UIPickerView = UIPickerView()
    var months = [String]()
    var years = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add PaySlip"
        populatingDates()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        yearTxtField.inputView = datePickerView
        setupMonthPicker()
        datePickerView.isHidden = true
        clearBtn.isEnabled = false
        /* let monthTapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(addMonthPicker(_:)))
        monthTapGesture.delegate = self
        monthTapGesture.numberOfTapsRequired = 1
        monthLbl.addGestureRecognizer(monthTapGesture)
        
        let yearTapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(addYearPicker(_:)))
        yearTapGesture.delegate = self
        yearTapGesture.numberOfTapsRequired = 1
        yearLbl.addGestureRecognizer(yearTapGesture) */
        
    }
    
    func populatingDates() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: "01-01-2017") else {
            fatalError()
        }
        
        // population years
        var years: [Int] = []
        if years.count == 0 {
            var year = Calendar(identifier: .gregorian).component(.year, from: date)
            for _ in 1...40 {
                years.append(year)
                year += 1
            }
        }
        self.years = years
        
        print("Years = \(self.years)")
        
        // population months with localized names
        var months: [String] = []
        var month = 0
        for _ in 1...12 {
            months.append(DateFormatter().monthSymbols[month].capitalized)
            month += 1
        }
        self.months = months
    }
    
    
    func setupMonthPicker() {
        datePickerView.frame = CGRect(x: 0, y: (self.view.frame.height - 294), width: self.view.frame.width, height: 294.0)
        datePickerView.backgroundColor = .clear
        self.view.addSubview(datePickerView)
        
        monthPicker.frame = CGRect(x: 0.0, y: 44.0, width: datePickerView.frame.width, height: 250)
        monthPicker.backgroundColor = UIColor.white
        // monthPicker.showsSelectionIndicator = true
        monthPicker.dataSource = self
        monthPicker.delegate = self
        datePickerView.addSubview(monthPicker)
        monthPicker.selectRow(0, inComponent: 0, animated: false)
        month = months[0]
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0.0, width: datePickerView.frame.width, height: 44.0)
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        datePickerView.addSubview(toolbar)
        self.monthTxtField.inputView = datePickerView
    }
    
    @objc func donePicker() {
        monthTxtField.text = month
        yearTxtField.text = year
        datePickerView.removeFromSuperview()
        monthTxtField.resignFirstResponder()
        yearTxtField.resignFirstResponder()
    }
    
    @objc func cancelPicker() {
        datePickerView.removeFromSuperview()
        monthTxtField.resignFirstResponder()
        yearTxtField.resignFirstResponder()
    }
    
    @IBAction func uploadBtnPressed(_ sender: Any) {
        let iOSPickerUI = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        iOSPickerUI.delegate = self
        iOSPickerUI.allowsMultipleSelection = false
        iOSPickerUI.modalPresentationStyle = .formSheet
        
        if let popoverPresentationController = iOSPickerUI.popoverPresentationController {
            popoverPresentationController.sourceView = sender as? UIView
        }
        self.present(iOSPickerUI, animated: true, completion: nil)
        
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        fileNameTxtField.text = ""
        fileNameTxtField.placeholder = "Press upload to select a file...."
        uploadFileURL = nil
        clearBtn.isEnabled = false
    }
    
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    /* let path = getDocumentsDirectory()
    print("########## getDocumentsDirectory : \(String(describing: path))")
    
    let companyFolder = path.appendingPathComponent("Diksha")
    
    if !companyFolder.hasDirectoryPath {
        print("########## !companyFolder.hasDirectoryPath : \(!companyFolder.hasDirectoryPath)")
        /* do
        {
            try FileManager.default.createDirectory(at: companyFolder, withIntermediateDirectories: true)
        } catch let error as NSError {
            print("Error : \(error.localizedDescription)")
        } */
        
    }
    let pathsCheck = getDocumentsDirectory().appendingPathComponent("Diksha").absoluteURL
    print("########## getDocumentsDirectory : \(String(describing: pathsCheck))") */
    
    @IBAction func addBtnPressed(_ sender: Any) {
        companyName = compNameTxtField.text
        DispatchQueue.main.async {
            // let url = URL(string: urlString)
            guard let uploadFileURL = self.uploadFileURL else { return }
            
            let pdfData = try? Data.init(contentsOf: uploadFileURL)
            let resourceDocPath = self.getDocumentsDirectory()
            let folderCreatePath = "\(self.companyName ?? "")/\(self.month ?? "")/"
            let companyFolder = resourceDocPath.appendingPathComponent(folderCreatePath)
            if !companyFolder.hasDirectoryPath {
                print("########## !companyFolder.hasDirectoryPath : \(!companyFolder.hasDirectoryPath)")
                do
                {
                    try FileManager.default.createDirectory(at: companyFolder, withIntermediateDirectories: true)
                } catch let error as NSError {
                    print("Error : \(error.localizedDescription)")
                }
                
            }
            let pdfNameFromUrl = "\(self.fileNameTxtField.text ?? "")"
            let actualPath = companyFolder.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
                // create the alert
                let alert = UIAlertController(title: "Success!!!!", message: "Pdf Added Successfully!!!!.", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            } catch let error as NSError{
                print("Pdf could not be saved")
                print("Error : \(error.localizedDescription)")
                // create the alert
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                    self.navigationController?.popViewController(animated: true)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
    }
    
}

extension AddPaySlipVC:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == monthTxtField {
            datePickerView.isHidden = false
        } else if textField == yearTxtField {
            datePickerView.isHidden = false
        }
        
    }
    
}

extension AddPaySlipVC:UIDocumentPickerDelegate{
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let firstFileURL = urls[0]
        print("UIDocumentPickerViewController gave url = \(firstFileURL)")
        let fileName = firstFileURL.lastPathComponent
        print("File name : \(fileName)")
        fileNameTxtField.text = fileName
        // let isSecuredURL = (firstFileURL.startAccessingSecurityScopedResource() == true)
        uploadFileURL = firstFileURL
        clearBtn.isEnabled = true
        print("File path: \(firstFileURL.path)")
        
    }
}

extension AddPaySlipVC:UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return "\(years[row])"
        default:
            return nil
        }
    }
}

extension AddPaySlipVC:UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            month = months[row]
        case 1:
            year = "\(years[row])"
        default:
            print("Default")
        }
    }
}
