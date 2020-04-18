//
//  PhotoViewModel.swift
//  ImageApp
//
//  Created by Alexander Daniel on 4/12/20.
//  Copyright © 2020 adaniel. All rights reserved.
//

import CoreData
import SwiftUI

class PhotoViewModel: NSObject, NSFetchedResultsControllerDelegate, ObservableObject {
    
    var objects: [Photo] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    var images: [UIImage] {
        return self.fetchImages()
    }
    
    private let fetchedResultsController: NSFetchedResultsController<Photo>
    
    override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<Photo>(entityName: "Photo")
        request.sortDescriptors = []
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        

        super.init()
        // Configure the view model to receive updates from Core Data.
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
    private func fetchImages() -> [UIImage] {
        let imageSaver = ImageSaver()
        
        return objects.compactMap { (photo) in
            guard let image = imageSaver.getImage(filename: photo.name!) else {
                return nil
            }
            
            return image
        }
    }
}
