//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Gavin Craft on 4/19/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.loadFromPersistenceStore()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        cell.textLabel?.text = "\(EntryController.shared.entries[indexPath.row].title)"

        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            EntryController.shared.deleteEntry(entryToDelete: EntryController.shared.entries[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else {return}
        if segue.identifier == "cellToDetails"{
            guard let index = tableView.indexPathForSelectedRow else {return}
            let currentEntry = EntryController.shared.entries[index.row]
            
            detailVC.bodyTitle = currentEntry.title
            detailVC.bodyText = currentEntry.title
        }else if segue.identifier == "addButtonToDetails"{
            
        }
    }

}
