import Foundation

class DataStore: ObservableObject {
    @Published var preferences: [SliderItem] = SliderItem.previewData
    @Published var cities: [City] = City.previewData
    
    func createCity(_ city: City) {
        cities.append(city)
    }
    
    func removeCity(_ city: City) {
        if let index = cities.firstIndex(where: { $0.id == city.id }) {
          cities.remove(at: index)
        }
    }
    
    private static func fileURL() throws -> URL {
      try FileManager.default.url(for: .documentDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: false)
        .appendingPathComponent("cities.data")
    }
    
    static func load() async throws -> [City] {
      try await withCheckedThrowingContinuation { continuation in
        load { result in
          switch result {
          case .failure(let error):
            continuation.resume(throwing: error)
          case .success(let cities):
            continuation.resume(returning: cities)
          }
        }
      }
    }
    
    static func load(completion: @escaping (Result<[City], Error>)->Void) {
      DispatchQueue.global(qos: .background).async {
        do {
          let fileURL = try fileURL()
          guard let file = try? FileHandle(forReadingFrom: fileURL) else {
            DispatchQueue.main.async {
              //completion(.success([]))
              completion(.success(City.previewData)) // This is a hack to get us starting data. The above line is the actual code.
            }
            return
          }
          let cities = try JSONDecoder().decode([City].self, from: file.availableData)
          DispatchQueue.main.async {
            completion(.success(cities))
          }
        } catch {
          DispatchQueue.main.async {
            completion(.failure(error))
          }
        }
      }
    }
    
    @discardableResult
    static func save(cities: [City]) async throws -> Int {
      try await withCheckedThrowingContinuation { continuation in
        save(cities: cities) { result in
          switch result {
          case .failure(let error):
            continuation.resume(throwing: error)
          case .success(let citiesSaved):
            continuation.resume(returning: citiesSaved)
          }
        }
      }
    }
    
    static func save(cities: [City], completion: @escaping (Result<Int, Error>)->Void) {
      DispatchQueue.global(qos: .background).async {
        do {
          let data = try JSONEncoder().encode(cities)
          let outfile = try fileURL()
          try data.write(to: outfile)
          DispatchQueue.main.async {
            completion(.success(cities.count))
          }
        } catch {
          DispatchQueue.main.async {
            completion(.failure(error))
          }
        }
      }
    }
}
