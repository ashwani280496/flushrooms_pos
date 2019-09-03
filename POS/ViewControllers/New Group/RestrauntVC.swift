//
//  RestrauntVC.swift
//  POS
//
//  Created by Ashwani Kumar on 05/07/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit

class RestrauntVC: UIViewController {
    var selectedOutlet: OutletModel?
    
    @IBOutlet weak var tableView: UITableView!
    let emptyContainerCell = "EmptyContainerCellTableViewCell"
    let filledCell = "FilledCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: emptyContainerCell, bundle: nil), forCellReuseIdentifier: emptyContainerCell)
        self.tableView.register(UINib.init(nibName: filledCell, bundle: nil), forCellReuseIdentifier: filledCell)
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
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

extension RestrauntVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedOutlet?.deliveries[0].deliveryDisplayModes.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row<4) {
            let cell : EmptyContainerCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: emptyContainerCell, for: indexPath) as! EmptyContainerCellTableViewCell
            cell.containeNameLbl?.text = selectedOutlet?.deliveries[0].deliveryDisplayModes[indexPath.row].displayName
            return cell
        }
        else {
            let cell : FilledCell = tableView.dequeueReusableCell(withIdentifier: filledCell, for: indexPath) as! FilledCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row < 4) {
            return 70
        } else {
            return 118
        }
    }
}
