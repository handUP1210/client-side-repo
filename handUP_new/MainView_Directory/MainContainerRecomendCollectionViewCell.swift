//
//  MainContainerRecomendCollectionViewCell.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/05.
//  Copyright © 2020 김재석. All rights reserved.
//

import UIKit

class MainContainerRecomendCollectionViewCell: UICollectionViewCell {
    
}

extension MainContainerRecomendCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainContainerRecomendContentsCollectionViewCell", for: indexPath) as? MainContainerRecomendContentsCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension MainContainerRecomendCollectionViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = CGFloat(integerLiteral: 170)
        var height = CGFloat(integerLiteral: 170)
        return CGSize(width: width, height: height)
    }
    
}


class MainContainerRecomendContentsCollectionViewCell: UICollectionViewCell{
    
}
