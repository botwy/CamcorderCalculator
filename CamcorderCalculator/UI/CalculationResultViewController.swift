//
//  CalculationResultViewController.swift
//  CamcorderCalculator
//
//  Created by Гончаров Денис Васильевич on 02.08.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit
import QuickLook

class CalculationResultViewController: UIViewController {
    @IBOutlet weak var cameraSumLabel: UILabel!
    
    @IBOutlet weak var registratorSumLabel: UILabel!
    
    @IBOutlet weak var workSumLabel: UILabel!
    
    @IBOutlet weak var totalSum: UILabel!
    
    var isValidCalculation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func setup(calculation: Calculation?) {
        guard let calculation = calculation else {
            isValidCalculation = false
            return
        }
        cameraSumLabel.text = String(calculation.cameraSum)
        registratorSumLabel.text = String(calculation.registratorSum)
        workSumLabel.text = String(calculation.workSum)
        totalSum.text = String(calculation.totalSum)
        isValidCalculation = true
    }
    @IBAction func makePDF(_ sender: Any) {
        let title = "Расчет стоимости видеонаблюдения"
        var pdfBuilder = PDFBuilder(author: "", title: title)
        pdfBuilder.addTopic(title: nil, items: [
            "Стоимость камер: \(cameraSumLabel.text ?? "") руб.",
            "Стоимость регистраторов: \(registratorSumLabel.text ?? "") руб.",
            "Стоимость работ: \(workSumLabel.text ?? "") руб.",
        ])
        pdfBuilder.addTopic(title: "Итого: \(totalSum.text ?? "") руб.", items: [])
        let pdf = pdfBuilder.buildPDF()
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let url = temporaryDirectory.appendingPathComponent("\(title).pdf")
    
        do {
            try pdf.data().write(to: url, options: .atomic)
            let previewController = QLPreviewController.makePreviewController(for: url, with: title)
            previewController.delegate = self
            present(previewController, animated: true)
        } catch {
            let alert = UIAlertController(with: error)
            present(alert, animated: true)
        }
    }
}

//MARK: - QLPreviewControllerDelegate

extension CalculationResultViewController: QLPreviewControllerDelegate {
    public func previewControllerDidDismiss(_ controller: QLPreviewController) {
        if let item = controller.currentPreviewItem, let url = item.previewItemURL, url.isFileURL {
            
            let fm = FileManager.default
            let path = url.absoluteURL.path
            guard fm.fileExists(atPath: path), fm.isDeletableFile(atPath: path) else {
                assertionFailure()
                
                return
            }
            
            OperationQueue.main.addOperation { [weak self] in
                do {
                    try fm.removeItem(at: url)
                } catch {
                    guard let self = self else { return }
                    let alert = UIAlertController(with: error)
                    self.present(alert, animated: true)
                }
            }
        }
    }
}

