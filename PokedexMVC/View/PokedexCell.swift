//
//  PokedexCell.swift
//  PokedexMVC
//
//  Created by Vladimir Todorov on 26.05.21.
//

import UIKit

protocol PokedexCellDelegate {
    func presentPopUpView(withPokemon pokemon: Pokemon)
}

class PokedexCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "PokedexCell"
    
    var delegate: PokedexCellDelegate?
    
    var pokemon: Pokemon? {
        didSet {
            if let imgUrl = pokemon?.imageUrl {
                imageView.downloaded(from: imgUrl)
            }
            nameLabel.text = pokemon?.name?.capitalized
        }
    }

    
    let imageView: CustomUIImageView = {
        let imageView = CustomUIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPink()
        view.addSubview(nameLabel)
        nameLabel.center(inView: view)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            guard let pokemon = self.pokemon else {
                print("PEZA E BRAT")
                return }
            delegate?.presentPopUpView(withPokemon: pokemon)
        }
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {

        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2.5
        self.layer.borderColor = UIColor.mainPink().cgColor
        self.clipsToBounds = true
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.frame.height - 32)
        
        addSubview(nameContainerView)
        nameContainerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 32)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
}
