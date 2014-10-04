//
//  DetailView.swift
//  iOS_F2_Homework
//
//  Created by Joshua Winskill on 9/30/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

import UIKit

class DetailView: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var student: Person!

    override func viewDidLoad() {

        self.title = student.fullName()
        self.firstName.text = student.firstName
        self.lastName.text = student.lastName
        
        if self.student.studentPicture != nil {
            self.image.image = self.student.studentPicture
        } else {
            self.image.image = UIImage(named: "no_image.jpg")
        }

        self.image.contentMode = UIViewContentMode.ScaleAspectFit
        self.image.clipsToBounds = true
        
        firstName.delegate = self
        lastName.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.student.firstName = self.firstName.text
        self.student.lastName = self.lastName.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changePhotoPressed(sender: AnyObject) {
    
        // Configure UIImagePickerController
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        // Create an alert when the button is pressed
        let actionSheet = UIAlertController(title: "Choose Source", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Allow for camera selection if available
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (Alert) -> Void in
                picker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(picker, animated: true, completion: { () -> Void in
                })
            }))
        }
        
        // Allow for photo library selection
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: { (Alert) -> Void in
            picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            self.presentViewController(picker, animated: true, completion: { () -> Void in
            })
        }))
        
        // Add a cancel button to the action sheet
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (Alert) -> Void in
            actionSheet.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        // grab the photo chosen and apply it
        let photo = info[UIImagePickerControllerEditedImage] as UIImage
        self.image.image = photo
        self.student.studentPicture = photo
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        }
}
