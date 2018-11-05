//
//  FileService.swift
//  Promises
//
//  Created by federico mazzini on 05/11/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import Foundation
import PromiseKit

class FileService {
    
    // File writing.
    static func write(text: String, toFile filename: String, completion: @escaping (NSError?) -> ()) {
        let err = NSError(domain: "PromiseKitTutorial", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error writing to file."])
        
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(err)
            return
        }
            
        let fileURL = dir.appendingPathComponent(filename)
        
        // Writing.
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
            completion(nil)
        }
        catch {
            completion(err)
        }
    }
    
    static func write(text: String, toFile filename: String) -> Promise<Void> {
        return Promise<Void> { seal in
            FileService.write(text: text, toFile: filename, completion: { (error) in
                if let err = error {
                    seal.reject(err)
                }
                else {
                    seal.fulfill(())
                }
            })
        }
    }
    
    // File reading.
    static func read(file filename: String, completion: @escaping (String?) -> ()) {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(nil)
            return
        }
        
        let fileURL = dir.appendingPathComponent(filename)
        
        // Reading.
        do {
            let text = try String(contentsOf: fileURL, encoding: .utf8)
            completion(text)
        }
        catch {
            completion(nil)
        }
    }
    
    static func read(file filename: String) -> Promise<String> {
        return Promise<String> { seal in
            FileService.read(file: filename, completion: { (text) in
                if let fileContent = text {
                    seal.fulfill(fileContent)
                }
                else {
                    let err = NSError(domain: "PromiseKitTutorial", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error reading to file."])
                    seal.reject(err)
                }
            })
        }
    }
    
}
