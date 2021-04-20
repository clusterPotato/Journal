//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Gavin Craft on 4/20/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    //MARK: - props
    var journal:Journal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let journal = journal else {return 0}
        return journal.entries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)

        cell.textLabel?.text = journal?.entries[indexPath.row].title

        return cell
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let journal = journal else {return}
        if editingStyle == .delete {
            JournalController.shared.deleteEntry(entry: journal.entries[indexPath.row], journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailViewController else {return}
        destinationVC.journal = journal
        guard let index = tableView.indexPathForSelectedRow else {return}
        if segue.identifier == "EntryCellToDetail"{
            destinationVC.entry = journal?.entries[index.row]
        }
    }


}
