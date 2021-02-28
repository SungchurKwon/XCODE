//
//  ViewController.swift
//  test_instagram
//
//  Created by 권성철 on 2021/02/02.
//
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
          
    }
    
    private func handleNotAuthenticated(){
        // Show login
        if Auth.auth().currentUser == nil{
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }
    }
}

