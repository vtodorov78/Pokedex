//
//  PokemonInfoController.swift
//  PokedexMVC
//
//  Created by Vladimir Todorov on 16.06.21.
//

import UIKit

class PokemonInfoController: UIViewController {
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    var pokemonEvoArray = [Pokemon]()
    var evolutionIds = [Int]()
    
    let imageView: CustomUIImageView = {
        let imageView = CustomUIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var stack1: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [typeLabel, heightLabel, weightLabel])
        return stack
    }()
    
    let defenceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let baseAttackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var stack2: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [defenceLabel, idLabel, baseAttackLabel])
        return stack
    }()
    
    lazy var centerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPink()
        view.addSubview(centerContainerLabel)
        centerContainerLabel.center(inView: view)
        return view
    }()
    
    let centerContainerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureViewComponents()
    }
    
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
    
    
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: view.topAnchor, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 10, width: 0, height: 120)
        
        view.addSubview(stack1)
        stack1.axis = .vertical
        stack1.distribution = .equalSpacing
        stack1.spacing = 20
        stack1.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 10, paddingBottom: 0, paddingRight: 100, width: 0, height: 0)
        
        view.addSubview(stack2)
        stack2.axis = .vertical
        stack2.distribution = .equalSpacing
        stack2.spacing = 20
        stack2.anchor(top: descriptionLabel.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        view.addSubview(centerContainerView)
        centerContainerView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        centerContainerView.center(inView: view)
        
        title = pokemon?.name?.capitalized
        descriptionLabel.text = pokemon?.description
        if let imgUrl = pokemon?.imageUrl {
            imageView.downloaded(from: imgUrl)
        }
        typeLabel.text = "Type: \(pokemon?.type?.capitalized ?? "NA")"
        let attributedType = NSMutableAttributedString(string: typeLabel.text ?? "N/A")
        attributedType.addAttribute(.foregroundColor, value: UIColor.mainPink(), range: NSRange(location: 0, length: 5))
        typeLabel.attributedText = attributedType
        
        heightLabel.text = String(format: "Height: %d", pokemon?.height ?? "NA")
        let attributedHeight = NSMutableAttributedString(string: heightLabel.text ?? "N/A")
        attributedHeight.addAttribute(.foregroundColor, value: UIColor.mainPink(), range: NSRange(location: 0, length: 7))
        heightLabel.attributedText = attributedHeight
        
        weightLabel.text = String(format: "Weight: %d", pokemon?.weight ?? "NA")
        let attributedWeight = NSMutableAttributedString(string: weightLabel.text ?? "N/A")
        attributedWeight.addAttribute(.foregroundColor, value: UIColor.mainPink(), range: NSRange(location: 0, length: 7))
        weightLabel.attributedText = attributedWeight
        
        defenceLabel.text = String(format: "Defence: %d", pokemon?.defense ?? "NA")
        let attributedDefence = NSMutableAttributedString(string: defenceLabel.text ?? "N/A")
        attributedDefence.addAttribute(.foregroundColor, value: UIColor.mainPink(), range: NSRange(location: 0, length: 8))
        defenceLabel.attributedText = attributedDefence
        
        
        idLabel.text = String(format: "ID: %d", pokemon?.id ?? "NA")
        let attributedId = NSMutableAttributedString(string: idLabel.text ?? "N/A")
        attributedId.addAttribute(.foregroundColor, value: UIColor.mainPink(), range: NSRange(location: 0, length: 3))
        idLabel.attributedText = attributedId
        
        baseAttackLabel.text = String(format: "Attack: %d", pokemon?.attack ?? "NA")
        let attributedAttack = NSMutableAttributedString(string: baseAttackLabel.text ?? "N/A")
        attributedAttack.addAttribute(.foregroundColor, value: UIColor.mainPink(), range: NSRange(location: 0, length: 7))
        baseAttackLabel.attributedText = attributedAttack
        
        centerContainerLabel.text = pokemon?.type?.capitalized
    }
}
