//
//  JournalListTableViewController.swift
//  Journal
//
//  Created by Gavin Craft on 4/20/21.
//

import UIKit

class JournalListTableViewController: UITableViewController {
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        JournalController.shared.loadFromPersistenceStore()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return JournalController.shared.journals.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath)
        let journal = JournalController.shared.journals[indexPath.row]

        cell.textLabel?.text = journal.title
        if(journal.entries.count==1){
            cell.detailTextLabel?.text = "1 Entry"
        }else{
            cell.detailTextLabel?.text = "\(journal.entries.count) Entries"
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let journal = JournalController.shared.journals[indexPath.row]
        if editingStyle == .delete {
            JournalController.shared.deleteJournal(journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    //MARK: - ibactions
    @IBAction func addButtonPressed(_ sender: Any) {
        createAlertForNewJournal()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = tableView.indexPathForSelectedRow else {return}
        guard let destinationVC = segue.destination as? EntryListTableViewController else {return}
        if segue.identifier == "JournalToEntry"{
            destinationVC.journal = JournalController.shared.journals[index.row]
        }
    }
    //MARK: - custom funcs
    func createAlertForNewJournal(){
        let alert = UIAlertController(title: "New Journal", message: "Enter Journal Name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Journal Name Here"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let acceptAction = UIAlertAction(title: "K", style: .default) { (_) in
            guard let title = alert.textFields![0].text else {return}
            print(title)
            JournalController.shared.createJournal(title: title )
            print("\(JournalController.shared.journals.count)")
            self.tableView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
}
