class AppException implements Exception{

}

class FeatureException extends AppException{}

class NoQuestionFound extends FeatureException{}

class UnknownException extends AppException{}

class NoNetworkException extends AppException{}