//
//  CartItemCollectionViewCell.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 17/08/2022.
//

import UIKit
import CoreData

class CartItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "CartItemCollectionViewCell"
  @IBOutlet weak var nameLabel: UILabel?
  @IBOutlet weak var image: UIImageView?
  @IBOutlet weak var priceAndSizeLabel: UILabel?
  
  func configure(data: NSManagedObject){
    nameLabel?.text = data.value(forKeyPath: "name") as? String
    let imageData = data.value(forKeyPath: "image")  as! Data
    image?.image = UIImage(data:imageData,scale:1.0)
    let price = data.value(forKeyPath: "price") as? String
    let size = data.value(forKeyPath: "size") as? String
    priceAndSizeLabel?.text = "$\(price as! String) x \(size as! String)"
  }
}
