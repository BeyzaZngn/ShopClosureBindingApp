//
//  APIService.swift
//  ShopClosureBindingApp
//
//  Created by Beyza Zengin on 27.09.2025.
//

import Foundation

final class APIService {
    static let shared = APIService()
    private init() {}
    
    /*
     shared → uygulamanın her yerinden aynı servis nesnesine erişmemizi sağlar.
     Yani başka yerde APIService.shared yazarsan hep aynı örnek kullanılır.
     
     Singleton tasarım deseninde amaç → uygulama boyunca tek bir örnek olsun.
     
     Bunu sağlamak için:
     static let shared → tek ve ortak bir örnek yaratır.
     private init() → dışarıdan APIService() ile yeni nesne oluşturmayı engeller.
     
     Bu ikisi birleşince → APIService.shared ile uygulamanın her yerinde aynı nesneyi kullanırsın.
     */
    
    private let baseURL = "https://api.escuelajs.co/api/v1/products"
    
    /*
     API’nin temel URL’si.
     Biz ürünleri çekeceğimiz için /products endpoint’ini kaydediyoruz.
     private → sadece bu sınıf içinde kullanılabilir.
     */
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        
        /*
         •    func fetchProducts → ürünleri getiren fonksiyon.
         •    completion → bir callback (geri dönüş fonksiyonu).
         •    @escaping → bu closure, fonksiyon bitse bile daha sonra çağrılabilecek (asenkron).
         •    Result<[Product], Error> →
         •    Başarılı olursa bize [Product] (ürün listesi) döner.
         •    Hata olursa Error döner.
         */
        
        guard let url = URL(string: baseURL) else { return }
        
        /*
         •    URL(string: baseURL) → metin halindeki URL’yi gerçek bir URL nesnesine çeviriyoruz.
         •    guard let → eğer URL oluşmazsa (örneğin yanlış formatlıysa), fonksiyondan çık.
         */
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            // dataTask(with: url) → verilen URL’ye GET isteği gönderir.
            // _ → HTTP yanıtı (biz burada kullanmıyoruz).
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
            
            /*
             •    JSONDecoder().decode([Product].self, from: data) →
             •    Gelen JSON’u Product modeline çeviriyoruz.
             •    [Product].self → JSON dizisini Product listesine dönüştür anlamına geliyor.
             •    Eğer başarılı olursa → completion(.success(products)) döner.
             •    Hata olursa → completion(.failure(error)) döner.
             */
            
        }.resume() // dataTask başta hazırda bekler, .resume() çağırmazsak çalışmaz, Burada isteği gerçekten başlatıyoruz.
    }
}

