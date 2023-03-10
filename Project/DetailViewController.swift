//
//  DetailViewController.swift
//  Project
//
//  Created by Lekhana on 1/12/23.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var selectedMovie : Result?
    
    let poster : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .red
        return label
    }()
    let overviewLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    let releaseDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    let button : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add to Favorite", for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        setupConstraint()
        loadContent()
    }
    
    func setupConstraint(){
        self.view.addSubview(poster)
        poster.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.height.equalTo(400)
            make.leading.trailing.equalToSuperview()
        }
        let holder = UIStackView(arrangedSubviews: [titleLabel, releaseDateLabel, overviewLabel])
        holder.spacing = 10
        holder.axis = .vertical
        self.view.addSubview(holder)
        
        holder.snp.makeConstraints{ make in
            make.top.equalTo(poster.snp_bottomMargin).offset(50)
            make.leading.equalTo(view.snp_leadingMargin).offset(20)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-20)
        }
        self.view.addSubview(button)
        button.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(80)
            make.bottom.equalToSuperview().offset(-80)
            make.trailing.equalToSuperview().offset(170)
            make.height.equalTo(20)
        }
    }
    
    func loadContent(){
        if let movie = selectedMovie {
            let imageLink = "https://image.tmdb.org/t/p/w185" + movie.backdropPath
            if let imageURL = URL(string: imageLink){
                
                poster.kf.setImage(with: imageURL)
            }
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
        }
    }
    
}

