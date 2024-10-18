//
//  CPListModel.swift
//  ProjectFaker4
//
//  Created by Quentin Courrier on 9/27/24.
//

import Foundation

struct CPResponse: Codable {
    let status: String
    let code: Int
    let total: Int
    let data: [Company]
}

struct Company: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let vat: String
    let phone: String
    let country: String
    let addresses: [CompanyAddress]
}

struct CompanyAddress: Codable {
    let id: Int
    let street: String
    let streetName: String
    let buildingNumber: String
    let city: String
    let zipcode: String
    let country: String
    let country_code: String // Changé de countyCode à country_code
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case street
        case streetName
        case buildingNumber
        case city
        case zipcode
        case country
        case country_code
        case latitude
        case longitude
    }
}
