//
//  ViewController.swift
//  FirebaseTest
//
//  Created by hale on 23.09.2019.
//  Copyright © 2019 hale. All rights reserved.
//

import UIKit
//Firebase implementation
 //import FirebaseFirestore
 //import FirebaseDatabase
import FirebaseDatabase
import GoogleMaps


class ViewController: UIViewController {


    @IBOutlet weak var showMap: UIButton!
    //
    @IBAction func showMap(_ sender: UIButton) {
       
        //  let googleMapVC = GoogleMapsViewController()
        //  self.present(googleMapVC, animated: true, completion:nil)
       self.performSegue(withIdentifier: "goToMap", sender: self)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
        
    }


    
}/*end of class*/
