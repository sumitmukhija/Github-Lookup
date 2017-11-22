//
//  TileCollectionViewHandler.swift
//  Github Lookup
//
//  Created by Sumit on 11/20/17.
//  Copyright © 2017 Sumit Mukhija. All rights reserved.
//

import UIKit

extension SearchViewController
{
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row
        {
        case 0:
            self.tabBarController?.selectedIndex = 2
            break
        case 1:
            self.tabBarController?.selectedIndex = 1
            break
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tilesTitle.count
    }
    
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIERS.TILE_COLLECTION_CELL, for: indexPath) as! TileCollectionViewCell
        cell.wrapperView.backgroundColor = colors[indexPath.row]
        switch(indexPath.row)
        {
        case 0:
            cell.lblNumber.text = "\(UserDefaultsHelper.getSearchCount())"
            break
        case 1:
            cell.lblNumber.text = "\(UserDefaultsHelper.getSavedCount())"
            break
        case 2:
            cell.lblNumber.text = "\(UserDefaultsHelper.getViewedCount())"
            break
        default:
            cell.lblNumber.text = "0"
        }
        
        cell.lblText.text = tilesTitle[indexPath.row]
        return cell
    }
    
    @objc(collectionView:layout:sizeForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 50)
    }
    
}
