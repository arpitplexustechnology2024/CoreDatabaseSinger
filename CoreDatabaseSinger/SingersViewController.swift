//
//  ViewController.swift
//  CoreDatabaseSinger
//
//  Created by Arpit iOS Dev. on 10/07/24.
//

import UIKit
import CoreData

class SingersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var singers: [Singer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        fetchSingers()
    }
    
    @IBAction func saveSinger(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            return
        }
        
        tableView.isHidden = true
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            CoreDataManager.shared.createSinger(name: name)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.fetchSingers()
                self.nameTextField.text = ""
                self.tableView.isHidden = false
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func fetchSingers() {
        singers = CoreDataManager.shared.fetchSingers()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingerCell", for: indexPath)
        let singer = singers[indexPath.row]
        cell.textLabel?.text = singer.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singer = singers[indexPath.row]
        
        let alert = UIAlertController(title: "Update/Delete Singer", message: "Update or delete the selected singer", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = singer.name
        }
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { [weak self] _ in
            guard let newName = alert.textFields?.first?.text, !newName.isEmpty else {
                return
            }
            CoreDataManager.shared.updateSinger(singer: singer, newName: newName)
            self?.fetchSingers()
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            CoreDataManager.shared.deleteSinger(singer: singer)
            self?.fetchSingers()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
