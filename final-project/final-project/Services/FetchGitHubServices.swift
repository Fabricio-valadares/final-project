import Foundation
import Alamofire

enum FetchGitHubError: Error {
    case invalidURL
}


class FetchGitHubServices: FetchGitHubProtocol {
    func fetchAll(_ completion: @escaping (Result<[Item], Error>) -> Void) {
        guard let url = URL(string:"https://api.github.com/search/repositories?q=stars:%3E=10000+language:swift&sort=stars&order=desc" )else {
            completion(.failure(FetchGitHubError.invalidURL))
            return
        }
        
        AF.request(url,method: .get).validate().responseDecodable(of: GitHub.self){
            response in
            
            guard let repos = response.value else {return}
            
            completion(.success(repos.items))
        }
        
    }
}
