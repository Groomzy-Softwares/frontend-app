class SignUpProviderMutation {
  String get signupProvider {
    return '''
      mutation SIGNUP_PROVIDER_MUTATION (
        \$email: String!
        \$firstName: String!
        \$lastName: String!
        \$password: String!
        \$phoneNumber: String!
      ){
        signupProvider(
          email: \$email
          firstName: \$firstName
          lastName: \$lastName
          password: \$password
          phoneNumber: \$phoneNumber
        ){
          message
        }
      }
    ''';
  }
}