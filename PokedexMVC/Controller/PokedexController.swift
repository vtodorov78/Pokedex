//
//  PokedexController.swift
//  PokedexMVC
//
//  Created by Vladimir Todorov on 25.05.21.
//

import UIKit


class PokedexController: UICollectionViewController {
    
    // MARK: - Properties

    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    let searchBar = UISearchBar()
    
    lazy var popupView: PokemonPopUpView = {
        let view = PokemonPopUpView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        fetchPokemon()
        
    }
    
    
    // MARK: - Selectors
    
    @objc func showSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - API
    
    func fetchPokemon() {
        Service.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        collectionView.backgroundColor = .white
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        navigationController?.navigationBar.barTintColor = .mainPink()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Pokedex"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        showSearchBarButton(shouldShow: true)
        
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: PokedexCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha  = 0
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissal)))
    }
    
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
            searchBar.showsCancelButton = false
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    func handleShowPopUp() {
        showSearchBarButton(shouldShow: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(popupView)
        popupView.center(inView: view)
        popupView.heightAnchor.constraint(equalToConstant: view.frame.width + 80).isActive = true
        popupView.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        popupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popupView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
        }
    }
}
 
extension PokedexController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredPokemon.count : pokemon.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokedexCell.reuseIdentifier, for: indexPath) as! PokedexCell
        
        if inSearchMode {
            let filteredPokemon = filteredPokemon[indexPath.item]
            cell.nameLabel.text = filteredPokemon.name?.capitalized
            
            if let imgUrl = filteredPokemon.imageUrl {
                cell.imageView.downloaded(from: imgUrl)
            }
        } else {
            let pokemon = pokemon[indexPath.item]
            cell.nameLabel.text = pokemon.name?.capitalized
            
            if let imgUrl = pokemon.imageUrl {
                cell.imageView.downloaded(from: imgUrl)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemon[indexPath.item]
        handleShowPopUp()
        popupView.nameLabel.text = pokemon.name?.capitalized
        if let imgUrl = pokemon.imageUrl {
        popupView.imageView.downloaded(from: imgUrl)
        }
        popupView.typeLabel.text = "Type: \(pokemon.type ?? "N/A")"
        popupView.heightLabel.text = (String(format: "Height: %d", pokemon.height!))
        popupView.weightLabel.text = (String(format: "Weight: %d", pokemon.weight!))
    }
    
}

extension PokedexController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 36)/3
        return CGSize(width: width, height: width)
    }
}

extension PokedexController: PopUpDelegate {
    
   @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popupView.alpha = 0
            self.popupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popupView.removeFromSuperview()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.showSearchBarButton(shouldShow: true)
        }
    }
}

extension PokedexController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredPokemon = pokemon.filter({ $0.name?.range(of: searchText.lowercased()) != nil })
            collectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
}
