//
//  ViewController.swift
//  BuzzByte
//
//  Created by Adarsh Singh on 13/11/23.
//

import UIKit
import SafariServices
class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,SFSafariViewControllerDelegate {
    
    var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        configuration()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("CollectionView Frame: \(collectionView.frame)")
        print("CollectionView Bounds: \(collectionView.bounds)")
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.news?.articles?.count ?? 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionViewCell
        cell.author.text = viewModel.news?.articles?[indexPath.row].author ?? ""
        cell.newsDescription.text = viewModel.news?.articles?[indexPath.row].description ?? ""
        let urlString = (viewModel.news?.articles?[indexPath.row].urlToImage)?.absoluteString
        cell.newsImage.setImage(with: urlString ?? "hehe")
        cell.newsImage.layer.cornerRadius = 15
        cell.newsHeadline.setTitle(viewModel.news?.articles?[indexPath.row].title ?? "", for: .normal)
        cell.newsHeadline.tag = indexPath.row
        cell.newsHeadline.addTarget(self, action: #selector(fullNewsViewer), for: .touchUpInside)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width
                      , height:self.collectionView.frame.height )
    }
    


    
    @objc func fullNewsViewer(sender: UIButton){
        
        if let url = URL(string: viewModel.news?.articles?[sender.tag].url?.absoluteString ?? "hehe"){
            let request = SFSafariViewController(url: url)
            request.delegate = self
            present(request,animated: true)
            
        }
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
               
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

