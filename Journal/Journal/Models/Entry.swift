//
//  Entry.swift
//  Journal
//
//  Created by Gavin Craft on 4/19/21.
//

import Foundation
class Entry: Codable{
    //MARK: - instance variables/consts
    let timestamp:Date
    var title:String
    var body:String
    let uuid:String
    //MARK: - init
    init(title:String, body:String){
        timestamp = Date()
        self.body = body
        self.title = title
        uuid = UUID().uuidString
    }
}
//MARK: - extensions
extension Entry: Equatable{
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    
}
