//
//  FirstTabVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit

class FirstTabVC: UIViewController {
   
    @IBOutlet weak var messagetable: UITableView!
    @IBOutlet weak var newMatchColloction: UICollectionView!
    
    let imgCollection = [UIImage(named: "newMatch"),UIImage(named: "newMatch2"),UIImage(named: "newMatch3"),UIImage(named: "newMatch4"),UIImage(named: "newMatch5"),UIImage(named: "background")]
    let collName = ["Anita","Reshma","Roma","Yami","Priti","Test"]
    let imgTable = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8")]
    let tableName = ["Anika","Sherya","Lilly","Mona","Sonia","Monika","Katrina","Kiran"]
    let message = ["Hello","hii","How are you","Where you  live?","lets meet on coffee","Yes offcource","No we can't","Let's do this"]
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
}

class MessageTable: UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageTable: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageCount: UILabel!
}

class NewCollection: UICollectionViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgColl: UIImageView!
}


// MARK:- EXTENSION

extension FirstTabVC: UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return imgTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagetable.dequeueReusableCell(withIdentifier: "cell") as! MessageTable
        cell.imageTable.image = imgTable[indexPath.row]
        cell.nameLabel.text = tableName[indexPath.row]
        cell.messageLabel.text = message[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newMatchColloction.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewCollection
        cell.imgColl.image = imgCollection[indexPath.item]
        cell.nameLabel.text = collName[indexPath.item]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ChatVC") as! ChatVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: newMatchColloction.frame.width/4.5, height: newMatchColloction.frame.height/0.5)
    }
}
