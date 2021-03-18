//
//  ImageViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 25.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imageUrlTextFild: UITextField!
    
    @IBOutlet weak var ImageUrlBtn: UIButton!
    var car :Car?
    var images = [UIImage]()
     var imagesUrl = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        

       
    }
    
    
    @IBAction func AddImage(_ sender: Any) {
        let url = URL(string:imageUrlTextFild.text!)!
        imagesUrl.append(imageUrlTextFild.text!)
        imageUrlTextFild.text = ""
        if let image = try? Data(contentsOf: url){
            images.append(UIImage(data:image)!)
            collectionView.reloadData()
        }
    }
    @IBAction func AddImagePicker(_sender: Any){
            
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = try? Data(contentsOf: info[.imageURL]! as! URL){
            images.append(UIImage(data:image)!)
            collectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "postSegue"){
            let vc = segue.destination as! PostCarDateViewController
            vc.car = self.car

        
            vc.imagesUrl = self.imagesUrl
        }
    }
   

}
extension ImageViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarImageCellId", for: indexPath) as! ImageCollectionViewCell
        
        cell.carImage.image = images[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let size = self.view.frame
        
        return CGSize(width: 150, height: 150)
    }
    
    
}
