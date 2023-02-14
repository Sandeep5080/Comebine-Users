//
//  User.swift
//  Comebine Users
//
//  Created by Sandeep Reddy on 13/02/23.
//

import Foundation

struct User:  Decodable {
    let name: String
    let company: Company
   
  
}

struct Company: Decodable {
    let name: String
   
}

