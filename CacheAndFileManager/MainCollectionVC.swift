//
//  ViewController.swift
//  CacheAndFileManager
//
//  Created by Volodymyr D on 26.08.2022.
//

import UIKit

class MainCollectionVC: UICollectionViewController {
  
    private let strAdresses = [
        "https://ireland.apollo.olxcdn.com/v1/files/eyJmbiI6ImZlNGNpZ3JjbzlnejItT1RPTU9UT1BMIiwidyI6W3siZm4iOiJ3ZzRnbnFwNnkxZi1PVE9NT1RPUEwiLCJzIjoiMTYiLCJwIjoiMTAsLTEwIiwiYSI6IjAifV19.vShSQHGJv-x0w8fz7JBgpe7VdsH5BAxH5w9RK1lZ5Qg/image;s=1080x720",
        "https://ireland.apollo.olxcdn.com/v1/files/eyJmbiI6IjJoYnFoaTRramh0NzItT1RPTU9UT1BMIiwidyI6W3siZm4iOiJ3ZzRnbnFwNnkxZi1PVE9NT1RPUEwiLCJzIjoiMTYiLCJwIjoiMTAsLTEwIiwiYSI6IjAifV19.QbGeUzG3Bb9rsH9wZmsKp3u60wZX9Pyv7_1MMtePoRc/image;s=1080x720",
        "https://ireland.apollo.olxcdn.com/v1/files/eyJmbiI6IjQ1c212ZmZzdDlsZC1PVE9NT1RPUEwiLCJ3IjpbeyJmbiI6IndnNGducXA2eTFmLU9UT01PVE9QTCIsInMiOiIxNiIsInAiOiIxMCwtMTAiLCJhIjoiMCJ9XX0.o0HEvZMCfqjumsK-rrWIovhCbIZIp_h48ZmztrQEtdU/image;s=1080x720",
        "https://ireland.apollo.olxcdn.com/v1/files/eyJmbiI6ImNrdTA1N2J3MGltYzItT1RPTU9UT1BMIiwidyI6W3siZm4iOiJ3ZzRnbnFwNnkxZi1PVE9NT1RPUEwiLCJzIjoiMTYiLCJwIjoiMTAsLTEwIiwiYSI6IjAifV19.fq4WpKfsQlYn9HegQ9LyqpAQBWGbxb54MGEf7-NTet8/image;s=1080x720",
        "https://ireland.apollo.olxcdn.com/v1/files/eyJmbiI6InVqZTE3NGMyNDNwODMtT1RPTU9UT1BMIiwidyI6W3siZm4iOiJ3ZzRnbnFwNnkxZi1PVE9NT1RPUEwiLCJzIjoiMTYiLCJwIjoiMTAsLTEwIiwiYSI6IjAifV19.twc5FQSa7IzIWzF0c1lqFWIIiYcPZeAEUqJddsiDcDM/image;s=1080x720",
        "https://ireland.apollo.olxcdn.com/v1/files/eyJmbiI6IjViMjB5YXJiZTRwZjMtT1RPTU9UT1BMIiwidyI6W3siZm4iOiJ3ZzRnbnFwNnkxZi1PVE9NT1RPUEwiLCJzIjoiMTYiLCJwIjoiMTAsLTEwIiwiYSI6IjAifV19.7t-VqHa0I5zxezqtFZZNCkgPLX6bx_RnRuLJXe9vLn8/image;s=1080x720",
    ]
    
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        view = collectionView
        view.backgroundColor = .cyan
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavigationBar()
    }
    
    //MARK: - Metods
    private func configureCollectionView() {
        self.collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        let layout = (self.collectionViewLayout as! UICollectionViewFlowLayout)
        layout.itemSize = CGSize(width: (self.view.bounds.width / 3) - 1,
                                 height: self.view.bounds.width / 2)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
    }
     
    private func configureNavigationBar() {
        title = "Images from Web"
        let fileManAction = UIAction(title: "FileManager") { [weak self] _ in
            let vc = SaveImagesCollectionVC(vcType: .fileManager, collViewLayout: UICollectionViewFlowLayout())
            vc.title = "image from FileManager"
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        let coreDataAction = UIAction(title: "CoreData") { [weak self] _ in
            let vc = SaveImagesCollectionVC(vcType: .coreData, collViewLayout: UICollectionViewFlowLayout())
            vc.title = "image from CoreData"
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Storage",
            menu: UIMenu(identifier: .newScene,
                         options: .displayInline,
                         children: [fileManAction, coreDataAction])
        )
    }
 
}
 
extension MainCollectionVC {

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        strAdresses.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier,
                                                      for: indexPath) as! ImageCollectionViewCell
        cell.setItem(withAdress: strAdresses[indexPath.row])
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ImageViewController()
        vc.setItem(withAdress: strAdresses[indexPath.row])
        vc.title = "Bmw-\(indexPath.row)"
        vc.view.backgroundColor = view.backgroundColor
        navigationController?.pushViewController(vc, animated: true)
    }
  
}
