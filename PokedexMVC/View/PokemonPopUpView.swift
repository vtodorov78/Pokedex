//
//  PokemonPopUpView.swift
//  PokedexMVC
//
//  Created by Vladimir Todorov on 7.06.21.
//

import UIKit

protocol PopUpDelegate {
    func handleDismissal()
}

class PokemonPopUpView: UIView {

    // MARK: - Properties
    
    var pokemon: Pokemon?
    var delegate: PopUpDelegate?
    
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    let attackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    let defenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    let moreInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("View More Info", for: .normal)
        button.backgroundColor = .mainPink()
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [typeLabel, attackLabel, defenceLabel])
        return stack
    }()

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    func configurePopUp(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name?.capitalized
        
        if let imgUrl = pokemon.imageUrl {
            imageView.downloaded(from: imgUrl)
        }
        typeLabel.text = "Type: \(pokemon.type?.capitalized ?? "N/A")"
        let attributedType = NSMutableAttributedString(string: typeLabel.text ?? "N/A")
        attributedType.addAttribute(.foregroundColor, value: UIColor.mainPink(), range: NSRange(location: 0, length: 5))
        typeLabel.attributedText = attributedType
        
        attackLabel.text = (String(format: "Attack: %d", pokemon.attack ?? "NA"))
        let attributedHeight = NSMutableAttributedString(string: attackLabel.text ?? "N/A")
        attributedHeight.addAttribute(.foregroundColor, value: UIColor.mainPink(), range: NSRange(location: 0, length: 7))
        attackLabel.attributedText = attributedHeight
        
        defenceLabel.text = (String(format: "Defence: %d", pokemon.defense ?? "NA"))
        let attributedWeight = NSMutableAttributedString(string: defenceLabel.text ?? "N/A")
        attributedWeight.addAttribute(.foregroundColor, value: UIColor.mainPink(), range: NSRange(location: 0, length: 7))
        defenceLabel.attributedText = attributedWeight
    }
    
    func configureViewComponents() {
    
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.mainPink().cgColor
        self.clipsToBounds = true
        
        addSubview(nameContainerView)
        nameContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        addSubview(imageView)
        imageView.anchor(top: nameContainerView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 25, paddingLeft: 120, paddingBottom: 0, paddingRight: 120, width: 0, height: 100)
        
       addSubview(moreInfoButton)
        moreInfoButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 50)
        
        addSubview(stack)
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        stack.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: moreInfoButton.topAnchor, right: rightAnchor, paddingTop: 70, paddingLeft: 0, paddingBottom: 70, paddingRight: 0, width: 0, height: 0)
        
    }
    
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
    

}
