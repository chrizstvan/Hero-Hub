//
//  HeroListService.swift
//  Hero Hub
//
//  Created by Chris on 27/09/21.
//

import Foundation

protocol IHeroService {
    func requestHeroList(completion: ((Result<[Hero], ErrorResult>) -> Void)?)
}

struct HeroListService: IHeroService {
    private var api: BaseAPIService = BaseAPIService()
    
    func requestHeroList(completion: ((Result<[Hero], ErrorResult>) -> Void)?) {
        let urlString = Endpoint().path
        api.request(urlString: urlString, completion: completion)
    }
}
