import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import Dispatch
import KituraOpenAPI

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()
    let workerQueue = DispatchQueue(label: "worker")

    public init() throws {
        // Run the metrics initializer
        
        Log.info("Hello World")
        initializeMetrics(router: router)
    }

    func postInit() throws {
        // Endpoints
        initializeRawRoutes(app: self)
        initializeCodableRoutes(app: self)
        initializeHealthRoutes(app: self)
        KituraOpenAPI.addEndpoints(to: router)
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
    
    func execute(_ block: (() -> Void)) {
        workerQueue.sync {
            block()
        }
    }
}
