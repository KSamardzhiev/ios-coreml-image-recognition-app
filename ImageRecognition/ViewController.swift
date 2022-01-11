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
        }
        
        pickerVeiw.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        present(pickerVeiw, animated: true, completion: nil)
    }
    
}

