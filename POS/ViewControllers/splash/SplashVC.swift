//
//  SplashVC.swift
//  POS
//
//  Created by Ashwani Kumar on 29/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialProgressView


class SplashVC: UIViewController {
//    @IBOutlet weak var activityIndicator: MDCActivityIndicator!
//    
//    @IBOutlet weak var logoImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        openLoginViewController()

    }
    
    override func viewDidLayoutSubviews() {
        openLoginViewController()
    }
    
    func openLoginViewController() {
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        
        present(loginViewController!, animated: true, completion: nil)
        
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
