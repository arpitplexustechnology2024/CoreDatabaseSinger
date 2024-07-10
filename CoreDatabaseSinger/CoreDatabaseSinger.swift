//
//  CoreDatabaseSinger.swift
//  CoreDatabaseSinger
//
//  Created by Arpit iOS Dev. on 10/07/24.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Singer CRUD Operations
    
    func createSinger(name: String) {
        let newSinger = Singer(context: context)
        newSinger.name = name
        
        saveContext()
    }
    
    func fetchSingers() -> [Singer] {
        let request: NSFetchRequest<Singer> = Singer.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch singers: \(error)")
            return []
        }
    }
    
    // MARK: - Song CRUD Operations
    
    func createSong(name: String, singer: Singer) {
        let newSong = Song(context: context)
        newSong.name = name
        newSong.singer = singer
        
        saveContext()
    }
    
    func fetchSongs() -> [Song] {
        let request: NSFetchRequest<Song> = Song.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch songs: \(error)")
            return []
        }
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
