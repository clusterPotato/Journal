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
    var bodyTitle:String = ""
    var bodyText:String = ""
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
              let body = bodyTextView.text, !body.isEmpty else {return}
        EntryController.shared.createEntryWith(titleToAppend: title, bodyOfMessage: body)
        
    }
    private func updateViews(){
        bodyTextView.text = bodyText
        titleTextPane.text = bodyTitle
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
