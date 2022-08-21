//
//  ItemTableViewCell.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 17/08/2022.
//


import UIKit

class ItemTableViewCell: UICollectionViewCell {
  @IBOutlet weak var titleLabel: UILabel?
  @IBOutlet weak var statusLabel: UILabel?
  @IBOutlet weak var itemImage: UIImageView?
  @IBOutlet weak var mainView: UIView?
  
  static let identifier = "ItemTableViewCell"
  
    override func awakeFromNib() {
        super.awakeFromNib()
      mainView?.dropShadow()
    }
  
  func configure(data: Item){
    titleLabel?.text = data.name
   // data.active ? "Active" : "Inactive"
    itemImage?.setImage(with: data.image)
    if(data.active){
      statusLabel?.text = "Active"
      statusLabel?.textColor = .systemGreen
    }
   
  }
}

