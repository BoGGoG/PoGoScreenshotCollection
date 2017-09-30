//
//  ErrorScreenshotsViewController.swift
//  PoGoScreenshotCollection
//
//  Created by Marco Knipfer on 27.09.17.
//  Copyright © 2017 Marco Knipfer. All rights reserved.
//

import UIKit



class ErrorScreenshotsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var gridLayout: GridLayout!
    let reuseIdentifier = "ErrorScreenshotCell"
    
    var errorScreenshotCollection = [Int: PoGoErrorScreenshot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if errorScreenshotCollection.isEmpty {
            if let collection = PoGoErrorScreenshot.loadFromDisc() {
                errorScreenshotCollection = collection
//                print("loaded from file!")
//                errorScreenshotCollection[1]?.image = UIImage(named: "ServerError")
            } else {
                errorScreenshotCollection = PoGoErrorScreenshot.defaulArray()
                PoGoErrorScreenshot.saveToDisc(poGoErrorScreenshotDictionary: errorScreenshotCollection)
            }
        }
        
        gridLayout = GridLayout(numberOfColums: 2)
        collectionView.collectionViewLayout = gridLayout
        collectionView.reloadData()
        collectionView.reloadData()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return errorScreenshotCollection.count
        return 33
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ErrorScreenshotCollectionViewCell
        
        if let id = errorScreenshotCollection[indexPath.row + 1]?.id {
            cell.label.text = "Error(\(id))"
        } else {
            cell.label.text = "no Data"
        }
        if let image = errorScreenshotCollection[indexPath.row + 1]?.image {
            cell.imageView.image = image
        } else {
            cell.imageView.image = UIImage(named: "Titanic")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pickImage()
    }
    
    // MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
    
    func pickImage() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage, let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first{
//            PoGoError.poGoErrorCollection[selectedIndexPath.row + 1]?.image = selectedImage
//            if let cell = collectionView.cellForItem(at: selectedIndexPath) as? CollectionViewCell {
//                cell.imageView.image = selectedImage
//            }
//            collectionView.reloadItems(at: [selectedIndexPath])
//            PoGoError.saveToFile()
//            dismiss(animated: true, completion: nil)
//        }
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage, let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            errorScreenshotCollection[selectedIndexPath.row + 1]?.image = selectedImage
            if let cell = collectionView.cellForItem(at: selectedIndexPath) as? ErrorScreenshotCollectionViewCell {
                cell.imageView.image = selectedImage
            }
            collectionView.reloadItems(at: [selectedIndexPath])
            PoGoErrorScreenshot.saveToDisc(poGoErrorScreenshotDictionary: errorScreenshotCollection)
            dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    

}
