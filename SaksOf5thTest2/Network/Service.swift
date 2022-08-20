//
//  Service.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 20/08/2022.
//

import Foundation
import Alamofire
protocol ServiceProtocol {
  func getItems(_ completion: @escaping (Result<ItemsModel,Error>)->())
  func orderItem(_ param:Parameters,_ completion: @escaping (Result<OrderModel,Error>)->())
}
class Service:ServiceProtocol {
  
  func orderItem(_ param: Parameters, _ completion: @escaping (Result<OrderModel, Error>) -> ()) {
    let url = "\(BASE_URL)/b220aa4e-25da-458b-a2ab-152bf4403925"
    AF.request(url)
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success:
          if let data = response.data{
            do {
              let response = try JSONDecoder().decode(OrderModel.self, from: data)
              
              completion(Result.success(response))
            } catch {
              completion(Result.failure(NetworkError.encodingFailed))
            }
          }
          
          break
        case .failure(let error):
          completion(Result.failure(error))
          break
        }
      }
    
  }
  
  func getItems(_ completion: @escaping (Result<ItemsModel,Error>)->()){
    let url = "\(BASE_URL)/82b41dbe-f526-42fc-9b26-38916af6f6d4"
    AF.request(url)
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success:
          if let data = response.data{
            do {
              let items = try JSONDecoder().decode(ItemsModel.self, from: data)
              
              completion(Result.success(items))
            } catch {
              completion(Result.failure(NetworkError.encodingFailed))
            }
          }
          
          break
        case .failure(let error):
          completion(Result.failure(error))
          break
        }
      }
    
  }
  
  
  
}



