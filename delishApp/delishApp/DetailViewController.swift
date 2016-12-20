//
//  DetailViewController.swift
//  RealmRecipes
//
//  Created by admin on 12/12/2016.
//  Copyright © 2016 Vik Nikolova. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var recipeTitle = String()
    var time = String()
    var recipeImage = UIImage()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBAction func closeBtnTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindToRecipes", sender: self)

    }
 
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = recipeTitle
        timeLabel.text = time
        image.image = recipeImage
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    */

}
