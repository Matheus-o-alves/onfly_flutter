enum DomainError { unexpected, invalidCredentials, acessDenied }

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.acessDenied:
        return 'Credenciais inválidas.';
    
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
