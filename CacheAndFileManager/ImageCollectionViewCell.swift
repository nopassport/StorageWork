//
//  ImageCollectionViewCell.swift
//  CacheAndFileManager
//
//  Created by Volodymyr D on 27.08.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { String(describing: self) }
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    //MARK: - Metods
    public func setItem(withAdress adress: String) {
        Networking.shared.getImage(from: adress) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image 
            }
        }
    }
    
    public func setItem(withImage image: UIImage) {
        imageView.image = image
    }
     
}
