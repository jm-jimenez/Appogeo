import Foundation
import Alamofire

class EmbassiesAPIStore: EmbassiesStoreProtocol {
    func fetchAllEmbassies(completion: @escaping EmbassiesStoreFetchAllEmbassiesCompletionHandler) {
        
        guard let url = URL(string: "https://datos.madrid.es/egob/catalogo/201000-0-embajadas-consulados.json") else {
            completion(.failure(error: .FetchFailed("Invalid URL!")))
            return
        }
        AF.request(url).responseDecodable { (response: DataResponse<EmbassyList.GetEmbassies.Response>) in
            if let error = response.result.error {
                completion(.failure(error: .FetchFailed(error.localizedDescription)))
            } else if let data = response.result.value {
                let embassies = data.graph
                completion(.success(result: embassies))
            } else {
                completion(.failure(error: .FetchFailed("No data")))
            }
        }
    }
    
    func fetchEmbassiesWith(params: LocationSearch.Search.Request, completion: @escaping EmbassiesStoreFetchGeoEmbassies) {
        guard let url = URL(string: "https://datos.madrid.es/egob/catalogo/201000-0-embajadas-consulados.json") else {
            completion(.failure(error: .FetchFailed("Invalid URL!")))
            return
        }
        
        AF.request(url, method: HTTPMethod.get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil).responseDecodable { (response: DataResponse<LocationSearch.Search.Response>) in
            if let error = response.result.error {
                completion(.failure(error: .FetchFailed(error.localizedDescription)))
            } else if let data = response.result.value {
                let embassies = data.graph
                completion(.success(result: embassies))
            } else {
                completion(.failure(error: .FetchFailed("No data")))
            }
        }
    }
}
