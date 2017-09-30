//
//  FunnyScreenshotsViewController.swift
//  PoGoScreenshotCollection
//
//  Created by Marco Knipfer on 27.09.17.
//  Copyright © 2017 Marco Knipfer. All rights reserved.
//

import UIKit

class FunnyScreenshotsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let reuseIdentifier = "FunnyScreenshotCell"
    var gridLayout: GridLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var funnyScreenshots = [PoGoFunnyScreenshot]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridLayout = GridLayout(numberOfColums: 2)
        collectionView.collectionViewLayout = gridLayout
        collectionView.reloadData()
        collectionView.reloadData()

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funnyScreenshots.count < 2 ? 2 : funnyScreenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FunnyScreenshotCollectionViewCell
        
        if indexPath.row < funnyScreenshots.count {
            let image = funnyScreenshots[indexPath.row].image
            cell.imageView.image = image
//            cell.label =
        } else {
            cell.imageView.image = UIImage(named: "Titanic")
            cell.label.text = "💰🤑💰"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let funnyScreenshot = funnyScreenshots.remove(at: sourceIndexPath.row)
        funnyScreenshots.insert(funnyScreenshot, at: destinationIndexPath.row)
        collectionView.deleteItems(at: [sourceIndexPath])
        collectionView.insertItems(at: [destinationIndexPath])
        collectionView.cellForItem(at: <#T##IndexPath#>)
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
