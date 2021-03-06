//
//  KIngFisherManager.swift
//  test
//
//  Created by Егор Шкарин on 07.01.2022.
//

import Foundation
import Kingfisher

final class KingFisherManager {
    static func setupResourceForCache(url: URL?) -> ImageResource? {
        guard let url = url else {
            return nil
        }
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        return resource
    }
}
