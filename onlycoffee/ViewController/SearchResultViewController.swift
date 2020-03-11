//
//  SearchResultViewController.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    static let storyboard_id = "searchresult"

    @IBOutlet var collectionView: UICollectionView!
    var search_category = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = search_category + "の検索結果"
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "SearchResultsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchResultsCollectionViewCell")
        
    }


}


extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultsCollectionViewCell", for: indexPath) as! SearchResultsCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: ReviewViewController.storyboard_id) as! ReviewViewController
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
}


extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewの外周余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    // Cellのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize : CGFloat = self.collectionView.bounds.width / 3 - 3
        return CGSize(width: cellSize, height: cellSize)
    }
    
    // 行の最小余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    // 列の最小余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
