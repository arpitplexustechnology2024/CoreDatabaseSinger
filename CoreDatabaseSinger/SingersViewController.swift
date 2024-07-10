//
//  ViewController.swift
//  CoreDatabaseSinger
//
//  Created by Arpit iOS Dev. on 10/07/24.
//

import UIKit
import CoreData

class SingersViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var singerNameTextField: UITextField!
    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var singersPickerView: UIPickerView!
    
    var singers: [Singer] = []
    var songs: [Song] = []
    var selectedSinger: Singer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singersPickerView.dataSource = self
        singersPickerView.delegate = self
        singersPickerView.isHidden = true
        loadSingers()
    }
    
    func loadSingers() {
        singers = CoreDataManager.shared.fetchSingers()
        singersPickerView.reloadAllComponents()
    }
    
    @IBAction func saveSinger(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            return
        }
            CoreDataManager.shared.createSinger(name: name)
            self.nameTextField.text = ""
    }
    
    @IBAction func saveSongButtonTapped(_ sender: UIButton) {
        guard let songName = songNameTextField.text, !songName.isEmpty,
              let selectedSinger = selectedSinger else {
            return
        }
        CoreDataManager.shared.createSong(name: songName, singer: selectedSinger)
        songNameTextField.text = ""
        singerNameTextField.text = ""
    }
    
    @IBAction func dropDownTapped(_ sender: UIButton) {
        singersPickerView.isHidden = false
    }
    
    
    @IBAction func showSingers(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let singersTableViewController = storyboard.instantiateViewController(withIdentifier: "SingerNameShowViewController") as? SingerNameShowViewController {
            navigationController?.pushViewController(singersTableViewController, animated: true)
        }
    }
}

extension SingersViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return singers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return singers[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSinger = singers[row]
        singerNameTextField.text = selectedSinger?.name
        singersPickerView.isHidden = true
    }
}
