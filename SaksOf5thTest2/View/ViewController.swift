//
//  ViewController.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 17/08/2022.
//

import UIKit

class ViewController: UIViewController {
  
  @IBAction func cartButtonAction(_ sender: Any){
    let cartVC = storyboard?.instantiateViewController(withIdentifier: "CartViewController")
    navigationController?.pushViewController(cartVC!, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 17
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemTableViewCell.identifier, for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem(postion: indexPath.row)
  }

  func selectedItem(postion:Int){
    let alert = UIAlertController(title: "Item", message: "Please select size", preferredStyle: .actionSheet)
       
    for i in 0...3{
      alert.addAction(UIAlertAction(title: "XL", style: .default , handler:{ (UIAlertAction)in
          print("User click Approve button")
      }))
    }
      
     
       
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
