//
//  Locales.swift
//  TablasFrogmi
//
//  Created by Adrian on 25-04-22.
//

import Foundation

struct Respuesta: Codable {
    var data: [Data]
    var meta: Meta
    var links: Links
}


struct Data: Codable {
    var id: String
    var attributes: Attributes
}

struct Attributes: Codable {
   var name: String
   var code: String
   var address: String

   enum CodingKeys: String, CodingKey {
    case name = "name"
    case code = "code"
    case address = "full_address"
   }
}

struct Meta: Codable {
    var pagination: Pagination
}

struct Pagination: Codable {
    var current_page : Int
    var total : Int
}

struct Links: Codable {
    var next: String?
}
