//
//  AddRecipeViewController.swift
//  delishApp
//
//  Created by admin on 20/12/2016.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import UIKit
import RealmSwift

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    var label = "";
    var totalRecipes = 5;
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        timeText.text! = "\(Int(sender.value))"
    }
    
    @IBAction func proteinSwitch(_ sender: UISwitch) {
        if(sender.isOn == true){
            label = "High Protein"
        }
    }
    @IBAction func fatSwitch(_ sender: UISwitch) {
        if(sender.isOn == true){
            label = "Low Fat"
        }
    }
    @IBAction func carbSwitch(_ sender: UISwitch) {
        if(sender.isOn == true){
            label = "Low Carb"
        }
    }
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        //get all info
        let newRecipe = Recipe()
        newRecipe.id = totalRecipes+1;
        newRecipe.title = titleText.text!
        newRecipe.time = Int(timeText.text!)!
        newRecipe.label = label
        newRecipe.imageURL = "defaultImage"
        totalRecipes += 1
        //save to realm
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(newRecipe)
            print("new recipe created: \(newRecipe.title)")
        }
        //dismiss
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //get the photo and append to image view
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up dropdown menu
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
