//
//  SingerNameShowViewController.swift
//  CoreDatabaseSinger
//
//  Created by Arpit iOS Dev. on 10/07/24.
//

import UIKit

class SingerNameShowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var singers: [Singer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicator.style = .large
        loadData()
    }
    
    func loadData() {
        tableView.isHidden = true
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.singers = CoreDataManager.shared.fetchSingers()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.isHidden = false
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let songsViewController = storyboard.instantiateViewController(withIdentifier: "SongsViewController") as? SongsViewController {
            songsViewController.selectedSinger = singers[indexPath.row]
            navigationController?.pushViewController(songsViewController, animated: true)
        }
    }
}
