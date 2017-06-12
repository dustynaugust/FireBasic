//
//  SignUpViewController.swift
//  FireBasic
//
//  Created by Dustyn August on 6/11/17.
//  Copyright © 2017 Dustyn August. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
  
    @IBOutlet weak var passwordTextField: UITextField!

    
    var databaseRef: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                self.databaseRef = Database.database().reference()
                
                
                self.databaseRef.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    let snapshot = snapshot.value as? NSDictionary
                    
                    if(snapshot == nil) {
                        self.databaseRef.child("users").child(user!.uid).child("name").setValue(user?.displayName)
                        self.databaseRef.child("users").child(user!.uid).child("email").setValue(user?.email)
                    }
                })

                
                if user != nil {
                    self.performSegue(withIdentifier: "SignUpToWeather", sender: self)
                } else {
                    print(error?.localizedDescription)
                }
            })
            
            
        
        
            }
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
