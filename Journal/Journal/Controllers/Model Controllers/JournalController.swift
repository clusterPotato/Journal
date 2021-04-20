//
//  JournalController.swift
//  Journal
//
//  Created by Gavin Craft on 4/20/21.
//

import Foundation
class JournalController{
    //MARK: - properties
    static let shared = JournalController()
    var journals:[Journal]=[]
    
    //MARK: - CRUD funcs
    func createEntry(title:String, body:String, journal:Journal){
        let newEntry = Entry(title: title, body: body)
        journal.entries.append(newEntry)
        saveToPersistenceStore()
    }
    func updateEntry(entry:Entry, title:String, body:String){
        entry.title = title
        entry.body = body
        saveToPersistenceStore()
    }
    func deleteEntry(entry: Entry, journal: Journal){
        guard let index = journal.entries.firstIndex(of: entry) else {return}
        journal.entries.remove(at: index)
        saveToPersistenceStore()
    }
    func createJournal(title:String){
        journals.append(Journal(title:title))
        saveToPersistenceStore()
    }
    func deleteJournal(journal: Journal){
        guard let index = journals.firstIndex(of: journal) else {return}
        journals.remove(at: index)
    }
    
    //MARK: -  persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Journals.json")
        return fileURL
    }
    func saveToPersistenceStore(){
        do{
            let data = try JSONEncoder().encode(journals)
            try data.write(to: createPersistenceStore())
        }catch{
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    func loadFromPersistenceStore(){
        do{
            let data = try Data(contentsOf: createPersistenceStore())
            journals = try JSONDecoder().decode([Journal].self, from: data)
        }catch{
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}
