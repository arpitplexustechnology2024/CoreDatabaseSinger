//
//  SongsViewController.swift
//  CoreDatabaseSinger
//
//  Created by Arpit iOS Dev. on 10/07/24.
//

import UIKit

class SongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedSinger: Singer?
    var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicator.style = .large
        loadSongs()
    }
    
    func loadSongs() {
        tableView.isHidden = true
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            guard let singer = selectedSinger else { return }
            songs = CoreDataManager.shared.fetchSongs().filter { $0.singer == singer }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.isHidden = false
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        return cell
    }
}
