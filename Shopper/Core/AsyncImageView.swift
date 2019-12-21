import UIKit

class AsyncImageView: UIImageView {
    
    private var downloadTask: URLSessionTask?
    
    func setURL(url: String) {
        guard let url = urlFromString(url) else {
            return
        }
        
        clearImage()
        cancelOngoingDownload()
        
        let downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.setImage(data: data)
        }

        downloadTask.resume()
        
        self.downloadTask = downloadTask
    }
    
    private func urlFromString(_ url: String) -> URL? {
        guard let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return nil
        }
        guard let url = URL(string: encodedUrl) else {
            return nil
        }
        return url
    }
    
    private func cancelOngoingDownload() {
        if let downloadTask = self.downloadTask, downloadTask.state != URLSessionTask.State.completed  {
            downloadTask.cancel()
        }
    }
    
    private func setImage(data: Data?) {
        guard let data = data else {
            return
        }
        DispatchQueue.main.async {
            self.image = UIImage(data: data)
        }
    }
    
    private func clearImage() {
        DispatchQueue.main.async {
            self.image = nil
        }
    }

}
