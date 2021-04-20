//
//  DetailViewController.swift
//  Journal
//
//  Created by Gavin Craft on 4/19/21.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - iboutlets
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var titleTextPane: UITextField!
    //MARK: - properties
    var entry:Entry?
    var journal:Journal?
    //MARK: - lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    //MARK: - ibactions
    @IBAction func clearButton(_ sender: UIButton) {
        titleTextPane.text = ""
        bodyTextView.text = ""
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let title = titleTextPane.text, !title.isEmpty,
              let journal = journal,
              let body = bodyTextView.text, !body.isEmpty else {return}
        if let entry = entry{
            JournalController.shared.updateEntry(entry: entry, title: title, body: body)
            JournalController.shared.saveToPersistenceStore()
            //existing so update
        }else{
            //not a entry so save new
            JournalController.shared.createEntry(title: title, body: body, journal: journal)
            JournalController.shared.saveToPersistenceStore()
        }
        titleTextPane.becomeFirstResponder()
        titleTextPane.resignFirstResponder()
        navigationController?.popViewController(animated: true)
        updateViews()
    }
    //MARK: - custom funcs
    private func updateViews(){
        guard let entry = entry else {return}
        bodyTextView.text = entry.body
        titleTextPane.text = entry.title
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
