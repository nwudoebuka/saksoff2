//
//  CartViewController.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 17/08/2022.
//

import UIKit

class CartViewController:  UIViewController {
  let viewModel = ItemViewModel()
  @IBOutlet weak var collectionV: UICollectionView?
  @IBOutlet weak var noDataLabel: UILabel?
  let screenWidth = UIScreen.main.bounds.width
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    layout.itemSize = CGSize(width: screenWidth/3.4, height: screenWidth/3.4)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    collectionV?.collectionViewLayout = layout
    viewModel.getSavedItems()
    collectionV?.reloadData()
  }
  
  
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let numberOfSavedItems = viewModel.items.count
    if numberOfSavedItems == 0{
      noDataLabel?.isHidden = false
    }else{
      noDataLabel?.isHidden = true
    }
    return numberOfSavedItems
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartItemCollectionViewCell.identifier, for: indexPath) as! CartItemCollectionViewCell
    cell.configure(data: viewModel.items[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItem(postion: indexPath.row)
  }
  
  func selectedItem(postion:Int){
    let alert = UIAlertController(title: "Item", message: "Delete item?", preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(title: "Remove from cart", style: .destructive , handler:{ (UIAlertAction)in
      print("User click Approve button")
      self.viewModel.deleteRecord(name: self.viewModel.items[postion].value(forKeyPath: "name") as? String ?? "")
      self.viewModel.getSavedItems()
      self.collectionV?.reloadData()
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
