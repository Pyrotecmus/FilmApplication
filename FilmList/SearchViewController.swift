//
//  SearchViewController.swift
//  FilmList
//
//  Created by Axel Imberdis on 26/02/2019.
//  Copyright © 2019 Kukana. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate
{
    //MARK: Properties
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    var search = [Found]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Handle the text fields user input through delegate callbacks
        searchTextField.delegate = self
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //Hide keyboard
        searchTextField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        var urlPath = "https://api.themoviedb.org/3/search/movie?api_key=5c4735de94a76d0a850fd8d98c2d14c6&language=en-US&query="
        let stringtoChange = searchTextField.text
        let stringChanged = stringtoChange?.replacingOccurrences(of: " ", with: "%20")
        
        urlPath += stringChanged!
        guard let downloadUrl = URL(string: urlPath)
        else
        {
            return
        }

        URLSession.shared.dataTask(with: downloadUrl)
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
                let decoding = try JSONDecoder().decode(Search.self, from: data)
                self.search = decoding.results
                DispatchQueue.main.async
                {
                    if decoding.total_results != 0
                    {
                        self.rating.text = "Note : " + String(self.search[0].vote_average)
                        self.Description.text = self.search[0].overview
                    }
                    else
                    {
                        self.Description.text = "No Film Found"
                    }
                }
            }
            catch
            {
                print("something went wrong after downloading")
            }
            }.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
