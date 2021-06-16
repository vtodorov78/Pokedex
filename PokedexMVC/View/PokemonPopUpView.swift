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
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "POKEMON"
        label.textAlignment = .center
        label.textColor = .mainPink()
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "POKEMON"
        label.textAlignment = .center
        label.textColor = .mainPink()
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "POKEMON"
        label.textAlignment = .center
        label.textColor = .mainPink()
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
        let stack = UIStackView(arrangedSubviews: [typeLabel, heightLabel, weightLabel])
        return stack
    }()

    
    var delegate: PopUpDelegate?
    
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
    
    func configureViewComponents() {
    
        self.layer.cornerRadius = 10
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
