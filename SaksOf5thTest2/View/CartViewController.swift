//
//  CartViewController.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 17/08/2022.
//

import UIKit

class CartViewController:  UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }


}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartItemCollectionViewCell.identifier, for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem(postion: indexPath.row)
  }

  func selectedItem(postion:Int){
    let alert = UIAlertController(title: "Item", message: "Delete item?", preferredStyle: .actionSheet)
       
 
      alert.addAction(UIAlertAction(title: "Remove from cart", style: .destructive , handler:{ (UIAlertAction)in
          print("User click Approve button")
      }))

      
     
       
       alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler:{ (UIAlertAction)in
           print("User click Dismiss button")
       }))

       
       //uncomment for iPad Support
       //alert.popoverPresentationController?.sourceView = self.view

       self.present(alert, animated: true, completion: {
           print("completion block")
       })
  }
  
}
