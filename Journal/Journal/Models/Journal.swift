//
//  Journal.swift
//  Journal
//
//  Created by Gavin Craft on 4/20/21.
//

import Foundation
class Journal: Codable{
    //MARK: - properties
    let uuid:String
    var entries:[Entry]=[]
    var title:String
    //MARK: - Init
    init(title:String, entries:[Entry]=[], uuid:String=UUID().uuidString){
        self.title = title
        self.entries = entries
        self.uuid = uuid
    }
}
//MARK: - Extensions
extension Journal: Equatable{
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
