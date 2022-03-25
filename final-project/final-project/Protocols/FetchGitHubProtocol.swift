import Foundation


protocol FetchGitHubProtocol {
    func fetchAll(_ completion: @escaping(Result<[Item],Error>)->Void)
}
