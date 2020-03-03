//
//  TestViewController.swift
//  CloseUp
//
//  Created by Maksim Torburg on 03.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ContactCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ContactCell")
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.frame = view.frame
    }

}

extension TestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell", for: indexPath)
        guard let cell = dequedCell as? ContactCell else {
            print("Can't create reusable Cell")
            return dequedCell
        }
        cell.label.text = "\(indexPath)"
        cell.label.textColor = .white
//        cell.contentView.backgroundColor = .white
        cell.contentView.backgroundColor = UIColor(red: getColor(), green: getColor(), blue: getColor(), alpha: 1)
        return cell
    }
    
    
}

extension TestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70.0, height: 70.0)
    }
}

//func getColor() -> CGFloat{
//    return CGFloat(arc4random_uniform(256)) / 255.0
//}
