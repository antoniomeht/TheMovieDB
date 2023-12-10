//
//  Extension+UIImageView.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import UIKit

extension UIImageView {
    func setImageFromURL(_ imageURL: URL?) {
      if let url = imageURL {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          guard let imageData = data else { return }

          DispatchQueue.main.async {
              self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
}
