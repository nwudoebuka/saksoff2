//
//  BaseViewController.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 20/08/2022.
//

import UIKit

class BaseViewController: UIViewController {
  var spinner:UIView!;
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

  func showMessage(_ title:String,_ msg:String){
      let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)

      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        }))

      present(alert, animated: true, completion: nil)
  }
  
  func showLoading() {
      if(spinner != nil){
          hideLoading();
      }
      spinner = displaySpinner(onView: self.view)
  }
 
  func hideLoading() {
      removeSpinner(spinner: spinner ?? UIView())
  }

  func removeSpinner(spinner: UIView) {
      DispatchQueue.main.async {
          
          spinner.removeFromSuperview()
      }
  }
  func displaySpinner(onView: UIView) -> UIView {
      let spinnerView = UIView.init(frame: onView.bounds)
      
      spinnerView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
      
      let ai = UIActivityIndicatorView.init(style: .gray)
      ai.style = .large
      ai.startAnimating()
      ai.center = spinnerView.center
      
      DispatchQueue.main.async {
          spinnerView.addSubview(ai)
          ai.startAnimating()
          onView.addSubview(spinnerView)
      }
      
      return spinnerView
  }
  
  
}
