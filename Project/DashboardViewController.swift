//
//  TableDemoViewController.swift
//  task1
//
//  Created by Lekhana on 10/29/22.
//

import UIKit
import Kingfisher
import SnapKit

class DashboardViewController: UIViewController {
    
    
    var movies : [Result] = []

    let tableVIew : UITableView = {
            let table = UITableView()
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()
    
    let mainTitle : UILabel = {
         let mLabel1 = UILabel()
         mLabel1.translatesAutoresizingMaskIntoConstraints = false
         mLabel1.font = .systemFont(ofSize: 40, weight: .thin)
         mLabel1.textAlignment = .left
         mLabel1.textColor = .systemPink
         return mLabel1
    }()
    
    

        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .white
            mainTitle.text = "Welcome"
            tableVIew.delegate = self
            tableVIew.dataSource = self
            tableVIew.register(MyCellView.self, forCellReuseIdentifier: "cell")
            view.addSubview(tableVIew)
            setupConstraint()
            makeConstraints()
            
            downloadMovies()
        }
    
    func setupConstraint(){
//        mainTitle.snp.makeConstraints{ make1 in
//            make1.top.equalToSuperview().offset(-30)
//            make1.leading.equalToSuperview().offset(30)
//            make1.trailing.equalToSuperview().offset(-20)
//        }
    }
        
        func makeConstraints() {

            tableVIew.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            tableVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            tableVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            tableVIew.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    
    func downloadMovies(){
        let url = URL(string: "https://api.themoviedb.org/4/list/3?page=1&api_key=f9923821f549f034afb399cd27e37afd")!
        
        let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, res, error in
            
            if let movieData = data {
                let json = try? JSONDecoder().decode(MovieModel.self, from: movieData)
                if let movies = json?.results {
                    self.movies = movies
                }
                DispatchQueue.main.async {
                    self.tableVIew.reloadData()
                }
            }
        }
        dataTask.resume()
    }
        
        

    }

    extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = UITableViewCell(style: .subtitle , reuseIdentifier: "cell")
//            return cell
            
            let cell : MyCellView = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCellView
//            cell.myImage.image = UIImage(named: "logo")
            cell.titleLabel.text = movies[indexPath.row].originalTitle
//            cell.descriptionLabel.text = "IOS Application Development"
            cell.descriptionLabel.text = movies[indexPath.row].releaseDate
            
            let imageURL = "https://image.tmdb.org/t/p/w185" + movies[indexPath.row].backdropPath
            if let url = URL(string: imageURL){
                cell.myImage.kf.setImage(with: url)
            }
            return cell

            
            //dequeueReusableCell - it can reuse in same cell by injecting data
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat {
            return 130
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            let vc = DetailViewController()
            vc.selectedMovie = movies[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

class MyCellView : UITableViewCell{
    
    let baseView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 0.5
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowColor = UIColor.black.cgColor
        return view
    }()
    
    let titleLabel : UILabel = {
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.font = .systemFont(ofSize: 18, weight: .bold)
        label1.textColor = .red
        return label1
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .blue
        return label
    }()
    
    let myImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let labelHolder : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let contentHolder : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layComponent()
        setupConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented!")
    }
    
    
    
    func layComponent(){
        labelHolder.addArrangedSubview(titleLabel)
        labelHolder.addArrangedSubview(descriptionLabel)
        contentHolder.addArrangedSubview(myImage)
        contentHolder.addArrangedSubview(labelHolder)
        baseView.addSubview(contentHolder)
        contentView.addSubview(baseView)
    }
    
    private func setupConstraints(){
        
        baseView.snp.makeConstraints {make in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
        
        myImage.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(80)
        }
        
    }
}

