class SignUpClientMutation {
  String get signupClient {
    return '''
      mutation SIGNUP_CLIENT_MUTATION (
        \$email: String!
        \$firstName: String!
        \$lastName: String!
        \$password: String!
        \$phoneNumber: String!
      ){
        signupClient(
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