class ProvidersQuery {
  String get providers {
    return '''
      query PROVIDERS_QUERY(
        \$search: String
        \$category: String
      ) {
        providers(
          search: \$search
          category: \$category
        ){
          id
          email
          fullName
          address {
            address
            latitude
            longitude
          }
          dayTimes {
            day {
              day
            }
            time {
              startTime
              endTime
            }
          }
          bookings {
            bookingTime
            rating {
              rate
            }
            service {
              duration
              durationUnit
            }
          }
          serviceProviderCategories {
            category {
              category
            }
            service {
              id
              description
              duration
              durationUnit
              inHouse
              price
              title
            }
          }
          staffs {
            id
            fullName
          }
        }
      }
    ''';
  }
}