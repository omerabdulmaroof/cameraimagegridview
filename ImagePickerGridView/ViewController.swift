//
//  ViewController.swift
//  ImagePickerGridView
//
//  Created by OMER ABDUL MAROOF on 02.09.18.
//  Copyright © 2018 OMER ABDUL MAROOF. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate{

    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var imageToSave: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func takePicture(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveImage(_ sender: UIButton) {
       // UIImageWriteToSavedPhotosAlbum(imageToSave.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        saveImageToLocalDisk(imageName: "sundus" + String(Date.timeIntervalSinceReferenceDate))
    }
    
    @IBAction func showGridView(_ sender: UIButton) {
        
    }
    
    
    func saveImageToLocalDisk(imageName: String){
        //create an instance of the FileManager
        let fileManager = FileManager.default
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = imageToSave.image!
        //get the PNG data for this image
        let data = UIImagePNGRepresentation(image)
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
}

extension ViewController :  UIImagePickerControllerDelegate  {
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Saved!", message: "Image saved successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageToSave.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
}

