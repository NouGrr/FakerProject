import Foundation

struct Person: Decodable {
    let id: Int
    let firstname: String
    let lastname: String
    let address: Address
    let image: String
}

struct Address: Decodable {
    let street: String
    let city: String
    let country: String
    let zipcode: String
}

struct PersonResponse: Decodable {
    let status: String
    let code: Int
    let locale: String
    let seed: String?
    let total: Int
    let data: [Person]
}

struct PersonIdentifiable : Identifiable {
    let idList: Int
    
    let id: Int
    let firstname: String
    let lastname: String
    let address: Address
    let image: String
}








