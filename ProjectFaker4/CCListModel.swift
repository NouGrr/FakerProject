//
//  CCListModel.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/13/24.
//

import Foundation

struct CreditCard: Decodable {
    let type: String
    let number: String
    let expiration: String
    let owner: String
}

struct CCResponse: Decodable{
    let status: String
    let code: Int
    let locale: String
    let seed: String?
    let total: Int
    let data: [CreditCard]
}

 
