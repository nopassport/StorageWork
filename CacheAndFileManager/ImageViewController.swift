//
//  ImageViewController.swift
//  CacheAndFileManager
//
//  Created by Volodymyr D on 27.08.2022.
//

import UIKit

class ImageViewController: UIViewController {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigationBar()        
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(origin: view.safeAreaLayoutGuide.layoutFrame.origin ,
                                 size: CGSize(width: view.bounds.width,
                                              height: view.bounds.height / 2))
    }
    
    //MARK: - Metods
    public func setItem(withAdress adress: String){
        Networking.shared.getImage(from: adress) { [weak self] image in
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSaveButton))
    }
    
    //MARK: - Actions
    @objc private func didTapSaveButton() {
        let alertContr = UIAlertController(title: "Save Image",
                                           message: "save to",
                                           preferredStyle: .alert)
        let fileManagAction = UIAlertAction(title: "fileManager",
                                            style: .default) { [weak self] _ in
            FileManag.shared.save(image: self?.imageView.image, withName: self?.title)
        }
        let coreDataAction = UIAlertAction(title: "CoreData",
                                           style: .default) { [weak self] _ in
            CoreDataManager.shared.save(image: self?.imageView.image)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertContr.addAction(fileManagAction) 
        alertContr.addAction(coreDataAction)
        alertContr.addAction(cancelAction)
        present(alertContr, animated: true)
    }
     
}
