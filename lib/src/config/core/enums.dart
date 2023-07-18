//||... enum for message type ...||
enum MessageType { failureMessage, successMessage }

//||... enum for images selection type ...||
enum ImageSelectionMode { single, multiple }

//||... enum for datasource ...||
enum Datasource { local, remote }

//||... enum for app opened by  ...||
enum AppOpenedBy {
  user,
  dynamicLink,
  notification,
}

//||... enum for custom error type  ...||
enum CustomErrorType {
  server,
  notFound,
  noInternetConnection,
  unknown,
}
