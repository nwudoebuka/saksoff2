//
//  ItemViewModel.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 20/08/2022.
//

import Foundation
import CoreData
import UIKit

protocol ItemViewModelState{
  func diStartRetrievingItems()
  func didFailToRetrieveItems(_ error: Error)
  func didRetrieveItems()
}

final class ItemViewModel: NSObject  {
  var delegate: ItemViewModelState?
  var allItems: [Item]?
  var tableData: [Item]?
  var items: [NSManagedObject] = []
    private var apiLoader: ServiceProtocol?
    required init(apiLoader: ServiceProtocol = Service()) {
        self.apiLoader = apiLoader
        super.init()
    }
    
    public func getItems() {
      self.delegate?.diStartRetrievingItems()
      apiLoader?.getItems({
        result in
        switch result {
        case .success(let items):
          self.allItems = items.items
          self.tableData = items.items
          self.delegate?.didRetrieveItems()
          break
        case .failure(let error):
          self.delegate?.didFailToRetrieveItems(error)
        break
        }
      })
    }

  
  func deleteRecord(name: String){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Items")

    do {
        let listOfSavedItems = try managedContext.fetch(fetchRequest)
      for object in listOfSavedItems{
        
        if (object.value(forKey: "name") as? String) == name{
          managedContext.delete(object)
          try managedContext.save()
        }
      }
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  
  
  func save(sku: String,name: String,image:UIImage, price: String,size: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Items", in: managedContext)!
    let imgData = image.jpegData(compressionQuality: 1)
    let album = NSManagedObject(entity: entity, insertInto: managedContext)
    album.setValue(name, forKeyPath: "name")
    album.setValue(sku, forKeyPath: "sku")
    album.setValue(imgData, forKeyPath: "image")
    album.setValue(price, forKeyPath: "price")
    album.setValue(size, forKeyPath: "size")
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Items")

    do {
      let allSavedData = try managedContext.fetch(fetchRequest)
        try managedContext.save()
      debugPrint("item has been saved")
     // getSavedItems()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }

  
  func getSavedItems(){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Items")

    do {
      items = try managedContext.fetch(fetchRequest)
      debugPrint("saved album is \(items)")
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }

  }
  
}




