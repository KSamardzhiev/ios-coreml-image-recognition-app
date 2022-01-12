//
//  ViewController.swift
//  ImageRecognition
//
//  Created by Kostadin Samardzhiev on 11.01.22.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedImageView: UIImageView!
    
    let pickerVeiw = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerVeiw.delegate = self
        pickerVeiw.sourceType = .camera // .photoLibrary
        pickerVeiw.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageView.image = pickedImage
            guard let coreImage = CIImage(image: pickedImage) else {
                fatalError("Unable to convert to CIImage")
            }
            detect(image: coreImage)
            
        }
        
        pickerVeiw.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Unable to load CoreML model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Unable to procces the image")
            }
            
            print(results)
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }

    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        present(pickerVeiw, animated: true, completion: nil)
    }
    
}

