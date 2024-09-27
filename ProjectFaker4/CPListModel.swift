//
//  CPListModel.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/27/24.
//

import Foundation

struct CP: Decodable{
    let id: Int
    let name: String
    let email: String
    let vat: String
    let phone: String
    let country: String
    let addresses: Addresses
}


struct Addresses: Decodable {
    let street: String
    let city: String
    let country: String
    let zipcode: String
}

struct CPResponse: Decodable{
    let id: Int
    let name: String
    let email: String
    let vat: String
    let phone: String
    let country: String
    let addresses: Addresses
    let data: [CP]
}
