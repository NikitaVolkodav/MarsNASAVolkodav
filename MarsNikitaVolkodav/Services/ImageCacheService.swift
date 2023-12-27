import UIKit

final class ImageCacheService {
    private let imageCache = NSCache<NSString, UIImage>()
    
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            guard let self = self, let imageData = data, let image = UIImage(data: imageData)  else {
                 completion(nil)
                 return
             }
            imageCache.setObject(image, forKey: url.absoluteString as NSString)
            completion(image)
        } .resume()
    }
}
