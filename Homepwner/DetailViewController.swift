//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Adam Hogan on 7/11/17.
//  Copyright © 2017 Adam Hogan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: CustomTextField!
    @IBOutlet var serialNumberField: CustomTextField!
    @IBOutlet var valueField: CustomTextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = true
        
        //if the device has a camera, take a picture; otherwise,
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            
            let overlayView = UIView(frame: imagePicker.cameraOverlayView!.frame)
            
            let crosshairLabel = UILabel()
            crosshairLabel.text = "+"
            crosshairLabel.font = UIFont.systemFont(ofSize: 50)
            crosshairLabel.translatesAutoresizingMaskIntoConstraints = false
            overlayView.addSubview(crosshairLabel)
            
            crosshairLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
            crosshairLabel.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor).isActive = true
            
            //to avoid blocking the underneath default camera controls
            overlayView.isUserInteractionEnabled = false
            
            imagePicker.cameraOverlayView = overlayView
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        //place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func clearImage(_ sender: UIBarButtonItem) {
        imageView.image = nil
        imageStore.deleteImage(forKey: item.itemKey)
    }

    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    } ()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        
        formatter.timeStyle = .none
        return formatter
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        // get the item key
        let key = item.itemKey
        
        //if there is an associated image with the item display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // clear first responder
        view.endEditing(true)
        
        //"save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "changeDate"?:
            let dateCreatedViewController = segue.destination as! DatePickerViewController
            dateCreatedViewController.item = item
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // get picked image from info dictionary
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // store the image in ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        // put that image on the screen in the image view
        imageView.image = image
        
        // take image picker off the screen
        // you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
}
