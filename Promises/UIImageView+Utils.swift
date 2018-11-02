//
//  UIImageView+Utils.swift
//  Promises
//
//  Created by federico mazzini on 02/11/2018.
//  Copyright © 2018 Lateral View. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func setImage(withURL url: URL) {
        image = nil
        af_setImage(withURL: url)
    }
}
