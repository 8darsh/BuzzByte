//
//  ViewController.swift
//  BuzzByte
//
//  Created by Adarsh Singh on 13/11/23.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configuration()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.news?.articles?.count ?? 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionViewCell
        cell.author.text = viewModel.news?.articles?[indexPath.row].author ?? ""
        cell.newsDescription.text = viewModel.news?.articles?[indexPath.row].description ?? ""
//        cell.newsImage.setImage(with: ((((viewModel.news?.articles?[indexPath.row].urlToImage) ?? URL(string: "")) ?? URL(string: ""))!) )
        cell.newsHeadline.setTitle(viewModel.news?.articles?[indexPath.row].title ?? "", for: .normal)
        cell.newsHeadline.addTarget(self, action: #selector(fullNewsViewer), for: .touchUpInside)
        return cell
        
    }
    
    @objc func fullNewsViewer(){
        
    }
    
}
extension ViewController{
    
    func configuration(){
        
        initViewModel()
        observeEvent()
        
    }
    
    func initViewModel(){
        viewModel.fetchdata()
    }
    
    func observeEvent(){
        
        viewModel.eventHandler = {
            [weak self] event in
            guard let self else {return}
            
            
            switch event{
                
            case .loading:
                print("Loading")
            case .stopLoading:
                print("stop loading")
            case .dataLoaded:
                print("data loaded")
                print(viewModel.news?.articles)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

