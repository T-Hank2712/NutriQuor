import Foundation
import Combine

@MainActor
final class SearchNutritionViewModel: ObservableObject {

    // MARK: - Search state
    @Published var isSearching: Bool = false

    @Published var query: String = "" {
        didSet {
            isSearching = !query.isEmpty
            applySearch()
        }
    }

    // MARK: - Data
    @Published var list: [SearchDTO] = []
    @Published var filteredList: [SearchDTO] = []
    @Published var detail: SearchDetailDTO?

    // MARK: - Services
    private let searchService = SearchService()
    private let nutrientService = NutrientAPIService()
    private let ingredientService = IngredientAPIService()
    private let additiveService = AdditiveAPIService()

    // MARK: - Load All
    func loadAll() async {
        do {
            let result = try await searchService.fetchAll()
            list = result

            if query.isEmpty {
                filteredList = result
            }

        } catch {
            print("Error loading data:", error)
        }
    }
    
    func loadDetail(id: String) async {
        do {
            detail = try await searchService.fetchDetail(id: id)
            print(detail ?? "")
        } catch {
            print("Error:", error)
        }
    }

    // MARK: - Load by category
    func loadByCategory(_ category: NutritionCategory) async {
        do {
            let data: [SearchDTO]

            switch category {
            case .all:
                await loadAll()
                return

            case .nutrient:
                data = try await nutrientService.fetchNutrients().map { $0.toSearchDTO() }

            case .ingredient:
                data = try await ingredientService.fetchIngredients().map { $0.toSearchDTO() }

            case .additive:
                data = try await additiveService.fetchAdditives().map { $0.toSearchDTO() }
            }

            list = data

            if query.isEmpty {
                filteredList = data
            } else {
                applySearch()
            }

        } catch {
            print("Error loading data:", error)
        }
    }

    // MARK: - Search
    func applySearch() {
        guard !query.isEmpty else {
            filteredList = list
            return
        }

        filteredList = list.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
}
