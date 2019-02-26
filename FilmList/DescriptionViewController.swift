//
//  DescriptionViewController.swift
//  FilmList
//
//  Created by Axel Imberdis on 26/02/2019.
//  Copyright © 2019 Kukana. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    var film: Film?
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var filmDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(film!.title)
        print(film!.overview)
        print(film!.vote_average)
        filmTitle.text = film!.title
        rating.text = "Note : " + String(film!.vote_average)
        filmDescription.text = film!.overview
        // Do any additional setup after loading the view.
        
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
