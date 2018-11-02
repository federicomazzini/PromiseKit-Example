//
//  ViewController.swift
//  Promises
//
//  Created by federico mazzini on 02/11/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class ViewController: UITableViewController {
    
    private var cellIdentifier: String = "Cell"
    private var characters: [Character] = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 172
        
//        firstly {
//            Webservice.fetchCharacters()
//            }.done { characters in
//                self.characters = characters
//                self.tableView.reloadData()
//            }.catch { error in
//                print(error)
//        }
        
        retry()
    }
    
    func retry() {
        Webservice.attempt(maximumRetryCount: 3) {
            Webservice.fetchCharacters()
            }.done { characters in
                self.characters = characters
                self.tableView.reloadData()
            }.catch { error in
                print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! CharacterTableViewCell
        let character = self.characters[indexPath.row]
        cell.nameLabel.text = character.name
        cell.bioLabel.text = character.bio
        
        if let url = URL(string: character.imageURL) {
            cell.characterImage.setImage(withURL: url)
        }
        
        return cell
    }

}

