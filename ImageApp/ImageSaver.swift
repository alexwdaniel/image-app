//
//  ImageSaver.swift
//  ImageApp
//
//  Created by Alexander Daniel on 4/4/20.
//  Copyright © 2020 adaniel. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    func save(image: UIImage) -> String? {
        if let data = image.pngData() {
            let uuid = UUID()
            let name = "\(uuid).png"
            let filename = self.getDocumentsDirectory().appendingPathComponent(name)
            print(filename)
            try? data.write(to: filename)
            return name
        }
        return nil
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getImage(filename: String) -> UIImage? {
        let fileManager = FileManager()
        let imagePath = self.getDocumentsDirectory().appendingPathComponent(filename)
        if fileManager.fileExists(atPath: imagePath.path) {
            let image = UIImage(contentsOfFile: imagePath.path)
            return image
        } else{
            print("No Image")
            return nil
        }
    }
}
