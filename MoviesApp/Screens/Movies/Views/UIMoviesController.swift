//
//  UIMoviesController.swift
//  MoviesApp
//
//  Created by Mohannad on 29/01/2024.
//

import UIKit

final class UIMoviesController: UIBaseViewController<MoviesViewModel> {
    let padding : CGFloat = 12
    
    lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = .primaryColor
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.accessibilityIdentifier = "MovieCollectionView"
        return collection
    }()
    
    lazy var collectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .primaryColor
        view.addSubview(collectionView)
        setupCollection()
        setupViewsConstraints()
        setupCollectionCellSize()
    }
    
    private func setupCollection(){
        collectionView.register(UIMovieCell.self, forCellWithReuseIdentifier: String(describing: UIMovieCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupCollectionCellSize(){
        let width = (UIScreen.main.bounds.width)
        let hieght = (UIScreen.main.bounds.height) / 4
        collectionViewLayout.itemSize = CGSize(width: width , height: hieght)
    }
    
    private func setupViewsConstraints(){
        collectionView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
    }
}

extension UIMoviesController: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UIMovieCell.self), for: indexPath) as! UIMovieCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  let selected = viewModel.movies.value[indexPath.row]
       // coordinator?.showDetails(with: selected)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width )
        let hieght = (collectionView.frame.height) / 4
        return CGSize(width: width , height: hieght)
    }
}

