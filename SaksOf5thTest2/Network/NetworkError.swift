//
//  NetwoekError.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 20/08/2022.
//

import Foundation

import Foundation
public enum NetworkError : String, Error {
  case parametersNil = "Parameters were nil."
  case badRequestOrUnAuthorized = "Your request is invalid or unauthorized."
  case encodingFailed = "Parameter encoding failed."
  case missingURL = "URL is nil."
  case unKnown = "Unknown Error"
  case notFound = "Not found"
  case serverError = "There is an error from the server"
  case limitError = "You have exceeded the Limit allocated to the GIF API key"
}
