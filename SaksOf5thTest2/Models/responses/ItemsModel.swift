//
//  ItemsModel.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 20/08/2022.
//

import Foundation
struct ItemsModel: Codable {
  let items: [Item]
  let isSuccess: Bool
  let error: String
  let message: String?
  let responseCode: String?
}

struct Item: Codable{
  let sku,price,name,description,image,deliveryTime:String
  let active: Bool
  let sizes: [String]
  let inventory: [Inventory]
  enum CodingKeys: String, CodingKey {
    case deliveryTime = "delivery_time"
    case sku,price,name,description,image
    case active
    case sizes
    case inventory
  }
}

struct Inventory: Codable{
  let size: String
  let qty: Int
}
