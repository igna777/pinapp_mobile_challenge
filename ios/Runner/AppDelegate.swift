import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: "comments", binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler { (call, result) in
            if call.method == "getComments" {
                guard let args = call.arguments as? [String: Any],
                      let postId = args["postId"] as? Int else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "postId es inválido", details: nil))
                    return
                }
                self.fetchComments(postId: postId, result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func fetchComments(postId: Int, result: @escaping FlutterResult) {
        let apiUrl = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
        guard let url = URL(string: apiUrl) else {
            result(FlutterError(code: "URL_ERROR", message: "URL inválida", details: nil))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                result(FlutterError(code: "NETWORK_ERROR", message: "Error de red: \(error.localizedDescription)", details: nil))
                return
            }

            guard let data = data else {
                result(FlutterError(code: "NO_DATA", message: "No se recibió respuesta del servidor", details: nil))
                return
            }

            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                let comments = jsonArray?.map { obj in
                    return [
                        "name": obj["name"] as? String ?? "Sin nombre",
                        "email": obj["email"] as? String ?? "Sin email",
                        "body": obj["body"] as? String ?? "Sin comentario"
                    ]
                }
                result(comments)
            } catch {
                result(FlutterError(code: "JSON_ERROR", message: "Error al parsear JSON", details: nil))
            }
        }
        task.resume()
    }
}
