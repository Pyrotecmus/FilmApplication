//
//  FilmTableViewController.swift
//  FilmList
//
//  Created by Axel Imberdis on 21/02/2019.
//  Copyright © 2019 Kukana. All rights reserved.
//

import Foundation
import UIKit

class FilmTableViewController: UITableViewController
{
    //MARK: Properties
    final let url = URL(string: "https://api.themoviedb.org/3/list/28?api_key=5c4735de94a76d0a850fd8d98c2d14c6&language=en-US")
    private var films = [Film]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        downloadJson()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return films.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "FilmTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FilmTableViewCell
        else
        {
            fatalError("The dequeued cell is not an instance of FilmTableViewCell")
        }
        
        //Fetches the appropriate film for the data source layout
        cell.labelName.text = films[indexPath.row].title
        cell.rating.text = String(films[indexPath.row].vote_average)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "")
        {
        case "Search":
            print("Search")
        case "ShowDetail":
            guard let detailInformation = segue.destination as? DescriptionViewController
                else
            {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedFilmCell = sender as? FilmTableViewCell
                else
            {
                fatalError("Unexpected sender : \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedFilmCell)
                else
            {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = films[indexPath.row]
            detailInformation.film = selectedMeal
        default:
            fatalError("Unexpected segue identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Private Methods
    private func downloadJson()
    {
        guard let downloadURL = url
            else
        {
            return
        }
        
        URLSession.shared.dataTask(with: downloadURL)
        {
            data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil
            else
            {
                print("something went wrong before downloading")
                return
            }
            do
            {
                let decoding = try JSONDecoder().decode(Films.self, from: data)
                self.films = decoding.items
                DispatchQueue.main.async
                {
                    
                    self.tableView.reloadData()
                }
            }
            catch
            {
                print("something went wrong after downloading")
            }
        }.resume()
    }
}
