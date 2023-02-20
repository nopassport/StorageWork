//
//  ViewController.swift
//  CacheAndFileManager
//
//  Created by Volodymyr D on 26.08.2022.
//

import UIKit

class MainCollectionVC: UICollectionViewController {
  
    private let strAdresses = [
        "https://images.pexels.com/photos/1545743/pexels-photo-1545743.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/1805053/pexels-photo-1805053.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/3166786/pexels-photo-3166786.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/7466280/pexels-photo-7466280.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/12330344/pexels-photo-12330344.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/9470920/pexels-photo-9470920.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
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
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { strAdresses.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier,
                                                      for: indexPath) as! ImageCollectionViewCell
        cell.setItem(withAdress: strAdresses[indexPath.row])
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ImageViewController()
        vc.setImageView(withAdress: strAdresses[indexPath.row])
        vc.title = "Image-\(indexPath.row)"
        vc.view.backgroundColor = view.backgroundColor
        navigationController?.pushViewController(vc, animated: true)
    }
  
}
