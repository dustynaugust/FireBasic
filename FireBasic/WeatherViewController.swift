//
//  WeatherViewController.swift
//  FireBasic
//
//  Created by Dustyn August on 6/10/17.
//  Copyright © 2017 Dustyn August. All rights reserved.
//

import UIKit
import Firebase

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var previousEmailLabel: UILabel!
    
    let conditionRef = Database.database().reference().child("condition")
    let prevEmailRef = Database.database().reference().child("previous_email")


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        conditionRef.observe(.value) { (snap: DataSnapshot) in
            self.conditionLabel.text = snap.value as! String
        }
        
        prevEmailRef.observe(.value) { (snap: DataSnapshot) in
            self.previousEmailLabel.text = snap.value as! String
        }
        
    }
    
    
    @IBAction func sunnyButtonTapped(_ sender: Any) {
        conditionRef.setValue("Sunny")
        prevEmailRef.setValue(Auth.auth().currentUser?.email)
        
    }
    
    @IBAction func foggyButtonTapped(_ sender: Any) {
        conditionRef.setValue("Foggy")
        prevEmailRef.setValue(Auth.auth().currentUser?.email)
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
    }
    */
   

}
