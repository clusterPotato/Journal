//
//  EntryController.swift
//  Journal
//
//  Created by Gavin Craft on 4/19/21.
//

import Foundation
class EntryController{
    static let shared = EntryController()
    var entries:[Entry] = []
    //MARK: - CRUD funcs
    func createEntryWith(titleToAppend:String, bodyOfMessage:String){
        entries.append(Entry(title: titleToAppend, body: bodyOfMessage))
        saveToPersistenceStore()
    }
    func deleteEntry(entryToDelete:Entry){
        guard let index = entries.firstIndex(of: entryToDelete) else {return}
        entries.remove(at: index)
        saveToPersistenceStore()
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: -  persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Journal.json")
        return fileURL
    }
    func saveToPersistenceStore(){
        do{
            let data = try JSONEncoder().encode(entries)
            try data.write(to: createPersistenceStore())
        }catch{
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    func loadFromPersistenceStore(){
        do{
            let data = try Data(contentsOf: createPersistenceStore())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        }catch{
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}
