//
//  AddPhotoViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/25/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import SDWebImage

protocol AddPhotoDelegate: class{
    func sendImageByDelegate(arr: [UIImage])
}
class AddPhotoViewController: MRKBaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var image :UIImage?
    var btn :UIButton?
    var imageArray :Array<UIImage> = []
    var imageStrArr :Array<String> = []

    var delegate: AddPhotoDelegate?
    var isViewPhoto :Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate  = self
        
        if isViewPhoto{
            title = "View Photo"
            setup()
        }else{
            title = "Add Photos"
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        for index in 0..<imageStrArr.count {
            let url = URL(string: imageStrArr[index])
          let tmpButton = self.view.viewWithTag(index+1) as? UIButton
            tmpButton?.sd_setImage(with: url!, for: .normal, completed: nil)
        }
        
        view.isUserInteractionEnabled = false
        let tmpButton = self.view.viewWithTag(107) as? UIButton
        tmpButton?.isHidden = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let pickedImage = info[UIImagePickerControllerOriginalImage]as? UIImage{
            let resizedImage = pickedImage.jpeg(.lowest)
            let img = UIImage(data: resizedImage!)
            let resizedImage2 = img!.jpeg(.lowest)
            image = UIImage(data: resizedImage2!)
            setImage(img: image!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setImage(img:UIImage) {
        
        btn?.setImage(img, for: .normal)
        imageArray.append(img)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addPhotoBtnAction(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        if(imagePicker.sourceType == .camera){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        btn = sender
        present(imagePicker, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func doneBtnAction(_ sender: UIButton) {
        if imageArray.count > 0 {
            delegate?.sendImageByDelegate(arr: imageArray)
        }
        navigationController?.popViewController(animated: true)
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
