//
//  UserModel.swift
//  UserListWidgetExtension
//
//  Created by Burak Dinç on 17.12.2022.
//

import Foundation

// MARK: User Model
struct UserModel: Decodable {
    
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: AddressModel?
    let phone: String?
    let website: String?
    let company: CompanyModel?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }
    
    internal init(id: Int? = nil,
                  name: String? = nil,
                  username: String? = nil,
                  email: String? = nil,
                  address: AddressModel? = nil,
                  phone: String? = nil,
                  website: String? = nil,
                  company: CompanyModel? = nil) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
    
}

// MARK: Address Model
struct AddressModel: Decodable {
    
    let street: String?
    let suite: String?
    let city: String?
    
    enum CodingKeys: String, CodingKey {
        case street = "street"
        case suite = "suite"
        case city = "city"
    }
    
    internal init(street: String? = nil,
                  suite: String? = nil,
                  city: String? = nil) {
        self.street = street
        self.suite = suite
        self.city = city
    }
    
}

// MARK: Company Model
struct CompanyModel: Decodable {
    
    let name: String?
    let catchPhrase: String?
    let bs: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
    
    internal init(name: String? = nil,
                  catchPhrase: String? = nil,
                  bs: String? = nil) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    
}
