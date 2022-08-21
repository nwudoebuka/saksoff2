//
//  ViewController.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 17/08/2022.
//

import UIKit

class ViewController: BaseViewController {
  @IBOutlet weak var collectionV: UICollectionView?
  @IBOutlet weak var searchTxtFD: UITextField?
  @IBOutlet weak var balanceLabel: UILabel?
  @IBOutlet weak var cartButtonOutlet: UIButton?
  var totalAmount:Double = 0.0
  var numberOfItemsInCart = UserDefaults.standard.integer(forKey: CART_ITEMS)
  @IBAction func cartButtonAction(_ sender: Any){
    let cartVC = storyboard?.instantiateViewController(withIdentifier: "CartViewController")
    navigationController?.pushViewController(cartVC!, animated: true)
  }
  let viewModel = ItemViewModel()
  let screenWidth = UIScreen.main.bounds.width
  override func viewDidLoad() {
    super.viewDidLoad()
    debugPrint("cart Items \(numberOfItemsInCart)")
    searchTxtFD?.addTarget(self, action: #selector(ViewController.searchFieldDidChange(_:)), for: .editingChanged)
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
       layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    layout.itemSize = CGSize(width: screenWidth/3.4, height: screenWidth/3.4)
       layout.minimumInteritemSpacing = 0
       layout.minimumLineSpacing = 0
       collectionV?.collectionViewLayout = layout
    viewModel.delegate = self
    viewModel.getItems()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    UserDefaults.standard.set(1000, forKey: "TOTAL_AMOUNT")
    totalAmount = UserDefaults.standard.double(forKey: "TOTAL_AMOUNT")
    getTotalItems()
  }
  
  @objc func searchFieldDidChange(_ textField: UITextField) {
    debugPrint("search text is \(textField.text)")
    viewModel.tableData = viewModel.allItems?.filter {
      $0.name.contains(textField.text!)
    }
    if textField.text!.isEmpty{
      viewModel.tableData = viewModel.allItems
    }
    collectionV?.reloadData()
  }

}

extension ViewController: ItemViewModelState{
  func diStartRetrievingItems() {
    showLoading()
  }
  
  func didFailToRetrieveItems(_ error: Error) {
    hideLoading()
    showMessage("Failed", error.localizedDescription)
  }
  
  func didRetrieveItems() {
    hideLoading()
    collectionV?.reloadData()
  }
  
  func getTotalItems(){
    viewModel.getSavedItems()
    for item in viewModel.items{
      let price = (item.value(forKey: "price") as? String) ?? "0"
      totalAmount -= Double(price) ?? 0.0
      debugPrint("total amount is \(totalAmount) and \((item.value(forKey: "price") as? String))")
      if totalAmount > 0{
      balanceLabel?.text = "Balance $\( String(format: "%.2f", totalAmount))"
      }
    }
    cartButtonOutlet?.setTitle(String(viewModel.items.count), for: .normal
    )
  }
  
  
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let count = viewModel.tableData?.count else {
      return 0
    }
    return count
   
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
    cell.configure(data: (viewModel.tableData?[indexPath.row])!)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? ItemTableViewCell else {
          // couldn't get the cell for some reason
          return
      }
    if(totalAmount == 0 || totalAmount < Double(viewModel.tableData?[indexPath.row].price ?? "0") ?? 0){
      showMessage("Insufficient balance", "you do not have enough balance")
      return
    }
    if(viewModel.tableData?[indexPath.row].active ?? false){
      selectedItem(postion: indexPath.row,cell: cell)
    }else{
      showMessage("Inactive", "This product is unavailable at the moment")
    }
  
  }

  func selectedItem(postion:Int,cell: ItemTableViewCell){
    let alert = UIAlertController(title: "Item", message: "Please select item size to add to cart", preferredStyle: .actionSheet)
       
    for i in 0...(viewModel.tableData?[postion].sizes.count)! - 1{
      alert.addAction(UIAlertAction(title: viewModel.tableData?[postion].sizes[i], style: .default , handler:{ (UIAlertAction)
        in
          debugPrint("User click Approve button \(self.viewModel.tableData?[postion].price ?? "")")
        self.viewModel.save(sku: self.viewModel.tableData?[postion].sku ?? "N/A", name: self.viewModel.tableData?[postion].name ?? "", image: cell.itemImage?.image ?? UIImage(), price: self.viewModel.tableData?[postion].price ?? "",size:self.viewModel.tableData?[postion].sizes[i] ?? "")
        self.getTotalItems()
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
